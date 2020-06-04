WARNINGS = '-Wall'
VERILOG_VERSION = '2012'

run_tb: run_tb_prefix_adder run_tb_pg run_tb_pg_in run_tb_prefix_node

test: clean run_tb
	pytest

test_dir: 
	mkdir -p test;
   
run_tb_prefix_adder: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/prefix_adder.out prefix_adder_tb.v 

run_tb_pg: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/pg.out pg_tb.v

run_tb_pg_in: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/pg_in.out pg_in_tb.v

run_tb_prefix_node: test_dir
	cd source;\
	iverilog $(WARNINGS) -g$(VERILOG_VERSION) -o ../test/prefix_node.out prefix_node_tb.v

clean_test:
	cd test;\
	find ./*.out -maxdepth 1 -type f -exec rm -f {} \;

clean: clean_test

	
