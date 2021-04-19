`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2021 08:05:03 PM
// Design Name: 
// Module Name: matrix_tb
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


module matrix_tb;

    reg clk;
    
    reg [7:0] A00;
    reg [7:0] A01;
    reg [7:0] A02;
    reg [7:0] A10;
    reg [7:0] A11;
    reg [7:0] A12;
    reg [7:0] A20;
    reg [7:0] A21;
    reg [7:0] A22;
    
    reg [7:0] B00;
    reg [7:0] B01;
    reg [7:0] B02;
    reg [7:0] B10;
    reg [7:0] B11;
    reg [7:0] B12;
    reg [7:0] B20;
    reg [7:0] B21;
    reg [7:0] B22;
    
    wire [7:0] Out00;
    wire [7:0] Out01;
    wire [7:0] Out02;
    wire [7:0] Out10;
    wire [7:0] Out11;
    wire [7:0] Out12;
    wire [7:0] Out20;
    wire [7:0] Out21;
    wire [7:0] Out22;
    
    reg Reset;
    reg Load;
    
    
    matrix matrix1 (
         clk,
         A00, A01, A02, A10, A11, A12, A20, A21, A22,
         B00, B01, B02, B10, B11, B12, B20, B21, B22,
         Out00, Out01, Out02, Out10, Out11, Out12, Out20, Out21, Out22,
         Reset, Load
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
        initial begin
           Reset = 0;
           Load = 1;
           
           #20
           A00 = 8'b00100100; A01= 8'b00100000; A02 = 8'b00100000; A10 = 8'b00100000; A11 = 8'b00100000; A12 = 8'b00100000; A20 = 8'b00100000; A21 = 8'b00100000; A22 = 8'b00100000;
           B00  = 8'b00101000;  B01 = 8'b00101000; B02 = 8'b00101000; B10 = 8'b00101000; B11 = 8'b00101000; B12 = 8'b00101000; B20 = 8'b00101000; B21 = 8'b00101000; B22 = 8'b00101000;
           
           #50
           
           Reset = 1;
        
        end
endmodule

