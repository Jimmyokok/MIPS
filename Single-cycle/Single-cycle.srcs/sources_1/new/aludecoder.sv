`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 14:41:18
// Design Name: 
// Module Name: aludecoder
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


module aludecoder(
input logic [5:0]funct,
input logic [2:0]aluop,
output logic [2:0]alucont
    );
always_comb
    case(aluop)
        3'b001:alucont <= 3'b011;//bne,beq
        3'b010:
            case(funct)
                6'b100100:alucont <= 3'b000;//and
                6'b100101:alucont <= 3'b001;//or
                6'b100000:alucont <= 3'b010;//add
                6'b100010:alucont <= 3'b011;//sub
                6'b101010:alucont <= 3'b100;//slt
                6'b000000:alucont <= 3'b101;//sll
                6'b000010:alucont <= 3'b110;//srl
                6'b000011:alucont <= 3'b111;//sra
            endcase
        3'b011:alucont <= 3'b010;//addi
        3'b100:alucont <= 3'b000;//andi
        3'b101:alucont <= 3'b001;//ori
        3'b110:alucont <= 3'b100;//slti
        default:alucont <=3'b010;//become add
    endcase
endmodule
