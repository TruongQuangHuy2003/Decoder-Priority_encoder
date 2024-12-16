`timescale 1ns/1ps
module test_bench;
	reg [7:0] in;
	reg e;
	wire [2:0] out;

	priority_encoder uut(
		.in(in),
		.e(e),
		.out(out)
	);
	
	integer a, b, c;

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);

		$display("------------------------------------------------------");
		$display("--------TESTBENCH FOR PRIORITY ENCODER 3 TO 8---------");
		$display("------------------------------------------------------");
		
		for (a  = 0; a < 10; a = a + 1) begin
			e = 0;
			in = a;
			#1;
			check_result(3'b000);
			#10;
		end

		for (b = 0; b < 10; b = b + 1) begin
			e = 1;
			in = b;
			#1;
			check_result(calc_expected(in,e));
			#10;
		end

		for (c = 0; c < 15; c = c + 1) begin
			e = $urandom%2;
			in = $urandom%10;
			#1;
			check_result(calc_expected(in,e));
			#10;
		end
						
	end

	function [2:0] calc_expected (input [7:0] in_val, input e_val);
		begin
			if (!e_val) begin
				calc_expected = 3'b000;
			end else begin
				casez (in_val[7:0])
					8'b1???????: calc_expected = 3'b111;
					8'b01??????: calc_expected = 3'b110;
					8'b001?????: calc_expected = 3'b101;
					8'b0001????: calc_expected = 3'b100;
					8'b00001???: calc_expected = 3'b011;
					8'b000001??: calc_expected = 3'b010;
					8'b0000001?: calc_expected = 3'b001;
					8'b00000001: calc_expected = 3'b000;
					default: calc_expected = 3'b000;
				endcase
			end
		end
	endfunction

	task check_result;
		input [2:0] expected_result;
		begin
			$display("At time: %t, e = 1'b%b, in = 8'b%b, out = 3'b%b", $time, e, in, out);
			if (out == expected_result) begin
				$display("------------------------------------------------------");
				$display("PASSED: expected: 3'b%b, Got: 3'b%b", expected_result, out);
				$display("------------------------------------------------------");
			end else begin
				$display("------------------------------------------------------");
				$display("FAILED: expected: 3'b%b, Got: 3'b%b", expected_result, out);
				$display("------------------------------------------------------");
			end
		end
	endtask

endmodule
