`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 4/17/2021 06:58:59 PM
// Design Name: 
// Module Name: mult
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


module mult(
    input clk, 
    input start, // Center button
    input [7:0] A, // Multiplicand 1
    input [7:0] B, // Multiplicand 2
    output stop, // Stop signal 
    output reg [7:0] product // Product
    );
    
    wire [7:0] prod_wire;
    wire [3:0] frac_wire;
    wire [10:0] nextshift_wire;

    calc_frac_bits fraction(nextshift_wire, frac_wire);
    
    reg [2:0] cs, ns;
    reg [2:0] count, nextcount;
    reg done;
    reg [4:0] multiplicand;
    reg [4:0] exp_adder;
    reg [10:0] shift_reg, nextshift_reg;
    reg sign_bit;
    
    assign stop = done;
    assign prod_wire = {sign_bit, exp_adder[2:0], frac_wire};
    assign nextshift_wire = nextshift_reg;

    initial begin
        cs = 0;
        ns = 0;
        count = 0;
        nextcount = 0;
        done = 1;
        product = 0;
        multiplicand = 0;
        exp_adder = 0;
        shift_reg = 0;
        sign_bit = 0;
    end


    always @(*) begin
        case(cs)
        0: begin // Idle state - set stop to 1
            nextcount <= 0;
            done <= 1;
            if(start) ns <= 1;
            else ns <= 0;
            end
        1: begin // Init state - load the registers with the multiplicands
            ns <= 2;
            done <= 0;
            nextshift_reg <= {7'h1, A[3:0]};
            multiplicand <= {1'b1, B[3:0]};
            exp_adder <= A[6:4] + B[6:4] - 3;
            sign_bit <= A[7] ^ B[7];
            end
        2: begin // Test state
            if(nextshift_reg[0]) ns <= 3;
            else ns <= 4;         
            end
        3: begin // Add state
            ns <= 4;
            nextshift_reg[10:5] = shift_reg[10:5] + multiplicand;
            end
        4: begin // Shift state
            nextshift_reg <= shift_reg >> 1;
            nextcount <= count + 1;
            if(count + 1 == 5) begin
                ns <= 0;
                if(nextshift_reg[10]) exp_adder <= exp_adder + 1;
            end
            else ns <= 2;
            end
         default: begin
            nextcount <= 0;
            ns <= 0;
            end
        endcase
    end
    

    always @(posedge clk) begin
        product <= prod_wire;
        shift_reg <= nextshift_reg;
        cs <= ns;
        count <= nextcount;
        end
    

endmodule
