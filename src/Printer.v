// Ryan Pencak
// Printer.v

module Printer(str, print, a0, strAddr);

	/* define inputs */
	input [31:0] str;
	input print;
	input [31:0] a0;

	/* define outputs */
	output reg [31:0] strAddr;

	/* define registers */
	reg [7:0] thisLetter;
	reg isPrinting;

	/* define variables */
	integer i;

	initial begin
		isPrinting = 0;
	end

	always @(posedge print) begin
		isPrinting = 1;
		strAddr = a0;
	end

	always @(str) begin
		if (isPrinting)
			begin
				for (i = 4; i > 0; i -= 1)
					begin
						if (i == 4)
							begin
								thisLetter = str[7:0];
							end
						else if ( i == 3)
							begin
								thisLetter = str[15:8];
							end
						else if ( i == 2)
							begin
								thisLetter = str[23:16];
							end
						else
							begin
								thisLetter = str[31:24];
							end

						if (thisLetter == 0)
							begin
								isPrinting = 0;
							end
						else
							begin
								$write("%s", thisLetter);
							end
					end
				if (~isPrinting)
					begin
						$display("");
					end
				strAddr = strAddr + 4;
			end
	end

endmodule
