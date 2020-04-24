`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 13:33:05
// Design Name: 
// Module Name: pre
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


module pre(
input logic clk,clr,
input logic memtoreg,memwrite,alusrc,regdst,regwrite,
input logic [2:0]alucont,
input logic [31:0]RD1,RD2,signimmD,
input logic [4:0]rs,rt,rd,shamtD,
output logic memtoregE,memwriteE,alusrcE,regdstE,regwriteE,
output logic [2:0]alucontE,
output logic [31:0]RD1E,RD2E,signimmE,
output logic [4:0]rsE,rtE,rdE,shamtE
    );
initial
    {memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontE,RD1E,RD2E,signimmE,rsE,rtE,rdE,shamtE}<={124{1'b0}};
    
always @(posedge clk)
    if(clr){memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontE,RD1E,RD2E,signimmE,rsE,rtE,rdE,shamtE} <= 0;
    else {memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontE,RD1E,RD2E,signimmE,rsE,rtE,rdE,shamtE} <= {memtoreg,memwrite,alusrc,regdst,regwrite,alucont,RD1,RD2,signimmD,rs,rt,rd,shamtD};
endmodule
