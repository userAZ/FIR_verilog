`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2016 11:59:47 PM
// Design Name: 
// Module Name: fir_shifter_top
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


module fir_shifter_top #(parameter nbtap = 8, dsize = 16)
                        (input clk, input signed [dsize-1:0] datain, output signed [2*dsize-1:0] firout);
    
    wire signed [dsize-1:0] h [nbtap-1:0];
    wire signed [dsize-1:0] arraydata [nbtap-1:0];
    wire signed [dsize-1:0] arrayprod [nbtap-1:0];
    
    //wire signed [dsize-1:0] shifterout;
    reg  signed [dsize-1:0] dataz [nbtap-1:0];
    
    assign h[0] =   7;
    assign h[1] =   14;
    assign h[2] =   -138;
    assign h[3] =   129;
    assign h[4] =   129;
    assign h[5] =   -138;
    assign h[6] =   14;
    assign h[7] =   7;
    
    assign firout = arrayprod[nbtap-1];
    
    //sfir_shifter #(dsize, nbtap) shifter_inst0 (clk, datain, shifterout);
    
   generate
       genvar I;      
       for (I=0; I<nbtap; I=I+1)
         if (I==0)
           mac_element #(dsize) fte_inst0 (clk, h[I], datain, {32{1'b0}}, arraydata[I], arrayprod[I]);
         else
           mac_element #(dsize) fte_inst  (clk, h[I], arraydata[I-1], arrayprod[I-1], arraydata[I], arrayprod[I]);
    endgenerate

endmodule
