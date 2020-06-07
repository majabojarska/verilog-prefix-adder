WARNINGS = '-Wall'
VERILOG_VERSION = '2012'
QFLOW_TECH = 'osu018'
QFLOW_TARGET_MODULE = 'prefix_adder'

all: clean
	make run_test && make qflow_custom

######## Qflow

qflow_custom: qflow_dirs
	qflow clean --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow synthesize --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow place --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow sta --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow buffer --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow route --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow sta --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow migrate --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow drc --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow lvs --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow gdsii --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)
	qflow clean --tech $(QFLOW_TECH) $(QFLOW_TARGET_MODULE)

qflow_display:
	qflow display $(QFLOW_TARGET_MODULE)

qflow_dirs:
	mkdir -p synthesis layout log reports

######## Unit tests

run_tb: run_tb_prefix_adder run_tb_pg run_tb_pg_in run_tb_prefix_node

run_test: clean run_tb
	pytest -n auto

test_dir: 
	mkdir -p test;
   
run_tb_prefix_adder: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/prefix_adder.out tb_prefix_adder.v 

run_tb_pg: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/pg.out tb_pg.v

run_tb_pg_in: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/pg_in.out tb_pg_in.v

run_tb_prefix_node: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/prefix_node.out tb_prefix_node.v

######## Unit tests

create_venv: clean_venv
	virtualenv --python=python3 venv
	./venv/bin/pip install -r requirements-test.txt

clean_venv:
	rm -rf venv	

######## Cleaning

clean_test:
	cd test;\
	rm -f *.out;\
	rm -rf .pytest_cache __pycache__

clean_qflow:
	rm -rf synthesis/* log/* layout/* reports/*
	rm -f qflow_vars.sh project_vars.sh qflow_exec.sh
	rm -f source/*.ys

clean: clean_test clean_qflow
