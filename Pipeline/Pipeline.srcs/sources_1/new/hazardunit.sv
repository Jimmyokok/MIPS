`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/11 15:34:29
// Design Name: 
// Module Name: hazardunit
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


module hazardunit(
input logic pcsrc,jr,jump,[1:0]branch,
input logic memtoregE,memtoregM,regwriteE,regwriteM,regwriteW,[4:0]rsD,rtD,rsE,rtE,
input logic [4:0]writeregE,writeregM,writeregW,
output logic stallF,stallD,flushD,flushE,forwardAD,forwardBD,[1:0]forwardAE,forwardBE
    );
logic br,lwstall,branchstall;
assign br=(branch!=0);
assign stallF=lwstall|branchstall;
assign stallD=lwstall|branchstall;
assign flushE=lwstall|branchstall;
assign lwstall=memtoregE & ((rsD==rtE) | (rtD==rtE));
assign branchstall= br & ((memtoregM & ((writeregM==rsD)|(writeregM==rtD))));
assign flushD=(pcsrc|jr|jump)&(~branchstall);
assign forwardAD=(rsD!=0)&(rsD==writeregE)&regwriteE;
assign forwardBD=(rtD!=0)&(rtD==writeregE)&regwriteE;
assign forwardAE=(((rsE!=0)&(rsE==writeregM)&regwriteM))?2'b10:((((rsE!=0)&(rsE==writeregW)&regwriteW))?2'b01:2'b00);
assign forwardBE=(((rtE!=0)&(rtE==writeregM)&regwriteM))?2'b10:((((rtE!=0)&(rtE==writeregW)&regwriteW))?2'b01:2'b00);
endmodule
