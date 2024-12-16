// testbench for binary decoder 3 to 8
`timescale 1ns/1ps

module test_bench;
	reg [2:0] in;
	reg e;
	wire [7:0] out;

binary_decoder_3to8 uut(
	.in(in),
	.e(e),
	.out(out)
);

integer i;

initial begin
	$dumpfile("binary_decoder.vcd");
	$dumpvars(0, test_bench);
	
	$display("---------------------------------------------------------------------");
	$display("---------- TESTBENCH FOR BINARY DECODER 3 TO 8-----------------------");
	$display("---------------------------------------------------------------------");

	e = 0;
	in = 3'b101;
	#1;
	check_result(8'h00);
	#10;
	
	e = 0;
	in = 3'b100;
	#1;
	check_result(8'h00);
	#10;
	
	for (i = 0; i < 8; i = i + 1) begin
		e = 1;
		in = i;
		#1;
		check_result(8'h01 << in);
		#15;
	end		

	#100;
	$finish;
end

task check_result;
	input [7:0] expected_result;
	begin
	$display("At time: %t, in = %b, e = %b, out = %b",$time, in, e, out);
	if (out == expected_result) begin
		$display("---------------------------------------------------------------------");
		$display("PASSED: Expected: %b Got: %b", expected_result, out);
		$display("---------------------------------------------------------------------");
	end else begin
		$display("---------------------------------------------------------------------");
		$display("FAILED: Expected: %b Got: %b", expected_result, out);
		$display("---------------------------------------------------------------------");
	end
end
endtask
endmodule
