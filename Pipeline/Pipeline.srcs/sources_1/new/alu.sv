`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 14:51:37
// Design Name: 
// Module Name: alu
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


module alu(
input logic [2:0]alucont,
input logic [31:0]srcA,srcB,
input logic [4:0]shamt,
output logic [31:0]aluresult
    );
always_comb
    case(alucont)
        3'b000:aluresult <= srcA & srcB;
        3'b001:aluresult <= srcA | srcB;
        3'b010:aluresult <= srcA + srcB;
        3'b011:aluresult <= srcA + ~srcB + 1;
        3'b100:aluresult <= (srcA + ~srcB + 1)>>31==1;
        3'b101:aluresult <= (srcB << shamt);
        3'b110:aluresult <= (srcB >> shamt);
        3'b111:aluresult <= ({32{srcB[31]}}<<(32-shamt))|(srcB >> shamt);
    endcase
endmodule
