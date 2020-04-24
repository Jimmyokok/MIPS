`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 09:16:16
// Design Name: 
// Module Name: dmem
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


module dmem(
input logic we,clk,
input logic [31:0]a,wd,
output logic [31:0]rd
    );
logic [31:0]RAM[63:0];
assign rd = RAM[a[31:2]];
always @ (posedge clk)
    if(we)RAM[a[31:2]] <= wd;
endmodule
