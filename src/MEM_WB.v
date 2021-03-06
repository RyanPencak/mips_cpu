// MEM_WB.v

/* module MEM_WB: handles the pipelining from MEM to WB stages */
module MEM_WB(clk, WB_M, ReadData_M, ALUOut_M, WriteReg_M,
              WB_W, ReadData_W, ALUOut_W, WriteReg_W);

  /* declare inputs */
  input clk;
  input [1:0] WB_M;
  input [31:0] ReadData_M, ALUOut_M;
  input [4:0] WriteReg_M;

  /* declare outputs */
  output reg [1:0] WB_W;
  output reg [31:0] ReadData_W, ALUOut_W;
  output reg [4:0] WriteReg_W;

  /* initialize outputs to zero */
  initial begin
    WB_W <= 0;
    ReadData_W <= 0;
    ALUOut_W <= 0;
    WriteReg_W <= 0;
  end

  /* at positive clock edge handle pipe from IF to ID */
  always @(posedge clk)
  begin
    WB_W <= WB_M;
    ReadData_W <= ReadData_M;
    ALUOut_W <= ALUOut_M;
    WriteReg_W <= WriteReg_M;
  end

endmodule
