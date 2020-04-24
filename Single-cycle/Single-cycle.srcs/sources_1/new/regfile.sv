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


module regfile(
input logic clk,reset,
input logic WE3,
input logic [4:0]A1,
input logic [4:0]A2,
input logic [4:0]A3,
input logic [31:0]WD3,
input logic [31:0]jal_in,
input logic jal_sig,
output logic [31:0]RD1,
output logic [31:0]RD2,
output logic [31:0]jal_out
    );
logic [31:0]regfile[31:0];
assign RD1=(A1?regfile[A1]:0);
assign RD2=(A2?regfile[A2]:0);
assign jal_out=regfile[31];
always @(posedge clk)
    if(reset)
        for(integer i=0;i<32;i=i+1) regfile[i]=0;
    else if(WE3)
        regfile[A3] <= WD3;
    else if(jal_sig)
        regfile[31] <= jal_in;
endmodule
