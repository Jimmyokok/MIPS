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
output logic memwriteM,
output logic [31:0]aluoutM,writedataM,
input logic [31:0]readdataM,
//hazardunit
input logic stallF,stallD,flushD,flushE,forwardAD,forwardBD,[1:0]forwardAE,forwardBE,
output logic memtoregE,memtoregM,regwriteE,regwriteM,regwriteW,[4:0]rsD,rtD,rsE,rtE,
output logic [4:0]writeregE,writeregM,writeregW
);
logic [31:0]resultW;
//fetch
logic[31:0]instrD;
logic [31:0]pcplus4,pcbranch,pcbranchsel,pcjump,pcjumpsel,brRD1,nxtpc;
flopr flopr(clk,~stallF,reset,nxtpc,pc);
assign pcjump={pcplus4[31:28], instrD[25:0], 2'b00};
mux21 pcbranchmux(pcplus4,pcbranch,pcsrc,pcbranchsel);
mux21 pcjumpmux(pcbranchsel,pcjump,jump[1],pcjumpsel);
mux21 pcjrmux(pcjumpsel,brRD1,jr,nxtpc);
adder pcplus4adder(pc,32'b100,pcplus4);
//decode
logic[31:0]pcplus4D;
logic[31:0]RD1,RD2;
logic[31:0]brRD2;
logic [4:0]rdD;
logic [31:0]signimm,signimmshifted;
logic [31:0]aluresult;
prd prd(clk,~stallD,flushD,instr,pcplus4,instrD,pcplus4D);
assign op=instrD[31:26];
assign funct=instrD[5:0];
regfile regfile(clk,reset,regwriteW,instrD[25:21],instrD[20:16],writeregW,resultW,pcplus4D,jump[0],RD1,RD2);
signext signext(instrD[15:0],extmethod,signimm);
shift2 shift2(signimm,signimmshifted);
adder pcbranchadder(signimmshifted,pcplus4D,pcbranch);
mux21 RD1mux(RD1,aluresult,forwardAD,brRD1);
mux21 RD2mux(RD2,aluresult,forwardBD,brRD2);
eqcmp eqcmp(brRD1,brRD2,zero);
assign rsD=instrD[25:21];
assign rtD=instrD[20:16];
assign rdD=instrD[15:11];
//execute
logic [31:0]srcA,srcB;
logic [31:0]RD1E,RD2E,signimmE,writedataE;
logic [4:0]rdE,shamtE;
logic [2:0]alucontE;
logic memwriteE,alusrcE,regdstE;
pre pre(clk,flushE,memtoreg,memwrite,alusrc,regdst,regwrite,alucont,RD1,RD2,signimm,rsD,rtD,rdD,instrD[10:6],
                   memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontE,RD1E,RD2E,signimmE,rsE,rtE,rdE,shamtE);
mux3 mux3srcA(RD1E,resultW,aluoutM,forwardAE,srcA);
mux3 mux3srcB(RD2E,resultW,aluoutM,forwardBE,writedataE);
mux21 #(5) writeregmux(rtE,rdE,regdstE,writeregE);
mux21 alusrcmux(writedataE,signimmE,alusrcE,srcB);
alu alu(alucontE,srcA,srcB,shamtE,aluresult);
//memory
prm prm(clk,memtoregE,memwriteE,regwriteE,aluresult,writedataE,writeregE,
            memtoregM,memwriteM,regwriteM,aluoutM,writedataM,writeregM);
//writeback
logic [31:0]readdataW,aluoutW;
logic memtoregW;
prw prw(clk,memtoregM,regwriteM,aluoutM,readdataM,writeregM,memtoregW,regwriteW,aluoutW,readdataW,writeregW);
mux21 resultmux(aluoutW,readdataW,memtoregW,resultW);

endmodule
