WARNINGS = '-Wall'
VERILOG_VERSION = '2012'

run_tb: run_tb_prefix_adder run_tb_pg run_tb_pg_in run_tb_prefix_node

test: clean run_tb
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

clean_test:
	cd test;\
	rm -f *.out;\
	rm -rf .pytest_cache __pycache__

clean: clean_test

	
