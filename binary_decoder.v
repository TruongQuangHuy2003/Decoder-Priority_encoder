module binary_decoder_3to8 (
	input wire [2:0] in,
	input wire e,
	output reg [7:0] out
);

always @(*) begin
	if (e == 1'b0) begin
		out <= 8'b0000_0000;
	end else if (e == 1'b1) begin
		case (in)
			3'b000: out <= 8'b0000_0001;
			3'b001: out <= 8'b0000_0010;
			3'b010: out <= 8'b0000_0100;
			3'b011: out <= 8'b0000_1000;
			3'b100: out <= 8'b0001_0000;
			3'b101: out <= 8'b0010_0000;
			3'b110: out <= 8'b0100_0000;
			3'b111: out <= 8'b1000_0000;
			default: out <= 8'b0000_0000;
		endcase
	end else begin
		out <= 8'b0000_0000;
	end
end	
endmodule
