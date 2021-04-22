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

    reg [3:0] cs = 0;
    reg [4:0] ns = 0;
    reg stop;

    wire [3:0] frac_wire;
    wire [7:0]BC;

    reg [2:0]expB;
    reg [2:0]expC;

    reg [12:0] sum;
    reg [12:0] operand;
    reg [2:0] sum_exp;
    reg sum_sign_bit;
    reg [2:0] shift;
    reg [9:0] product;
    reg [3:0] exp_adder;
    reg sign_bit;
    reg [3:0]sum_frac;
    reg [7:0] result = 0;

    calc_frac_bits fraction(product, frac_wire);
    
    assign BC = {sign_bit, exp_adder[2:0], frac_wire};
    assign Aout = result;
    assign Done = stop;

    always @(posedge Clk) begin
        if(Reset) begin
            product <= 0;
            result <= Ain;
            sum <= 0;
            sum_exp <= 0;
            sum_sign_bit <= 0;
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
                if(B == 0 || C== 0) begin
                    sign_bit <= 0;
                    exp_adder <= 0;
                    product <= 0;

                    ns <= 3;
                end
                else begin 
                    product <= {7'h1, B[3:0]} * {7'h1, C[3:0]};

                    expB <= B[6:4]- 3;
                    expC <= C[6:4]- 3;
                    sign_bit <= B[7] ^ C[7];

                    ns <= 2;
                end
                end
            2: begin //End of multiplication
                ns <= 3;

                exp_adder <= expB + expC + 3 + product[9];

                end
            3: begin
                if(result == 0) begin 
                    result <= BC;
                    ns <= 0;
                end
                else if(BC == 0) begin
                    result <= result;
                    ns <= 0;
                end
                else begin
                    if(result[6:4] > BC[6:4])begin
                        sum <= {2'b01, result[3:0], 7'h00};
                        operand <= {2'b01, BC[3:0], 7'h00};
                        shift <= result[6:4] - BC[6:4];
                        sum_sign_bit <= result[7];
                        sum_exp <= result[6:4];
                    end
                    else if(BC[6:4] > result[6:4]) begin
                        sum <= {2'b01, BC[3:0], 7'h00};
                        operand <= {2'b01, result[3:0], 7'h00};
                        shift <= BC[6:4] - result[6:4];
                        sum_sign_bit <= BC[7];
                        sum_exp <= BC[6:4];
                    end
                    else if(result[3:0] > BC[3:0])begin
                        sum <= {2'b01, result[3:0], 7'h00};
                        operand <= {2'b01, BC[3:0], 7'h00};
                        shift <= result[6:4] - BC[6:4];
                        sum_sign_bit <= result[7];
                        sum_exp <= result[6:4];
                    end
                    else begin
                        sum <= {2'b01, BC[3:0], 7'h00};
                        operand <= {2'b01, result[3:0], 7'h00};
                        shift <= BC[6:4] - result[6:4];
                        sum_sign_bit <= BC[7];
                        sum_exp <= BC[6:4];
                    end

                    ns <= 7;
                end
                end
            4: begin 
                sum <= sum + operand;
                ns <= 6;
                end
            5: begin 
                sum <= sum - operand;
                ns <= 6;
                end
            6: begin 
                if(sum[12]) begin 
                    sum_exp <= sum_exp + 1;
                    sum_frac <= sum[11:8];
                end
                else if(sum[11]) begin
                    sum_exp <= sum_exp;
                    sum_frac <= sum[10:7];
                end
                else if(sum[10]) begin
                    sum_exp <= sum_exp - 1;
                    sum_frac <= sum[9:6];
                end
                else if(sum[9]) begin
                    sum_exp <= sum_exp - 2;
                    sum_frac <= sum[8:5];
                end
                else begin
                    sum_exp <= sum_exp - 3;
                    sum_frac <= sum[7:4];
                end

                ns <= 8;
                end
            7: begin 
                operand <= operand >> shift;

                if(result[7] == BC[7]) ns <= 4;
                else ns <= 5;
                end   
            8: begin 
                result <= {sum_sign_bit, sum_exp, sum_frac};

                ns <= 0;
            end
            default: begin
                ns <= 0;
                end
            endcase
        end
    end

    always @(negedge Clk) begin
        cs <= ns;
    end


endmodule
