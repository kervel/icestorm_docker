VERILATOR ?= verilator
VDIRFB := verilator/
VFLAGS := -Wall --MMD --Mdir $(VDIRFB) -trace -cc
SUBMAKE := $(MAKE) --no-print-directory -C

all: library

verilate: $(VDIRFB)/Vtest.h

$(VDIRFB)/Vtest.h: uart_tx.v helloworld_rom.v test.v single_char.v
	$(VERILATOR) $(VFLAGS) test.v


library: $(VDIRFB)/Vtest.h
	$(SUBMAKE) $(VDIRFB)/ -f Vtest.mk

testbench: library
	g++ -o testbench testbench.cpp  /usr/share/verilator/include/verilated.cpp /usr/share/verilator/include/verilated_vcd_c.cpp $(VDIRFB)/Vtest__ALL.a  -I/usr/share/verilator/include  -I$(VDIRFB)/ 


clean:
	rm -rf $(VDIRFB)/

	