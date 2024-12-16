module priority_encoder (
	input wire [7:0] in,
	input e,
	output reg [2:0] out
);

always @(*) begin
	if (!e) begin
		out = 3'b000;
	end else begin
		casez (in)
			8'b1???_????: out <= 3'b111;
			8'b01??_????: out <= 3'b110;
			8'b001?_????: out <= 3'b101;
			8'b0001_????: out <= 3'b100;
			8'b0000_1???: out <= 3'b011;
			8'b0000_01??: out <= 3'b010;
			8'b0000_001?: out <= 3'b001;
			8'b0000_0001: out <= 3'b000;
			default: out <= 3'b000;
		endcase
	end
end	
endmodule
