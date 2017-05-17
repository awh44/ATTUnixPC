FILES = src/*.vhd src/**/*.vhd
VHDLEX = .vhd
 
# testbench
TESTBENCHPATH = testbench/${TESTBENCH}$(VHDLEX)
 
#GHDL CONFIG
GHDL_CMD = ghdl
 
SIMDIR = simulation
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=100us --ieee-asserts=disable
 
WAVEFORM_VIEWER = gtkwave
 
all: compile run view
 
new :
	echo "Setting up project ${PROJECT}"
	mkdir src testbench simulation	
 
compile :
ifeq ($(strip $(TESTBENCH)),)
		@echo "TESTBENCH not set. Use TESTBENCH=value to set it."
		@exit 2
endif                                                                                             
 
	mkdir -p simulation
	$(GHDL_CMD) -i $(GHDL_FLAGS) --std=08 --workdir=simulation --work=work $(TESTBENCHPATH) $(FILES) # > /dev/null 2>&1
	$(GHDL_CMD) -m  $(GHDL_FLAGS) --std=08 --workdir=simulation --work=work $(TESTBENCH) # > /dev/null 2>&1
	@mv $(TESTBENCH) simulation/$(TESTBENCH)                                                                                
 
run :
	@$(SIMDIR)/$(TESTBENCH) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(TESTBENCH).vcdgz                                      
 
view :
	gunzip --stdout $(SIMDIR)/$(TESTBENCH).vcdgz | $(WAVEFORM_VIEWER) --vcd
	rm *.o
 
clean :
	$(GHDL_CMD) --clean --workdir=simulation

