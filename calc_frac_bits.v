`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2021 03:02:59 PM
// Design Name: 
// Module Name: calc_frac_bits
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

//removes the MSB that is 1, and outputs the four bits that follow
module calc_frac_bits(
    input [10:0] Frac_in,
    output [3:0] Frac_out
    );

    reg [3:0] frac;
    assign Frac_out = frac;

    always @(*) begin
        if(Frac_in[10]) frac <= Frac_in[9:6];
        else if(Frac_in[9]) frac <= Frac_in[8:5];
        else if(Frac_in[8]) frac <= Frac_in[7:4];
        else if(Frac_in[7]) frac <= Frac_in[6:3];
        else if(Frac_in[6]) frac <= Frac_in[5:2];
        else if(Frac_in[5]) frac <= Frac_in[4:1];
        else frac <= Frac_in[3:0];
    end

endmodule
