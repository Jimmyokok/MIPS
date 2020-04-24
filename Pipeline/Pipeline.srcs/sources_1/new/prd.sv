`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 13:26:33
// Design Name: 
// Module Name: prd
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


module prd(
input logic clk,en,clr,
input logic [31:0]instr,
input logic [31:0]pcplus4,
output logic [31:0]instrD,
output logic [31:0]pcplus4D
    );
initial 
    begin
        instrD<=0;
        pcplus4D<=0;
    end
always @(posedge clk)
    if(clr)
        begin   
            instrD <= 0;
            pcplus4D<=0;
        end
    else if(en)
        begin
            instrD <= instr;
            pcplus4D<=pcplus4;
        end
endmodule
