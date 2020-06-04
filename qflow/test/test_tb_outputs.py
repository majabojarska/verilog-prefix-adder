import json
from pathlib import Path
from subprocess import Popen, PIPE

import pytest


def get_path_rel_to_module(path: str):
    return str((Path(__file__).parent / path).resolve())


def get_data_from_tb_out(tb_out_path: str):
    abs_bin_path = str(Path(tb_out_path).resolve())
    proc = Popen(abs_bin_path, stdout=PIPE, stdin=PIPE)
    stdout, stderr = proc.communicate()
    stdout_str = stdout.decode("utf-8")
    lines = stdout_str.replace("'", '"').split("\n")
    data = []
    for line in lines[0 : len(lines) - 2]:
        next_data = json.loads(line)
        data.append(next_data)

    parsed_data = parse_data(data)

    return parsed_data


def parse_data(data):
    for entry in data:
        for key in entry:
            if key == "time" in entry:
                base = 10
            else:
                base = 2
            entry[key] = int(entry[key], base=base)
    return data


#
# def prep_data_for_parametrization(data):
#     data_prepped = []
#     for entry in data:
#         data_prepped.append(tuple(value for key, value in entry if key != "time"))
#     return data_prepped


@pytest.fixture(scope="function")
def data_prefix_adder():
    return get_data_from_tb_out(get_path_rel_to_module("./prefix_adder.out"))


@pytest.fixture(scope="function")
def data_pg():
    return get_data_from_tb_out(get_path_rel_to_module("./pg.out"))


@pytest.fixture(scope="function")
def data_pg_in():
    return get_data_from_tb_out(get_path_rel_to_module("./pg_in.out"))


@pytest.fixture(scope="function")
def data_prefix_node():
    return get_data_from_tb_out(get_path_rel_to_module("./prefix_node.out"))


def test_prefix_adder(data_prefix_adder):
    for entry in data_prefix_adder:
        out_sum = entry["S"]
        arg_x = entry["X"]
        c_in = entry["c_in"]
        arg_y = entry["Y"]
        c_out = entry["c_out"]

        if out_sum != arg_x + arg_y + c_in:
            pytest.fail("Invalid sum: {}".format(entry))
        if c_out != out_sum - out_sum % 2 ** 6:
            pytest.fail("Invalid {}".format(entry))


def test_pg(data_pg):
    for entry in data_pg:
        arg_x = entry["x"]
        arg_y = entry["y"]
        prop = entry["prop"]
        gen = entry["gen"]

        if gen != arg_x & arg_y:
            pytest.fail("Invalid generation: {}".format(entry))
        if prop != arg_x ^ arg_y:
            pytest.fail("Invalid propagation: {}".format(entry))


def test_pg_in(data_pg_in):
    for entry in data_pg_in:
        arg_x = entry["x"]
        arg_y = entry["y"]
        arg_c_in = entry["c_in"]
        prop = entry["prop"]
        gen = entry["gen"]

        if not (gen == arg_x & arg_y | (arg_c_in & (arg_x | arg_y))):
            pytest.fail(
                "Invalid generation: x={}, y={}, c_in={}, g={}".format(
                    arg_x, arg_y, arg_c_in, gen
                )
            )
        if not (prop == arg_x ^ arg_y ^ arg_c_in):
            pytest.fail(
                "Invalid propagation: x={}, y={}, c_in={}, p={}".format(
                    arg_x, arg_y, arg_c_in, prop
                )
            )


def test_prefix_node(data_prefix_node):
    for entry in data_prefix_node:
        gen_high = entry["GH"]
        gen_low = entry["GL"]
        prop_high = entry["PH"]
        prop_low = entry["PL"]
        gen_out = entry["GOUT"]
        prop_out = entry["POUT"]

        if gen_out != gen_high | (prop_high & gen_low):
            pytest.fail("Invalid generation: {}".format(entry))
        if prop_out != prop_high & prop_low:
            pytest.fail("Invalid propagation: {}".format(entry))
