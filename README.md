--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
Team: Ryan Pencak, Evan Harrington, Uttam Kumaran, and Peyton Rumachik
Project: MIPS Pipelined Processor
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
File Structure:
--------------------------------------------------------------------------------------------------------------

  The main (testbench) file is CPU.v

  docs -- contains all documentation and reports

  include -- contains mips.h define file

  src -- contains all Verilog modules including main CPU.v file

  test -- contains folders for each of the three required tests and an executable file for each in Compiled_CPU

--------------------------------------------------------------------------------------------------------------
Compilation and Execution:
--------------------------------------------------------------------------------------------------------------

  To Compile and Run Hello-World:
    Open Instruction_Memory.v and uncomment the readmemh line for Hello-World.
    In terminal, run 'iverilog -o CPU.v add_test_output'

  To Compile and Run Fibonacci:
    Open Instruction_Memory.v and uncomment the readmemh line for Fibonacci.
    In terminal, run 'iverilog -o CPU.v fib_test_output'

  To Compile and Run Test-3:
    Open Instruction_Memory.v and uncomment the readmemh line for Test-3.
    In terminal, run 'iverilog -o CPU.v test_three_output'

--------------------------------------------------------------------------------------------------------------
Design:
--------------------------------------------------------------------------------------------------------------

  The design for this project was based on the single cycle MIPS processor and adapted to allow for forwarding and hazard detection.

  Additional modules were required for a pipelined MIPS processor. The first design adaptation was to include pipeline registers to buffer data from stage to stage to follow a fetch, decode, execute, memory, and write-back format.

  The control unit sets all control signals for the instruction in the decode stage and passes the necessary signals through the pipeline, handling branching and jumping in the decode stage itself.

  A hazard unit module was then developed to deal with hazards that arise in the pipeline. This module includes logic to detect hazards, which result in a clear of the ID-EX pipeline register and stalls in IF-ID and PC modules. Additional logic is used to detect the need for forwarding and our CPU implements EX-EX, MEM-EX, and MEM-MEM forwarding.

  Finally, a branching logic module was created and replaced the equal module represented in the HH MIPS pipeline diagram. This module receives a branch op-code from the control unit and executes the corresponding logic to determine if a branch is triggered.

  Further, there was found to be trouble with Syscalls in the pipelined model and corrections to how they are handled were made. A Syscall in this CPU stalls to allow for the call to be handled in the write-back stage, while exiting without reading further instructions. A better implementation of Syscalls may have been to forward appropriate signals to avoid a stall.

  Another issue that was resolved was the timing of reading and writing on the clock. Reading of registers now occurs on the negative edge of the clock while writing to registers waits for the positive edge of the clock. In Data_Memory, reads occur on the positive edge and writing occurs on the negative edge. Both of these operations are delayed one time unit to ensure all wires have the appropriate values. This results in using a clock that cycles every ten time units to make sure everything can execute properly in each clock cycle.

--------------------------------------------------------------------------------------------------------------
Testing:
--------------------------------------------------------------------------------------------------------------

  For this project, testing involved compiling and monitoring the contents of each wire closely with GTK Wave.
  Instructions were added a few at a time before the program was compiled and debugged for errors.

  The units tests were for each of the three required tests and weren't broken down much further. Testing for each unit test involved displaying the wires of interest on GTK Wave and following the instructions through the pipeline while comparing to the MIPS translated instructions.
