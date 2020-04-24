`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/04 15:22:03
// Design Name: 
// Module Name: top
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
module top(
input logic clk,reset
);

wire mem_write, cpu_clk, finish, cpu_mem_write;
wire [31:0] pc, instr, read_data, write_data, cpu_data_addr;

reg [31:0] tb_data_addr, tb_dmem_data, pc_finished;
// module instances
mips mips(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memwrite(cpu_mem_write), .aluout(cpu_data_addr), .writedata(write_data), .readdata(read_data));
imem imem(.a(pc[7:2]), .rd(instr));
dmem dmem(.clk(clk), .we(cpu_mem_write), .a(cpu_data_addr), .wd(write_data), .rd(read_data));
endmodule
