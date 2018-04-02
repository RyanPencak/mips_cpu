// ID_EX.v

/* ID_EX module: handles signals from ID to EX */
module ID_EX(clk, jump, FlushE, EX_D, MEM_D, WB_D, Rs_D, Rt_D, Rd_D, RD1_D, RD2_D, SignImm_D, Shamt_D,
            EX_E, MEM_E, WB_E, Rs_E, Rt_E, Rd_E, RD1_E, RD2_E, SignImm_E, Shamt_E);

  /* declare inputs */
  input clk, jump, FlushE;
  input [6:0] EX_D;
  input [1:0] MEM_D;
  input [1:0] WB_D;
  input [4:0] Rs_D;
  input [4:0] Rt_D;
  input [4:0] Rd_D;
  input [31:0] RD1_D;
  input [31:0] RD2_D;
  input [31:0] SignImm_D;
  input [4:0] Shamt_D;

  /* declare outputs */
  output reg [6:0] EX_E;
  output reg [1:0] MEM_E;
  output reg [1:0] WB_E;
  output reg [4:0] Rs_E;
  output reg [4:0] Rt_E;
  output reg [4:0] Rd_E;
  output reg [31:0] RD1_E;
  output reg [31:0] RD2_E;
  output reg [31:0] SignImm_E;
  output reg [4:0] Shamt_E;

  /* initialize outputs to zero */
  initial begin
    EX_E <= 0;
    MEM_E <= 0;
 		WB_E <= 2'b00;
 		Rs_E <= 0;
 		Rt_E <= 0;
 		Rd_E <= 0;
 		RD1_E <= 0;
 		RD2_E <= 0;
 		SignImm_E <= 0;
    Shamt_E <= 0;
   end

   /* set outputs to inputs on positive clock edge */
   always @(posedge clk) begin
    if(FlushE || jump) begin
      EX_E <= 0;
      MEM_E <= 0;
      WB_E <= 0;
      Rs_E <= 0;
      Rt_E <= 0;
      Rd_E <= 0;
      RD1_E <= 0;
      RD2_E <= 0;
      SignImm_E <= 0;
      Shamt_E <= 0;
    end
    else begin
      // $display("setting EX_E to %3b", EX_D);
      EX_E <= EX_D;
      MEM_E <= MEM_D;
      WB_E <= WB_D;
      Rs_E <= Rs_D;
      Rt_E <= Rt_D;
      Rd_E <= Rd_D;
      RD1_E <= RD1_D;
      RD2_E <= RD2_D;
      SignImm_E <= SignImm_D;
      Shamt_E <= Shamt_D;
    end
  end

endmodule
