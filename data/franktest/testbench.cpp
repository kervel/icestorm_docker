#include <stdlib.h>
#include "Vuart.h"
#include "verilated.h"


#include <verilated_vcd_c.h>

template<class MODULE> class TESTBENCH {
	// Need to add a new class variable
	VerilatedVcdC	*m_trace;
	unsigned long	m_tickcount;
	MODULE	*m_core;
public:	
	TESTBENCH(void) {
		// According to the Verilator spec, you *must* call
		// traceEverOn before calling any of the tracing functions
		// within Verilator.
		Verilated::traceEverOn(true);
		//... // Everything else can stay like it was before
		m_core = new MODULE;
		m_tickcount = 0l;
	}
	
	virtual ~TESTBENCH(void) {
		delete m_core;
		m_core = NULL;
	}

	virtual void	reset(void) {
		//m_core->i_reset = 1;
		//// Make sure any inheritance gets applied
		//this->tick();
		//m_core->i_reset = 0;
	}

	virtual bool	done(void) { return (Verilated::gotFinish()); }

	// Open/create a trace file
	virtual	void	opentrace(const char *vcdname) {
		if (!m_trace) {
			m_trace = new VerilatedVcdC;
			m_core->trace(m_trace, 99);
			m_trace->open(vcdname);
		}
	}

	// Close a trace file
	virtual void	close(void) {
		if (m_trace) {
			m_trace->close();
			m_trace = NULL;
		}
	}

	virtual void	tick(void) {
		m_tickcount++;

		m_core->i_clock = 0;
		m_core->eval();

		if(m_trace) m_trace->dump(10*m_tickcount-2);

		// Repeat for the positive edge of the clock
		m_core->i_clock = 1;
		m_core->eval();
		if(m_trace) m_trace->dump(10*m_tickcount);

		// Now the negative edge
		m_core->i_clock = 0;
		m_core->eval();
		if (m_trace) {
			// This portion, though, is a touch different.
			// After dumping our values as they exist on the
			// negative clock edge ...
			m_trace->dump(10*m_tickcount+5);
			//
			// We'll also need to make sure we flush any I/O to
			// the trace file, so that we can use the assert()
			// function between now and the next tick if we want to.
			m_trace->flush();
		}
	}
};

int main(int argc, char **argv) {
	// Initialize Verilators variables
	Verilated::commandArgs(argc, argv);

	// Create an instance of our module under test
	TESTBENCH<Vuart> *tb = new TESTBENCH<Vuart>();


	tb->opentrace("trace.vcd");
	// Tick the clock until we are done
	while(!tb->done()) {
		tb->tick();
	}
}
