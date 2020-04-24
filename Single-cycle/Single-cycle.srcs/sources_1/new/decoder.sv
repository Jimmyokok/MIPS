`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 10:52:30
// Design Name: 
// Module Name: decoder
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


module decoder(
input logic [5:0]op,
output logic memtoreg,memwrite,[1:0]branch,
output logic alusrc,regdst,regwrite,
output logic [2:0]aluop,
output logic [1:0]jump,
output logic extmethod
    );
logic [12:0]signals;
assign {memtoreg,memwrite,branch,alusrc,regdst,regwrite,aluop,jump,extmethod}=signals;
always_comb
    case(op)
        6'b000000:signals <=13'b0000011010000;//R-type
        6'b001000:signals <=13'b0000101011001;//addi
        6'b001100:signals <=13'b0000101100000;//andi
        6'b001101:signals <=13'b0000101101000;//ori
        6'b001010:signals <=13'b0000101110001;//slti
        6'b101011:signals <=13'b0100100000001;//sw
        6'b100011:signals <=13'b1000101000001;//lw
        6'b000010:signals <=13'b0000000000100;//j
        6'b000100:signals <=13'b0001000001001;//beq
        6'b000101:signals <=13'b0010000001001;//bne
        6'b000011:signals <=13'b0000000000110;//jal
        default:signals <=13'b0000000000000;
    endcase
endmodule
