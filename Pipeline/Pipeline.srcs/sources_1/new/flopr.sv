`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 09:16:16
// Design Name: 
// Module Name: regfile
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


module flopr
(
input logic clk,en,reset,
input logic [31:0]d,
output logic [31:0]q
    );
initial q <= 0;
always@(posedge clk)
    if(reset)q<=0;
    else if(en) q <= d;
endmodule
