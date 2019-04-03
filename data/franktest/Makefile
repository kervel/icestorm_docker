VERILATOR ?= verilator
VDIRFB := verilator/
VFLAGS := -Wall --MMD --Mdir $(VDIRFB) -trace -cc
SUBMAKE := $(MAKE) --no-print-directory -C

all: library

verilate: $(VDIRFB)/Vuart.h

$(VDIRFB)/Vuart.h:
	$(VERILATOR) $(VFLAGS) uart.v


library: $(VDIRFB)/Vuart.h
	$(SUBMAKE) $(VDIRFB)/ -f Vuart.mk

testbench: library
	g++ -o testbench testbench.cpp  /usr/share/verilator/include/verilated.cpp /usr/share/verilator/include/verilated_vcd_c.cpp $(VDIRFB)/Vuart__ALL.a  -I/usr/share/verilator/include  -I$(VDIRFB)/ 


clean:
	rm -rf $(VDIRFB)/

	