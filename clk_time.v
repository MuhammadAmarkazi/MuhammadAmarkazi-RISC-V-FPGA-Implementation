`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 07:01:09 PM
// Design Name: 
// Module Name: time
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

module time1(clk1_s,clk);

input clk1_s;
output reg clk = 0;



reg [26:0] counter = 0;



always @ (posedge clk1_s )
begin

    if (counter == 100000000 - 1) 
    begin
    
   clk <= ~ clk ;
    counter <= 0;
    
end

else

counter <= counter + 1;


end


endmodule
