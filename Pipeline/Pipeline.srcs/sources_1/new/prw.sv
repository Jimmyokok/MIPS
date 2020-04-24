`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 13:50:14
// Design Name: 
// Module Name: prw
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


module prw(
input logic clk,
input logic memtoreg,regwrite,
input logic [31:0]aluout,readdata,
input logic [4:0]writereg,
output logic memtoregW,regwriteW,
output logic [31:0]aluoutW,readdataW,
output logic [4:0]writeregW
    );
initial
    {memtoregW,regwriteW,aluoutW,readdataW,writeregW}<={71{1'b0}};
always @(posedge clk)
    {memtoregW,regwriteW,aluoutW,readdataW,writeregW} <= {memtoreg,regwrite,aluout,readdata,writereg};
endmodule
