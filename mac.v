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
    reg stop;

    wire [3:0] frac_wire;
    wire [7:0]BC;

    reg [2:0]expB;
    reg [2:0]expC;

    reg [9:0] product;
    reg [3:0] exp_adder;
    reg sign_bit;
    reg [7:0] result;

    calc_frac_bits fraction(product, frac_wire);
    
    assign BC = {sign_bit, exp_adder[2:0], frac_wire};
    assign Aout = result;
    assign Done = stop;

    always @(*) begin
        if(Reset) begin
            product <= 0;
            result <= 0;
            exp_adder <= 0;
            sign_bit <= 0;
            expB <= 0;
            expC <= 0;
            ns <= 0;
        end
        else begin
            case(cs)
            0: begin
                stop <= 1;

                if(Load) ns <= 1;
                else ns <= 0;
                end
            1: begin 
                stop <= 0;
                if(B == 0 || C== 0) product <= 0;
                else product <= {7'h1, B[3:0]} * {7'h1, C[3:0]};

                expB <= B[6:4]- 3;
                expC <= C[6:4]- 3;
                sign_bit <= B[7] ^ C[7];

                ns <= 2;
                end
            2: begin //End of multiplication
                ns <= 3;

                exp_adder <= expB + expC + 3 + product[9];

                end
            3: begin
                if(Ain == 0) begin 
                    result <= BC;
                    ns <= 0;
                end
                else if(BC == 0) begin
                    result <= Ain;
                    ns <= 0;
                end
                else begin
                    
                    ns <= 4;
                end
                end
            4: begin 
                ns <= 0;
                end
            default: begin
                ns <= 0;
                end
            endcase
        end
    end

    always @(posedge Clk) begin
        cs <= ns;
    end


endmodule
