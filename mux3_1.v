`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2024 12:39:41 PM
// Design Name: 
// Module Name: mux3_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux3_1( a, b, c, s, d);

input [31:0] a,b,c;
input [1:0] s;
output d;

assign d = (s == 2'b00) ? a : (s == 2'b00) ? b : (s == 2'b00) ? c : 32'h00000000; 
endmodule
