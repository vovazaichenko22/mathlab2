// -------------------------------------------------------------
// 
// File Name: F:\apparatlab2\fixed\calk\CALC_MAGNITUDE_AND_PHASE_FIXED.v
// Created: 2023-01-16 23:59:55
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 1
// Target subsystem base rate: 1
// 
// 
// Clock Enable  Sample Time
// -- -------------------------------------------------------------
// ce_out        1
// -- -------------------------------------------------------------
// 
// 
// Output Signal                 Clock Enable  Sample Time
// -- -------------------------------------------------------------
// o_PHASE                       ce_out        1
// o_MAGNITUDE                   ce_out        1
// o_VALID                       ce_out        1
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: CALC_MAGNITUDE_AND_PHASE_FIXED
// Source Path: calk/CALC_MAGNITUDE_AND_PHASE_FIXED
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module CALC_MAGNITUDE_AND_PHASE_FIXED
          (clk,
           reset,
           clk_enable,
           i_COMPLEX_VALUE_re,
           i_COMPLEX_VALUE_im,
           i_VALID,
           ce_out,
           o_PHASE,
           o_MAGNITUDE,
           o_VALID);


  input   clk;
  input   reset;
  input   clk_enable;
  input   signed [31:0] i_COMPLEX_VALUE_re;  // sfix32_En27
  input   signed [31:0] i_COMPLEX_VALUE_im;  // sfix32_En27
  input   i_VALID;
  output  ce_out;
  output  signed [15:0] o_PHASE;  // sfix16_En13
  output  signed [32:0] o_MAGNITUDE;  // sfix33_En18
  output  o_VALID;


  wire enb;
  wire signed [31:0] Atan2_out1;  // sfix32_En29
  wire signed [15:0] Data_Type_Conversion2_out1;  // sfix16_En13
  wire signed [63:0] Product_out1;  // sfix64_En54
  wire signed [63:0] Product1_out1;  // sfix64_En54
  wire signed [64:0] Add_add_cast;  // sfix65_En54
  wire signed [64:0] Add_add_cast_1;  // sfix65_En54
  wire signed [64:0] Add_add_temp;  // sfix65_En54
  wire [64:0] Add_out1;  // ufix65_En55
  wire signed [32:0] Sqrt_out1;  // sfix33_En18
  reg signed [32:0] delayMatch_reg [0:7];  // sfix33 [8]
  wire signed [32:0] delayMatch_reg_next [0:7];  // sfix33_En18 [8]
  wire signed [32:0] Sqrt_out1_1;  // sfix33_En18
  reg  [0:32] delayMatch1_reg;  // ufix1 [33]
  wire [0:32] delayMatch1_reg_next;  // ufix1 [33]
  wire i_VALID_1;


  atan2_cordic_nw u_Atan2_inst (.clk(clk),
                                .reset(reset),
                                .enb(clk_enable),
                                .y_in(i_COMPLEX_VALUE_im),  // sfix32_En27
                                .x_in(i_COMPLEX_VALUE_re),  // sfix32_En27
                                .angle(Atan2_out1)  // sfix32_En29
                                );

  assign Data_Type_Conversion2_out1 = Atan2_out1[31:16];



  assign o_PHASE = Data_Type_Conversion2_out1;

  assign Product_out1 = i_COMPLEX_VALUE_re * i_COMPLEX_VALUE_re;



  assign Product1_out1 = i_COMPLEX_VALUE_im * i_COMPLEX_VALUE_im;



  assign Add_add_cast = {Product_out1[63], Product_out1};
  assign Add_add_cast_1 = {Product1_out1[63], Product1_out1};
  assign Add_add_temp = Add_add_cast + Add_add_cast_1;
  assign Add_out1 = {Add_add_temp[63:0], 1'b0};



  Sqrt u_Sqrt (.clk(clk),
               .reset(reset),
               .enb(clk_enable),
               .din(Add_out1),  // ufix65_En55
               .dout(Sqrt_out1)  // sfix33_En18
               );

  assign enb = clk_enable;

  always @(posedge clk or posedge reset)
    begin : delayMatch_process
      if (reset == 1'b1) begin
        delayMatch_reg[0] <= 33'sh000000000;
        delayMatch_reg[1] <= 33'sh000000000;
        delayMatch_reg[2] <= 33'sh000000000;
        delayMatch_reg[3] <= 33'sh000000000;
        delayMatch_reg[4] <= 33'sh000000000;
        delayMatch_reg[5] <= 33'sh000000000;
        delayMatch_reg[6] <= 33'sh000000000;
        delayMatch_reg[7] <= 33'sh000000000;
      end
      else begin
        if (enb) begin
          delayMatch_reg[0] <= delayMatch_reg_next[0];
          delayMatch_reg[1] <= delayMatch_reg_next[1];
          delayMatch_reg[2] <= delayMatch_reg_next[2];
          delayMatch_reg[3] <= delayMatch_reg_next[3];
          delayMatch_reg[4] <= delayMatch_reg_next[4];
          delayMatch_reg[5] <= delayMatch_reg_next[5];
          delayMatch_reg[6] <= delayMatch_reg_next[6];
          delayMatch_reg[7] <= delayMatch_reg_next[7];
        end
      end
    end

  assign Sqrt_out1_1 = delayMatch_reg[7];
  assign delayMatch_reg_next[0] = Sqrt_out1;
  assign delayMatch_reg_next[1] = delayMatch_reg[0];
  assign delayMatch_reg_next[2] = delayMatch_reg[1];
  assign delayMatch_reg_next[3] = delayMatch_reg[2];
  assign delayMatch_reg_next[4] = delayMatch_reg[3];
  assign delayMatch_reg_next[5] = delayMatch_reg[4];
  assign delayMatch_reg_next[6] = delayMatch_reg[5];
  assign delayMatch_reg_next[7] = delayMatch_reg[6];



  assign o_MAGNITUDE = Sqrt_out1_1;

  always @(posedge clk or posedge reset)
    begin : delayMatch1_process
      if (reset == 1'b1) begin
        delayMatch1_reg[0] <= 1'b0;
        delayMatch1_reg[1] <= 1'b0;
        delayMatch1_reg[2] <= 1'b0;
        delayMatch1_reg[3] <= 1'b0;
        delayMatch1_reg[4] <= 1'b0;
        delayMatch1_reg[5] <= 1'b0;
        delayMatch1_reg[6] <= 1'b0;
        delayMatch1_reg[7] <= 1'b0;
        delayMatch1_reg[8] <= 1'b0;
        delayMatch1_reg[9] <= 1'b0;
        delayMatch1_reg[10] <= 1'b0;
        delayMatch1_reg[11] <= 1'b0;
        delayMatch1_reg[12] <= 1'b0;
        delayMatch1_reg[13] <= 1'b0;
        delayMatch1_reg[14] <= 1'b0;
        delayMatch1_reg[15] <= 1'b0;
        delayMatch1_reg[16] <= 1'b0;
        delayMatch1_reg[17] <= 1'b0;
        delayMatch1_reg[18] <= 1'b0;
        delayMatch1_reg[19] <= 1'b0;
        delayMatch1_reg[20] <= 1'b0;
        delayMatch1_reg[21] <= 1'b0;
        delayMatch1_reg[22] <= 1'b0;
        delayMatch1_reg[23] <= 1'b0;
        delayMatch1_reg[24] <= 1'b0;
        delayMatch1_reg[25] <= 1'b0;
        delayMatch1_reg[26] <= 1'b0;
        delayMatch1_reg[27] <= 1'b0;
        delayMatch1_reg[28] <= 1'b0;
        delayMatch1_reg[29] <= 1'b0;
        delayMatch1_reg[30] <= 1'b0;
        delayMatch1_reg[31] <= 1'b0;
        delayMatch1_reg[32] <= 1'b0;
      end
      else begin
        if (enb) begin
          delayMatch1_reg[0] <= delayMatch1_reg_next[0];
          delayMatch1_reg[1] <= delayMatch1_reg_next[1];
          delayMatch1_reg[2] <= delayMatch1_reg_next[2];
          delayMatch1_reg[3] <= delayMatch1_reg_next[3];
          delayMatch1_reg[4] <= delayMatch1_reg_next[4];
          delayMatch1_reg[5] <= delayMatch1_reg_next[5];
          delayMatch1_reg[6] <= delayMatch1_reg_next[6];
          delayMatch1_reg[7] <= delayMatch1_reg_next[7];
          delayMatch1_reg[8] <= delayMatch1_reg_next[8];
          delayMatch1_reg[9] <= delayMatch1_reg_next[9];
          delayMatch1_reg[10] <= delayMatch1_reg_next[10];
          delayMatch1_reg[11] <= delayMatch1_reg_next[11];
          delayMatch1_reg[12] <= delayMatch1_reg_next[12];
          delayMatch1_reg[13] <= delayMatch1_reg_next[13];
          delayMatch1_reg[14] <= delayMatch1_reg_next[14];
          delayMatch1_reg[15] <= delayMatch1_reg_next[15];
          delayMatch1_reg[16] <= delayMatch1_reg_next[16];
          delayMatch1_reg[17] <= delayMatch1_reg_next[17];
          delayMatch1_reg[18] <= delayMatch1_reg_next[18];
          delayMatch1_reg[19] <= delayMatch1_reg_next[19];
          delayMatch1_reg[20] <= delayMatch1_reg_next[20];
          delayMatch1_reg[21] <= delayMatch1_reg_next[21];
          delayMatch1_reg[22] <= delayMatch1_reg_next[22];
          delayMatch1_reg[23] <= delayMatch1_reg_next[23];
          delayMatch1_reg[24] <= delayMatch1_reg_next[24];
          delayMatch1_reg[25] <= delayMatch1_reg_next[25];
          delayMatch1_reg[26] <= delayMatch1_reg_next[26];
          delayMatch1_reg[27] <= delayMatch1_reg_next[27];
          delayMatch1_reg[28] <= delayMatch1_reg_next[28];
          delayMatch1_reg[29] <= delayMatch1_reg_next[29];
          delayMatch1_reg[30] <= delayMatch1_reg_next[30];
          delayMatch1_reg[31] <= delayMatch1_reg_next[31];
          delayMatch1_reg[32] <= delayMatch1_reg_next[32];
        end
      end
    end

  assign i_VALID_1 = delayMatch1_reg[32];
  assign delayMatch1_reg_next[0] = i_VALID;
  assign delayMatch1_reg_next[1] = delayMatch1_reg[0];
  assign delayMatch1_reg_next[2] = delayMatch1_reg[1];
  assign delayMatch1_reg_next[3] = delayMatch1_reg[2];
  assign delayMatch1_reg_next[4] = delayMatch1_reg[3];
  assign delayMatch1_reg_next[5] = delayMatch1_reg[4];
  assign delayMatch1_reg_next[6] = delayMatch1_reg[5];
  assign delayMatch1_reg_next[7] = delayMatch1_reg[6];
  assign delayMatch1_reg_next[8] = delayMatch1_reg[7];
  assign delayMatch1_reg_next[9] = delayMatch1_reg[8];
  assign delayMatch1_reg_next[10] = delayMatch1_reg[9];
  assign delayMatch1_reg_next[11] = delayMatch1_reg[10];
  assign delayMatch1_reg_next[12] = delayMatch1_reg[11];
  assign delayMatch1_reg_next[13] = delayMatch1_reg[12];
  assign delayMatch1_reg_next[14] = delayMatch1_reg[13];
  assign delayMatch1_reg_next[15] = delayMatch1_reg[14];
  assign delayMatch1_reg_next[16] = delayMatch1_reg[15];
  assign delayMatch1_reg_next[17] = delayMatch1_reg[16];
  assign delayMatch1_reg_next[18] = delayMatch1_reg[17];
  assign delayMatch1_reg_next[19] = delayMatch1_reg[18];
  assign delayMatch1_reg_next[20] = delayMatch1_reg[19];
  assign delayMatch1_reg_next[21] = delayMatch1_reg[20];
  assign delayMatch1_reg_next[22] = delayMatch1_reg[21];
  assign delayMatch1_reg_next[23] = delayMatch1_reg[22];
  assign delayMatch1_reg_next[24] = delayMatch1_reg[23];
  assign delayMatch1_reg_next[25] = delayMatch1_reg[24];
  assign delayMatch1_reg_next[26] = delayMatch1_reg[25];
  assign delayMatch1_reg_next[27] = delayMatch1_reg[26];
  assign delayMatch1_reg_next[28] = delayMatch1_reg[27];
  assign delayMatch1_reg_next[29] = delayMatch1_reg[28];
  assign delayMatch1_reg_next[30] = delayMatch1_reg[29];
  assign delayMatch1_reg_next[31] = delayMatch1_reg[30];
  assign delayMatch1_reg_next[32] = delayMatch1_reg[31];



  assign o_VALID = i_VALID_1;

  assign ce_out = clk_enable;

endmodule  // CALC_MAGNITUDE_AND_PHASE_FIXED

