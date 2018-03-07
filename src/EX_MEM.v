// EX_MEM.v

/* EX to MEM module: handles signals from EX to MEM */
module EX_MEM(input clk, input [2:0] MEM_E, input [1:0] WB_E, input [31:0] ALUOut_E, input [31:0] WriteData_E, input [4:0] WriteReg_E, output reg [2:0] MEM_M, output reg [1:0] WB_M, output reg [31:0] ALUOut_M, output reg [31:0] WriteData_M, output reg [4:0] WriteReg_M)

	initial begin
		MEM_M = 0;
		WD_M = 0;
		ALU_M = 0;
		WriteData_M = 0;
		WriteReg_M = 0;
	end

	always @(posedge clk)
	begin
		MEM_M = MEM_E;
		WB_M = WB_E;
		ALUOut_M = ALUOut_E;
		WriteReg_M = WriteData_E;
		WriteReg_M = WriteReg_E;
	end

endmodule
