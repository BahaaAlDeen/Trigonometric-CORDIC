//`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:44:25 05/05/2019
// Design Name:   time_delay
// Module Name:   D:/FPGA/time_delay/timedelay_tb.v
// Project Name:  time_delay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: time_delay
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CORDIC_TB;


  // Inputs

  reg [31:0] rad;
  reg clk=1,rst;

  wire [31:0] COS, SIN;


  initial begin

    //set initial values
    rad = 5898240;


    //set clock
	 rst=1;
	 #20 rst=0;
    clk = 'b0;
    forever
    begin
      #5 clk = !clk;
    end

    // Test 1
     #1000  
	  rad = 5898240;
    
    // Test 2
    // #1500
    // rad = 5898240;

    // Test 3
    // #10000
    // rad = 5898240;

    // Test 4
    // #10000
    // rad = 5898240;

   

  end

  
  CORDIC_MAIN  TEST_RUN(clk,rst,rad,COS,SIN);
		 
       
endmodule

