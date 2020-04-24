`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/11 09:03:13
// Design Name: 
// Module Name: datapath
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


module datapath(
input logic clk,reset,
//controller
output logic [5:0]op,funct,
output logic zero,
input logic memtoreg,memwrite,
input logic [1:0]jump,
input logic alusrc,regdst,regwrite,jr,pcsrc,extmethod,
input logic [2:0]alucont,
//imem
output logic [31:0]pc,
input logic [31:0]instr,
//dmem
output logic [31:0]aluresult,writedata,
input logic [31:0]readdata
    );
assign op=instr[31:26];
assign funct=instr[5:0];
logic [4:0]writereg;
logic [31:0]signimm,signimmshifted,srcA,srcB,result;
logic [31:0]pcplus4,pcbranch,pcbranchsel,pcjump,pcjumpsel,pcjr,nxtpc;
assign pcjump={pcplus4[31:28], instr[25:0], 2'b00};
flopr flopr(clk,reset,nxtpc,pc);
regfile regfile(clk,reset,regwrite,instr[25:21],instr[20:16],writereg,result,pcplus4,jump[0],srcA,writedata,pcjr);
alu alu(alucont,srcA,srcB,instr[10:6],aluresult,zero);
signext signext(instr[15:0],extmethod,signimm);
shift2 shift2(signimm,signimmshifted);
adder pcplus4adder(pc,32'b100,pcplus4);
adder pcbranchadder(signimmshifted,pcplus4,pcbranch);
mux21 alusrcmux(writedata,signimm,alusrc,srcB);
mux21 resultmux(aluresult,readdata,memtoreg,result);
mux21 #(5) writeregmux(instr[20:16],instr[15:11],regdst,writereg);
mux21 pcbranchmux(pcplus4,pcbranch,pcsrc,pcbranchsel);
mux21 pcjumpmux(pcbranchsel,pcjump,jump[1],pcjumpsel);
mux21 pcjrmux(pcjumpsel,pcjr,jr,nxtpc);
endmodule
