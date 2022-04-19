`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:32 03/21/2017 
// Design Name: 
// Module Name:    discussion_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////
module discussion_tb;

   // Inputs
   reg clk;
   reg Reset;
   reg LoadInstructions;
   reg [31:0] Instruction;
   
   // Outputs
   wire [31:0] out;
   
   // Instantiate the Unit Under Test (UUT)
   CPU uut (
            .out(out), 
            .clk(clk), 
            .Reset(Reset), 
            .LoadInstructions(LoadInstructions), 
            .Instruction(Instruction)
            );
   
   initial begin
      // Initialize Inputs
      clk = 0;
      Reset = 1;
      LoadInstructions = 0;
      Instruction = 0;
      #10;
      
      Reset = 0;
      LoadInstructions = 1;
      // #10;
      
      // 0
      Instruction = 32'b001000_00000_00001_0000000110100111; // addi $R1, $0, 423
      #10; // 1                                              // -> 423
      Instruction = 32'b001000_00000_00010_0000000001011100; // addi $R2, $0, 92
      #10; // 2                                              // -> 92
      Instruction = 32'b001000_00000_00011_0000000000001101; // addi $R3, $0, 13
      #10; // 3                                              // -> 13
      Instruction = 32'b001000_00000_00100_0000000010010010; // addi $R4, $0, 146
      #10; // 4                                              // -> 146
      Instruction = 32'b001000_00000_00101_0000000000000101; // addi $R5, $0, 5
      #10; // 5                                              // -> 5
      Instruction = 32'b000000_00001_00100_00101_00000_100000; // add $R5, $R1, $R4
      #10; // 6                                             // -> 569 (423 if wrong)
      Instruction = 32'b000000_00011_00101_00110_00000_101010; // slt $R6, $R3, $R5
      #10; // 7                                                // -> 1 (0 if wrong)
      Instruction = 32'b100011_00000_00100_0000000000000100;   // LW $R4, 4(R0)
      #10; // 8                                                // -> 4
      Instruction = 32'b000000_00100_00110_00111_00000_100010; // sub $R7, $R4, $R6
      #10; // 9                                         // -> 3 (146 or 145 if wrong)
      Instruction = 32'b101011_00000_00111_0000000000000000;   // SW $R7, 0(R0)
      #10; // 10
      Instruction = 32'b000000_00111_00010_01000_00000_100000; // add R8, R7, R2
      #10; // 11                                                //->92
      // 1 ahead forwarding
      Instruction = 32'b000000_00010_00011_00001_00000_100000; // add R1, R2, R3
      #10; // 12                                                // ->
      Instruction = 32'b000000_00001_01000_00100_00000_100000; // add R4, R1, R8
      #10; // 13
      // 2 ahead forwarding
      Instruction = 32'b000000_01000_01001_00111_00000_100000; // add R7, R8, R9
      #10; // 14
      Instruction = 32'b000000_01011_01100_01010_00000_100000; // add R10, R11, R12
      #10; // 15
      Instruction = 32'b000000_00111_00001_00011_00000_100000; // add R3, R7, R1
      #10; // 16                                                // ->105+92 = 197
      
      //3 ahead forwarding
      Instruction = 32'b000000_00010_00100_00001_00000_100000; // add R1, R2, R4
      #10; // 17
      Instruction = 32'b000000_00110_00111_00101_00000_100000; // add R5, R6, R7
      #10; // 18
      Instruction = 32'b000000_01001_01010_01000_00000_100000; // add R8, R9, R10
      #10; // 19
      Instruction = 32'b000000_00001_01011_01011_00000_100000; // add R11, R1, R11
      #10; // 20


		
      LoadInstructions = 0;
      Reset = 1;
      #10;
		
      Reset = 0;
      #100;
      
   end
	
   always begin
      #5;
      clk = ~clk;
   end
   
endmodule
