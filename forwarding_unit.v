`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2021 12:24:00 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(ForwardA, ForwardB, one_ahead_flag, two_ahead_flag, IDEX_Rs, IDEX_Rt, MemDest, WriteBackDest, MEM_RegWrite, RegWriteWB);
output reg [1:0] ForwardA;
output reg [1:0] ForwardB;
output reg one_ahead_flag;
output reg two_ahead_flag;

input wire [4:0] IDEX_Rs;
input wire [4:0] IDEX_Rt;
input wire [4:0] MemDest;
input wire [4:0] WriteBackDest;
input wire MEM_RegWrite;
input wire RegWriteWB;

/*
ForwardA = ForwardB = 00 //initialize 11
Forwarding unit
IF (EX/MEM.RegisterRd == ID/EX.RegisterRs) ForwardA = 10
IF (EX/MEM.RegisterRd == ID/EX.RegisterRt) ForwardB = 10
IF (EX/MEM.RegisterRd ~= ID/EX.RegisterRs &&
MEM/WB.RegisterRd == ID/EX.Regis1terRs) ForwardA = 01
IF (EX/MEM.RegisterRd ~= ID/EX.RegisterRt &&
MEM/WB.RegisterRd == ID/EX.RegisterRt) ForwardB = 01
*/
always @(*) begin
ForwardA = 2'b0;
ForwardB = 2'b0;
one_ahead_flag = 0;
two_ahead_flag = 0;
/*
if (MemDest == IDEX_Rs) begin
    ForwardA = 10;
    one_ahead_flag = 1;
end
if (MemDest == IDEX_Rt) begin
    ForwardB = 10;
    one_ahead_flag = 1;
end
if ((MemDest != IDEX_Rs) && (WriteBackDest == IDEX_Rs)) begin
    ForwardA = 01;
    two_ahead_flag = 1;
end
if ((MemDest != IDEX_Rt) && (WriteBackDest == IDEX_Rt)) begin
    ForwardB = 01;
    two_ahead_flag = 1;
end
*/
//
if ((MEM_RegWrite && MemDest != 0) && (MemDest == IDEX_Rs)) begin
    ForwardA = 10;
    one_ahead_flag = 1;
end
if ((MEM_RegWrite && MemDest != 0) && (MemDest == IDEX_Rt)) begin
    ForwardB = 10;
    one_ahead_flag = 1;
end
if ((RegWriteWB != WriteBackDest) && (MemDest != IDEX_Rs) && (WriteBackDest == IDEX_Rs)) begin
    ForwardA = 01;
    two_ahead_flag = 1;
end
if ((RegWriteWB && WriteBackDest !=0) && (MemDest != IDEX_Rt) && (WriteBackDest == IDEX_Rt)) begin
    ForwardB = 01;
    two_ahead_flag = 1;
end
end

endmodule