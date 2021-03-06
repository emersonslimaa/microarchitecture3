`timescale 1ns/1ps
module teste_arbitrator;
	reg clock, resetn, read, write, chip_select;
 	reg [31:0] writedata;
	wire [31:0] readdata;
 	reg rx, rdy;
 	wire tx;
	wire [2:0] state;
	reg clk_50m;
	wire rxclk_en;
        wire txclk_en;
	arbitrator teste(clock, resetn, writedata, readdata, read, write, chip_select, rx, tx, rdy, state);
	baud_rate_gen teste1( clk_50m, rxclk_en, txclk_en);
	integer count;
	initial begin
		count = 0;
		clock = 1; resetn = 0; rdy = 1;
	end
	
	always @(posedge clock) begin
		#50
		while(count < 2) begin
			
			#50
			if(state == 000)begin clock = 0; rdy = 1; resetn=1; end
			$display("Clock %b",clock);
			$display("Ready %b", rdy);
			$display("Reset %b", resetn);
			#50 clock = 1;
			$display("Estado %b ", state);
			
			count++;
		end
	end
endmodule

