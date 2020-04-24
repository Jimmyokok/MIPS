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
logic zero,memtoreg,alusrc,regdst,regwrite,jr,pcsrc,extmethod,memwrite0;
logic [1:0]jump;
logic [2:0]alucont;
logic stallF,stallD,flushD,flushE,forwardAD,forwardBD;
logic [1:0]forwardAE,forwardBE;
logic memtoregE,memtoregM,regwriteE,regwriteM,regwriteW;
logic [4:0]rsD,rtD,rsE,rtE;
logic [4:0]writeregE,writeregM,writeregW;
logic [1:0]branch;
controller cont(op,funct,zero,memtoreg,memwrite0,jump,alusrc,regdst,regwrite,jr,pcsrc,extmethod,alucont,branch);
datapath dp(clk,reset,op,funct,zero,memtoreg,memwrite0,jump,alusrc,regdst,regwrite,jr,pcsrc,extmethod,alucont,
              pc,inst,memwrite,aluout,writedata,readdata,
              stallF,stallD,flushD,flushE,forwardAD,forwardBD,forwardAE,forwardBE,
              memtoregE,memtoregM,regwriteE,regwriteM,regwriteW,rsD,rtD,rsE,rtE,
              writeregE,writeregM,writeregW);
hazardunit hazard(pcsrc,jr,jump[1],branch,
              memtoregE,memtoregM,regwriteE,regwriteM,regwriteW,rsD,rtD,rsE,rtE,
              writeregE,writeregM,writeregW,
              stallF,stallD,flushD,flushE,forwardAD,forwardBD,forwardAE,forwardBE
              );
endmodule
