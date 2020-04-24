`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/16 16:02:32
// Design Name: 
// Module Name: mips
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


module mips(
input logic clk,reset,
input logic [31:0]instr,readdata,
output logic memwrite,
output logic [31:0]pc,aluout,writedata
    );
logic [31:0]inst;
logic [5:0]funct,op;
assign inst=reset?0:instr;
logic zero,memtoreg,alusrc,regdst,regwrite,jr,pcsrc,extmethod;
logic [1:0]jump;
logic [2:0]alucont;
controller cont(op,funct,zero,memtoreg,memwrite,jump,alusrc,regdst,regwrite,jr,pcsrc,extmethod,alucont);
datapath data(clk,reset,op,funct,zero,memtoreg,memwrite,jump,alusrc,regdst,regwrite,jr,pcsrc,extmethod,alucont,pc,inst,aluout,writedata,readdata);
endmodule
