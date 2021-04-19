`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2021 05:56:45 PM
// Design Name: 
// Module Name: matrix
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


module matrix(
    input clk,

    input [7:0] A00,
    input [7:0] A01,
    input [7:0] A02,
    input [7:0] A10,
    input [7:0] A11,
    input [7:0] A12,
    input [7:0] A20,
    input [7:0] A21,
    input [7:0] A22,
    
    input [7:0] B00,
    input [7:0] B01,
    input [7:0] B02,
    input [7:0] B10,
    input [7:0] B11,
    input [7:0] B12,
    input [7:0] B20,
    input [7:0] B21,
    input [7:0] B22,
    
    output[7:0] Out00,
    output[7:0] Out01,
    output[7:0] Out02,
    output[7:0] Out10,
    output[7:0] Out11,
    output[7:0] Out12,
    output[7:0] Out20,
    output[7:0] Out21,
    output[7:0] Out22,

    input Reset,
    input Load,
    output reg Done
    );
    
    
    wire [7:0] Aout;
    
    //these are temp regs for the B and C inputs for the MAC
    reg [7:0] B_00;
    reg [7:0] B_01;
    reg [7:0] B_02;
    reg [7:0] B_10;
    reg [7:0] B_11;
    reg [7:0] B_12;
    reg [7:0] B_20;
    reg [7:0] B_21;
    reg [7:0] B_22;
    reg [7:0] C_00;
    reg [7:0] C_01;
    reg [7:0] C_02;
    reg [7:0] C_10;
    reg [7:0] C_11;
    reg [7:0] C_12;
    reg [7:0] C_20;
    reg [7:0] C_21;
    reg [7:0] C_22;
    
    reg [8:0] load_mac;
    wire [8:0] done_mac;
    
    reg [2:0] cs = 0;
    reg [2:0] ns = 0;
    
    mac mac_00(.Clk(clk), .Ain(0), .B(B_00), .C(C_00), .Reset(Reset), .Load(load_mac[0]), .Done(done_mac[0]), .Aout(Out00));
    mac mac_01(.Clk(clk), .Ain(0), .B(B_01), .C(C_01), .Reset(Reset), .Load(load_mac[1]), .Done(done_mac[1]), .Aout(Out01));
    mac mac_02(.Clk(clk), .Ain(0), .B(B_02), .C(C_02), .Reset(Reset), .Load(load_mac[2]), .Done(done_mac[2]), .Aout(Out02));
    mac mac_10(.Clk(clk), .Ain(0), .B(B_10), .C(C_10), .Reset(Reset), .Load(load_mac[3]), .Done(done_mac[3]), .Aout(Out10));
    mac mac_11(.Clk(clk), .Ain(0), .B(B_11), .C(C_11), .Reset(Reset), .Load(load_mac[4]), .Done(done_mac[4]), .Aout(Out11));
    mac mac_12(.Clk(clk), .Ain(0), .B(B_12), .C(C_12), .Reset(Reset), .Load(load_mac[5]), .Done(done_mac[5]), .Aout(Out12));
    mac mac_20(.Clk(clk), .Ain(0), .B(B_20), .C(C_20), .Reset(Reset), .Load(load_mac[6]), .Done(done_mac[6]), .Aout(Out20));
    mac mac_21(.Clk(clk), .Ain(0), .B(B_21), .C(C_21), .Reset(Reset), .Load(load_mac[7]), .Done(done_mac[7]), .Aout(Out21));
    mac mac_22(.Clk(clk), .Ain(0), .B(B_22), .C(C_22), .Reset(Reset), .Load(load_mac[8]), .Done(done_mac[8]), .Aout(Out22));
    
    initial begin
        load_mac = 0;
    end

    always @(*) begin

        if(Reset)begin
            ns <= 0;
        end
        else begin
            case(cs)

            0: begin
                Done <= 1;
                if(Load == 1) begin
                    ns <= 1;
                end
                else begin
                    ns <= 0;
                end
            end
            
            1: begin  // sets initial top left multiplicands
                Done <= 0;
                load_mac = 9'b000000001  & done_mac;
                B_00 <= A00;
                C_00 <= B00;
                ns <= 2;
                end
                
            2: begin
                load_mac = 9'b000001011  & done_mac;
                B_00 <= B10;
                C_00 <= A01;
                
                B_01 <= B01;
                C_01 <= A00;

                B_10 <= B00;
                C_10 <= A10; 
                
                ns <= 3; 
                end
            3: begin 
                load_mac = 9'b001011111  & done_mac;
                B_00 <= B20;
                C_00 <= A02;
                
                B_01 <= B11;
                C_01 <= A01;

                B_10 <= B10;
                C_10 <= A11; 
                
                B_02 <= B02;
                C_02 <= A00;
                
                B_01 <= B01;
                C_10 <= A10;

                B_20 <= B00;
                C_20 <= A20;   
                
                ns <= 4;

                end
            4: begin
                load_mac = 9'b011111111  & done_mac;
                B_01 <= B21;
                C_01 <= A02;

                B_10 <= B20;
                C_10 <= A12; 
                
                B_02 <= B12;
                C_02 <= A01;
                
                B_01 <= B11;
                C_10 <= A11;

                B_20 <= B10;
                C_20 <= A21; 
                
                B_12 <= B02;
                C_12 <= A10;

                B_21 <= B01;
                C_21 <= A20;  
                
                ns <= 5; 
                
                end
            5: begin 
                load_mac = 9'b111111111  & done_mac;
                B_02 <= B22;
                C_02 <= A02;
                
                B_01 <= B21;
                C_10 <= A12;

                B_20 <= B20;
                C_20 <= A22; 
                
                B_12 <= B12;
                C_12 <= A11;

                B_21 <= B11;
                C_21 <= A21;
                
                B_22 <= B02;
                C_22 <= A20;
                
                ns <= 6;
                
                end
            6: begin 
                load_mac = 9'b111111111  & done_mac;
                B_12 <= B22;
                C_12 <= A12;

                B_21 <= B21;
                C_21 <= A22;
                
                B_22 <= B12;
                C_22 <= A21;
                
                ns <= 7;
                
                end
                
            7: begin 
                load_mac = 9'b111111111  & done_mac;
                B_22 <= B22;
                C_22 <= A22;
                ns <= 0;
                end
            default: begin
                ns <= 0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        cs <= ns;
    end
      
endmodule
