// Ryan Pencak
// memory.v

/* memory module: determines output data*/
module Instruction_Memory(currPC, strAddr,
                          instr, number_instructions, str);

  /* declare inputs */
  input [31:0] currPC;
  input [31:0] strAddr;

  /* declare outputs */
  output reg [31:0] instr, number_instructions;
  output [31:0] str;

  /* declare registers */
  reg [31:0] mem[29'h00100000:29'h00100100];

  initial begin
    /* UNCOMMENT THIS TO COMPILE ADD_TEST */
    // $readmemh("../test/add_test/add_test.v", mem);

    /* UNCOMMENT THIS TO COMPILE HELLO_WORLD */
    $readmemh("../test/hello_world/hello.v", mem);

    /* UNCOMMENT THIS TO COMPILE FIBONACCI */
    // $readmemh("../test/fibonacci/fib.v", mem);

    /* UNCOMMENT THIS TO COMPILE TEST 3 */
    // $readmemh("../test/third_test/third_test.v", mem);

    number_instructions = 0; // initial statistic
  end

  always @(currPC) begin
      instr = mem[currPC[31:2]];
      number_instructions = number_instructions + 1;
  end

  assign str = mem[strAddr >> 2];

endmodule
