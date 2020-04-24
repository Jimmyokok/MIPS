`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 13:44:48
// Design Name: 
// Module Name: prm
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


module prm(
input logic clk,
input logic memtoreg,memwrite,regwrite,
input logic [31:0]aluout,writedata,
input logic [4:0]writereg,
output logic memtoregM,memwriteM,regwriteM,
output logic [31:0]aluoutM,writedataM,
output logic [4:0]writeregM
    );
initial
    {memtoregM,memwriteM,regwriteM,aluoutM,writedataM,writeregM}<={72{1'b0}};
always @(posedge clk)
    {memtoregM,memwriteM,regwriteM,aluoutM,writedataM,writeregM} <= {memtoreg,memwrite,regwrite,aluout,writedata,writereg};
endmodule
