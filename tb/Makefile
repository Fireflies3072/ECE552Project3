# UW-Madison ECE 552 Project 3 Makefile
# Automated Testing for Single-Cycle Processor

# Directories
RTL_DIR = ../rtl
TESTS_DIR = ../tests/asm
TRACES_DIR = ../traces
TB_DIR = .

# Tools
IVERILOG = iverilog
VVP = vvp
MAKE = make

# Source files
RTL_SRCS = $(wildcard $(RTL_DIR)/*.v)
TB_SRC = $(TB_DIR)/tb.v
SIM_OUT = $(TB_DIR)/sim.out

# Programs to test
PROGRAMS = 01add 02addi 03and 04andi 05lui

# Default target
all: test_all

# Compile the Verilog simulator
$(SIM_OUT): $(RTL_SRCS) $(TB_SRC)
	@echo "Compiling Verilog source files..."
	$(IVERILOG) $(RTL_SRCS) $(TB_SRC) -o $(SIM_OUT)

# Individual test targets
# The check logic looks for the value of register a0 (x10) at the end of execution.
# Assembly tests set a0=1 for pass and a0=0xdead for fail before calling ebreak.
test_%: $(SIM_OUT)
	@echo "----------------------------------------------------------------------"
	@echo "Testing $*..."
	@cd $(TESTS_DIR) && $(MAKE) PROGRAM=$*
	@$(VVP) $(SIM_OUT) > $(TRACES_DIR)/$*.trace 2>&1
	@if grep -q "Program halted after" $(TRACES_DIR)/$*.trace; then \
		LAST_W10=$$(grep "w\[10\]=" $(TRACES_DIR)/$*.trace | tail -n 1 | sed 's/.*w\[10\]=\([0-9a-f]*\).*/\1/'); \
		if [ "$$LAST_W10" = "00000001" ]; then \
			echo "  [PASS] $* completed successfully (a0=1)."; \
		else \
			echo "  [FAIL] $* failed. Final a0=0x$$LAST_W10. Check $(TRACES_DIR)/$*.trace"; \
			exit 1; \
		fi \
	else \
		echo "  [FAIL] $* did not halt correctly (timeout or crash)."; \
		exit 1; \
	fi

# Run all tests
test_all: $(foreach prog,$(PROGRAMS),test_$(prog))
	@echo "----------------------------------------------------------------------"
	@echo "All tests completed successfully!"

# Clean up generated files
clean:
	rm -f $(SIM_OUT) $(TRACES_DIR)/*.trace $(TB_DIR)/program.mem
	@cd $(TESTS_DIR) && rm -f *.o *.hex *.hex.tmp

.PHONY: all test_all clean
