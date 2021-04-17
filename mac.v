`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2021 11:30:45 PM
// Design Name: 
// Module Name: mac
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


module mac(
    input Clk,
    input [7:0] Ain,
    input [7:0] B,
    input [7:0] C,
    input Reset,
    input Load,
    output Done,
    output [7:0] Aout
    );

    reg [2:0] cs = 0;
    reg [2:0] ns = 0;

    always @(posedge clk) begin
        cs <= ns;

        case(cs)
        0: begin
            
            end
        1: begin 
            
            end
        2: begin 
             
            end
        3: begin 
            
            end
         4: begin 
            
            end
         default: begin
            ns <= 0;
            end
        endcase
    end


endmodule
