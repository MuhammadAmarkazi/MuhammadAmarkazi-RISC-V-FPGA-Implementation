`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 08:21:42 PM
// Design Name: 
// Module Name: Branch_taker
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


module Branch_predictor(op,branch_taken);

input [6:0] op;
output branch_taken;

assign branch_taken = (op[6:5] == 2'b00) ? 1'b0 :
                      (op[6:5] == 2'b01) ? 1'b0 :
                      (op[6:5] == 2'b10) ? 1'b0 : 1'b1 ;
                      



endmodule

