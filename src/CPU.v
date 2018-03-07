// Main File

/* include external module files */
`include "../include/mips.h"
`include "PC.v"
`include "Adder.v"
`include "Instruction_Memory.v"
`include "Get_Jump_Addr.v"
`include "Control.v"
`include "MUX.v"
`include "Syscall.v"
`include "ALU.v"
`include "Registers.v"
`include "Sign_Extend_16_32.v"
`include "And.v"
`include "Data_Memory.v"
`include "Stats.v"


/* testbench module */
module testbench;

    // /* declare single cycle wires */
    // wire [31:0] nextPC;
    // wire [31:0] currPC;
    // wire [31:0] instr;
    // wire [31:0] PCplus4;
    // wire [31:0] jumpAddr;
    // wire [10:0] controlSignals;
    // wire [31:0] readData1;
    // wire [31:0] readData2;
    // wire [31:0] signExtendedValue;
    // wire [31:0] aluResult;
    // wire [31:0] aluMuxOut;
    // wire [31:0] v0;
    // wire [31:0] a0;
    // wire [31:0] ra;
    // wire [31:0] readData_mem;
    // wire [31:0] branch_mux_out;
    // wire [31:0] jrMux_out;
    //
    // /* declare 5 bit write register */
    // wire [4:0] writeReg;


    /* declare control signals */
      wire zero;

    /* declare clock */
      reg clk;

    /* declare statistics wires */
      wire [31:0] number_instructions;
      wire stat_control;

    /* declare IF Stage wires */
      wire PCSrc_D;

      wire [31:0] PCPlus4_F;
      wire [31:0] PCBranch_D;
      wire [31:0] Next_PC;
      wire [31:0] PC_F;
      wire [31:0] instr_F;

    /* declare ID Stage wires */
      wire [31:0] instr_D;
      wire [31:0] PCPlus4_D;
      wire [31:0] PC_D;

      // pipeline signals
      wire [4:0] EX_D;
      wire [2:0] MEM_D;
      wire [1:0] WB_D;

      wire [31:0] RD1_D;
      wire [31:0] RD2_D;

      wire [31:0] v0;
      wire [31:0] a0;
      wire [31:0] ra;

      wire [31:0] signImm_D;

      // control signals
      wire jump;
      wire branch;
      wire syscall_control;
      wire jal_control;
      wire jr_control;

    /* declare EX Stage wires */

      // pipeline signals
      wire [4:0] EX_E;
      wire [2:0] MEM_E;
      wire [1:0] WB_E;

      // registers
      wire [4:0] Rs_E;
      wire [4:0] Rt_E;
      wire [4:0] Rd_E;
      wire [4:0] writeReg_E;

      // out registers
      wire [31:0] RD1_E;
      wire [31:0] RD2_E;


      wire [31:0] signImm_E;
      wire [31:0] srcB;
      wire [31:0] ALUOut_E;

    /* declare MEM Stage wires */

      // pipeline signals
      wire [2:0] MEM_M;
      wire [1:0] WB_M;

    /* declare WB Stage wires */

      // pipeline signals
      wire [1:0] WB_W;

      wire [4:0] writeReg_W;
      wire [31:0] Result_W;

    /* IF Stage */

      // mux for branch control
      Mux_2_1_32bit branchMux(PCSrc_D, PCplus4_F, PCBranch_D, Next_PC);

      // get current pc
      PC PC_block(clk, Next_PC, PC_F);

      // get instruction from memory
      Instruction_Memory instructionMemory(PC_F, instr_F, number_instructions);

      // add 4 to pc for next pc
      Add4 PCadd4(PC_F, PCPlus4_F);


    /* Pipeline */

      // IF to ID Pipeline
      IF_ID IfId(clk, PCSrc_D, PC_F, instr_F, PCPlus4_F, PC_D, instr_D, PCPlus4_D);


    /* ID Stage */

      // get all control signals from instruction
      Control control_block(instr_D, EX_D, MEM_D, WB_D, jump, branch, syscall_control, jr_control, jal_control);

      // execute registers block for read data outputs
      Registers reg_block(clk, jal_control, PC_D+8 /*JAL*/, instr_D[25:21], instr_D[20:16], writeReg_W, Result_W, MEM_D[`REGWRITE_M], RD1_D, RD2_D, v0, a0, ra);

      // sign extend the immediate value
      Sign_Extend_16_32 signExtend_block(instr_D, signImm_D);

      // adder for branch address
      Adder branchAdder(PCPlus4_D, signImm_D, PCBranch_D);

      // and gate for branch mux control
      And_Gate branch_control(branch, zero, PCSrc_D);

      // calculate jump address
      // Get_Jump_Addr JumpAddr_block(instrD, PCPlus4D, jumpAddr);

      // mux for jump control ??
      // Mux_2_1_32bit jumpMux(jump, Next_PC, jrMux_out, branch_mux_out);

      // mux for JR control
      // Mux_2_1_32bit jrMux(jr_control, jumpAddr, ra, jrMux_out);

      // execute syscall if control signal is set based on v0 and a0
      Syscall testSyscall(syscall_control, v0, a0, stat_control);


    /* Pipeline */

      // ID to EX Pipeline
      ID_EX IdEx(clk, EX_D, MEM_D, WB_D, instr_D[25:21], instr_D[20:16], instr_D[15:11], RD1_D, RD2_D, signImm_D, EX_E, MEM_E, WB_E, Rs_E, Rt_E, Rd_E, RD1_E, RD2_E, signImm_E);


    /* EX Stage */

      // mux for write register input
      Mux_2_1_5bit registerMux(EX_E[`REGDST_E], Rt_E, Rd_E, writeReg_E);

      // mux for alu input 2
      Mux_2_1_32bit aluMux(EX_E[`ALUSRC_E], RD2_E, signImm_E, srcB);

      // execute alu block and output result and zero control signal
      ALU ALU_block(RD1_E, srcB, EX_E[`ALUOP_E], ALUOut_E, zero);


    /* Pipeline */

      // EX to MEM Pipeline
      EX_MEM ExMem(clk, MEM_E, WB_E, ALUOut_E, RD2_E, writeReg_E, MEM_M, WB_M, ALUOut_M, writeData_M, writeReg_M);


    /* MEM Stage */

      // execute data memory for read/write
      Data_Memory dataMem(clk, MEM_M[`MEMWRITE_M], WB_M[`MEMREAD_W], ALUOut_M, writeData_M, readData_M);


    /* Pipeline */

      // MEM to WB Pipeline
      MEM_WB MemWb(clk, WB_M, readData_M, ALUOut_M, WB_W, readData_W, ALUOut_W);


    /* WB Stage */

      // mux to control input to ResultW
      Mux_2_1_32bit memToRegMux(WB_W[`MEMTOREG_W], ALUOut_W, readData_W, ResultW);


    /* Statistics */

      // stats module for printing end of run statistics
      Stats runStats(clk, stat_control, number_instructions);


    always begin
      if(stat_control == 0)
      begin
        #10 clk = ~clk;
      end
    end

    initial begin

      clk = 1;

      $dumpfile("testbench.vcd");
      $dumpvars(0,testbench);

      // $monitor($time, " in %m, currPC = %08x, nextPC = %08x, instruction = %08x\n", currPC, nextPC, instr);

      #50000 $finish;

    end

endmodule