`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/10 16:27:10
// Design Name: 
// Module Name: controller
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


module controller(
input logic [5:0]op,funct,
input logic zero,
output logic memtoreg,memwrite,
output logic [1:0]jump,
output logic alusrc,regdst,regwrite,jr,pcsrc,extmethod,
output logic [2:0]alucont
    );
assign jr=(op==6'b000000&funct==6'b001000);
logic [2:0]aluop;
logic [1:0]branch;
assign pcsrc=(branch[0]&zero)|(branch[1]&(~zero));
decoder dec(op,memtoreg,memwrite,branch,alusrc,regdst,regwrite,aluop,jump,extmethod);
aludecoder aludec(funct,aluop,alucont);
endmodule
