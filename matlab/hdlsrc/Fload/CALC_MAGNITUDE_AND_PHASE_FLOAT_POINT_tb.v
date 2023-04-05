// -------------------------------------------------------------
// 
// File Name: hdlsrc\Fload\CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT_tb.v
// Created: 2023-04-05 23:03:53
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
// o_VALID                       ce_out        1
// o_MAGNITUDE                   ce_out        1
// o_PHASE                       ce_out        1
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT_tb
// Source Path: 
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT_tb;



  reg  I_CLK;
  reg  I_RST_N;
  wire I_CLK_EN;
  wire rawData_i_WALID;
  wire o_PHASE_done;  // ufix1
  wire rdEnb;
  wire o_PHASE_done_enb;  // ufix1
  reg [3:0] o_VALID_addr;  // ufix4
  wire o_PHASE_lastAddr;  // ufix1
  reg  check3_done;  // ufix1
  wire o_MAGNITUDE_done;  // ufix1
  wire o_MAGNITUDE_done_enb;  // ufix1
  wire o_MAGNITUDE_lastAddr;  // ufix1
  reg  check2_done;  // ufix1
  wire o_VALID_done;  // ufix1
  wire o_VALID_done_enb;  // ufix1
  wire o_VALID_active;  // ufix1
  reg [3:0] Constant_out1_addr;  // ufix4
  wire [31:0] i_COMPLEX_VALUE_im_table_data [0:10];  // ufix32 [11]
  wire [31:0] rawData_i_COMPLEX_VALUE_im;  // ufix32
  reg [31:0] holdData_i_COMPLEX_VALUE_im;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_im_offset;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_im_1;  // ufix32
  wire [31:0] i_COMPLEX_VALUE_im_2;  // ufix32
  wire Constant_out1_active;  // ufix1
  reg  tb_enb_delay;
  wire Constant_out1_enb;  // ufix1
  wire [31:0] i_COMPLEX_VALUE_re_table_data [0:10];  // ufix32 [11]
  wire [31:0] rawData_i_COMPLEX_VALUE_re;  // ufix32
  reg [31:0] holdData_i_COMPLEX_VALUE_re;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_re_offset;  // ufix32
  reg [31:0] i_COMPLEX_VALUE_re_1;  // ufix32
  wire [31:0] i_COMPLEX_VALUE_re_2;  // ufix32
  reg  holdData_i_WALID;
  reg  i_WALID_offset;
  wire i_WALID_1;
  wire snkDone;
  wire snkDonen;
  wire tb_enb;
  wire ce_out;
  wire o_VALID;
  wire [31:0] o_MAGNITUDE;  // ufix32
  wire [31:0] o_PHASE;  // ufix32
  wire o_VALID_enb;  // ufix1
  wire o_VALID_lastAddr;  // ufix1
  reg  check1_done;  // ufix1
  reg [5:0] o_VALID_chkcnt;  // ufix6
  wire o_VALID_ignCntDone;  // ufix1
  wire o_VALID_needToCount;  // ufix1
  wire o_VALID_chkenb;  // ufix1
  wire o_VALID_chkdata;  // ufix1
  wire o_VALID_expected_1;
  wire o_VALID_ref;
  reg  o_VALID_testFailure;  // ufix1
  reg [5:0] o_MAGNITUDE_chkcnt;  // ufix6
  wire o_MAGNITUDE_ignCntDone;  // ufix1
  wire o_MAGNITUDE_needToCount;  // ufix1
  wire o_MAGNITUDE_chkenb;  // ufix1
  wire o_MAGNITUDE_chkdata;  // ufix1
  wire [31:0] o_MAGNITUDE_expected_1;  // ufix32
  wire [31:0] o_MAGNITUDE_ref;  // ufix32
  reg  o_MAGNITUDE_testFailure;  // ufix1
  reg [5:0] o_PHASE_chkcnt;  // ufix6
  wire o_PHASE_ignCntDone;  // ufix1
  wire o_PHASE_needToCount;  // ufix1
  wire o_PHASE_chkenb;  // ufix1
  wire o_PHASE_chkdata;  // ufix1
  wire [31:0] o_PHASE_expected_1;  // ufix32
  wire [31:0] o_PHASE_ref;  // ufix32
  reg  o_PHASE_testFailure;  // ufix1
  wire testFailure;  // ufix1

  function real absReal(input real num);
  begin
    if (num < 0)
      absReal = -num;
    else
      absReal = num;
  end
  endfunction

  function real floatHalfToReal;
  input [15:0] x;
  reg [63:0] conv;

  begin
    conv[63] = x[15]; // sign 
    if (x[14:10] == 5'b0) // exp 
      conv[62:52] = 11'b0; 
    else
      conv[62:52] = 1023 + (x[14:10] - 15);
    conv[51:42] = x[9:0]; // mantissa 
    conv[41:0] = 42'b0;
    if (((x[14:10] == 5'h1F) && (x[9:0] != 10'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatHalfToReal = $bitstoreal(conv);
  end
  endfunction

  function real floatSingleToReal;
  input [31:0] x;
  reg [63:0] conv;

  begin
    conv[63] = x[31]; // sign 
    if (x[30:23] == 8'b0) // exp 
      conv[62:52] = 11'b0; 
    else
      conv[62:52] = 1023 + (x[30:23] - 127);
    conv[51:29] = x[22:0]; // mantissa 
    conv[28:0] = 29'b0;
    if (((x[30:23] == 8'hFF) && (x[22:0] != 23'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatSingleToReal = $bitstoreal(conv);
  end
  endfunction

  function real floatDoubleToReal;
  input [63:0] x;
  reg [63:0] conv;

  begin
    conv[63:0] = x[63:0]; 
    if (((x[62:52] == 11'h7FF) && (x[51:0] != 52'h0))) // check for NaN 
    begin
      conv[63] = 1'b0;
      conv[62:52] = 11'h7FF;
      conv[51:0] = 52'h0;
    end
    floatDoubleToReal = $bitstoreal(conv);
  end
  endfunction

  function isFloatEpsEqual(input real a, input real b, input real eps);
  real absdiff;

  begin
    absdiff = absReal(a - b);
    if (absdiff < eps) // absolute error check 
      isFloatEpsEqual = 1;
    else if (a == b) // check infinities 
      isFloatEpsEqual = 1; 
    else if (a*b == 0.0) // either is zero 
      isFloatEpsEqual = (absdiff < eps);
    else if (absReal(a) < absReal(b)) // relative error check
      isFloatEpsEqual = absdiff/absReal(b) < eps;
    else
      isFloatEpsEqual = absdiff/absReal(a) < eps;
  end
  endfunction
  function isFloatHalfEpsEqual;
  input [15:0] x;
  input [15:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatHalfToReal(x);
    b = floatHalfToReal(y);
    isFloatHalfEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction
  function isFloatSingleEpsEqual;
  input [31:0] x;
  input [31:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatSingleToReal(x);
    b = floatSingleToReal(y);
    isFloatSingleEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction
  function isFloatDoubleEpsEqual;
  input [63:0] x;
  input [63:0] y;
  input real eps;
  real a, b;
  real absdiff;

  begin
    a = floatDoubleToReal(x);
    b = floatDoubleToReal(y);
    isFloatDoubleEpsEqual = isFloatEpsEqual(a, b, eps);
  end
  endfunction

  // Data source for i_WALID
  assign rawData_i_WALID = 1'b1;



  assign o_PHASE_done_enb = o_PHASE_done & rdEnb;



  assign o_PHASE_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_PHASE_done = o_PHASE_lastAddr & I_RST_N;



  // Delay to allow last sim cycle to complete
  always @(posedge I_CLK or negedge I_RST_N)
    begin : checkDone_3
      if (!I_RST_N) begin
        check3_done <= 0;
      end
      else begin
        if (o_PHASE_done_enb) begin
          check3_done <= o_PHASE_done;
        end
      end
    end

  assign o_MAGNITUDE_done_enb = o_MAGNITUDE_done & rdEnb;



  assign o_MAGNITUDE_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_MAGNITUDE_done = o_MAGNITUDE_lastAddr & I_RST_N;



  // Delay to allow last sim cycle to complete
  always @(posedge I_CLK or negedge I_RST_N)
    begin : checkDone_2
      if (!I_RST_N) begin
        check2_done <= 0;
      end
      else begin
        if (o_MAGNITUDE_done_enb) begin
          check2_done <= o_MAGNITUDE_done;
        end
      end
    end

  assign o_VALID_done_enb = o_VALID_done & rdEnb;



  assign o_VALID_active = o_VALID_addr != 4'b1010;



  // Data source for i_COMPLEX_VALUE_im
  assign i_COMPLEX_VALUE_im_table_data[0] = 32'h491167fe;
  assign i_COMPLEX_VALUE_im_table_data[1] = 32'h4885c724;
  assign i_COMPLEX_VALUE_im_table_data[2] = 32'h49b56d3c;
  assign i_COMPLEX_VALUE_im_table_data[3] = 32'h483a616f;
  assign i_COMPLEX_VALUE_im_table_data[4] = 32'h498a6f6f;
  assign i_COMPLEX_VALUE_im_table_data[5] = 32'h499a69a0;
  assign i_COMPLEX_VALUE_im_table_data[6] = 32'h498d2210;
  assign i_COMPLEX_VALUE_im_table_data[7] = 32'h49b7c5dc;
  assign i_COMPLEX_VALUE_im_table_data[8] = 32'h487d0f19;
  assign i_COMPLEX_VALUE_im_table_data[9] = 32'h49bd651d;
  assign i_COMPLEX_VALUE_im_table_data[10] = 32'h48e8c37b;
  assign rawData_i_COMPLEX_VALUE_im = i_COMPLEX_VALUE_im_table_data[Constant_out1_addr];



  // holdData reg for Cast_To_Single_out1
  always @(posedge I_CLK or negedge I_RST_N)
    begin : stimuli_Cast_To_Single_out1
      if (!I_RST_N) begin
        holdData_i_COMPLEX_VALUE_im <= 32'bx;
      end
      else begin
        holdData_i_COMPLEX_VALUE_im <= rawData_i_COMPLEX_VALUE_im;
      end
    end

  always @(rawData_i_COMPLEX_VALUE_im or rdEnb)
    begin : stimuli_Cast_To_Single_out1_1
      if (rdEnb == 1'b0) begin
        i_COMPLEX_VALUE_im_offset <= holdData_i_COMPLEX_VALUE_im;
      end
      else begin
        i_COMPLEX_VALUE_im_offset <= rawData_i_COMPLEX_VALUE_im;
      end
    end

  always #2 i_COMPLEX_VALUE_im_1 <= i_COMPLEX_VALUE_im_offset;

  assign i_COMPLEX_VALUE_im_2 = i_COMPLEX_VALUE_im_1;

  assign Constant_out1_active = Constant_out1_addr != 4'b1010;



  assign Constant_out1_enb = Constant_out1_active & (rdEnb & tb_enb_delay);



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 10
  always @(posedge I_CLK or negedge I_RST_N)
    begin : Constant_process
      if (I_RST_N == 1'b0) begin
        Constant_out1_addr <= 4'b0000;
      end
      else begin
        if (Constant_out1_enb) begin
          if (Constant_out1_addr >= 4'b1010) begin
            Constant_out1_addr <= 4'b0000;
          end
          else begin
            Constant_out1_addr <= Constant_out1_addr + 4'b0001;
          end
        end
      end
    end



  // Data source for i_COMPLEX_VALUE_re
  assign i_COMPLEX_VALUE_re_table_data[0] = 32'h49c565fd;
  assign i_COMPLEX_VALUE_re_table_data[1] = 32'h49ab8f84;
  assign i_COMPLEX_VALUE_re_table_data[2] = 32'h49377376;
  assign i_COMPLEX_VALUE_re_table_data[3] = 32'h49fef73f;
  assign i_COMPLEX_VALUE_re_table_data[4] = 32'h485b52ff;
  assign i_COMPLEX_VALUE_re_table_data[5] = 32'h49e4d92f;
  assign i_COMPLEX_VALUE_re_table_data[6] = 32'h495ee3f0;
  assign i_COMPLEX_VALUE_re_table_data[7] = 32'h49a3c881;
  assign i_COMPLEX_VALUE_re_table_data[8] = 32'h49c11a85;
  assign i_COMPLEX_VALUE_re_table_data[9] = 32'h49b4c93f;
  assign i_COMPLEX_VALUE_re_table_data[10] = 32'h479001b4;
  assign rawData_i_COMPLEX_VALUE_re = i_COMPLEX_VALUE_re_table_data[Constant_out1_addr];



  // holdData reg for Cast_To_Single_out1
  always @(posedge I_CLK or negedge I_RST_N)
    begin : stimuli_Cast_To_Single_out1_2
      if (!I_RST_N) begin
        holdData_i_COMPLEX_VALUE_re <= 32'bx;
      end
      else begin
        holdData_i_COMPLEX_VALUE_re <= rawData_i_COMPLEX_VALUE_re;
      end
    end

  always @(rawData_i_COMPLEX_VALUE_re or rdEnb)
    begin : stimuli_Cast_To_Single_out1_3
      if (rdEnb == 1'b0) begin
        i_COMPLEX_VALUE_re_offset <= holdData_i_COMPLEX_VALUE_re;
      end
      else begin
        i_COMPLEX_VALUE_re_offset <= rawData_i_COMPLEX_VALUE_re;
      end
    end

  always #2 i_COMPLEX_VALUE_re_1 <= i_COMPLEX_VALUE_re_offset;

  assign i_COMPLEX_VALUE_re_2 = i_COMPLEX_VALUE_re_1;

  // holdData reg for Constant_out1
  always @(posedge I_CLK or negedge I_RST_N)
    begin : stimuli_Constant_out1
      if (!I_RST_N) begin
        holdData_i_WALID <= 1'bx;
      end
      else begin
        holdData_i_WALID <= rawData_i_WALID;
      end
    end

  always @(rawData_i_WALID or rdEnb)
    begin : stimuli_Constant_out1_1
      if (rdEnb == 1'b0) begin
        i_WALID_offset <= holdData_i_WALID;
      end
      else begin
        i_WALID_offset <= rawData_i_WALID;
      end
    end

  assign #2 i_WALID_1 = i_WALID_offset;

  assign snkDonen =  ~ snkDone;



  assign tb_enb = I_RST_N & snkDonen;



  // Delay inside enable generation: register depth 1
  always @(posedge I_CLK or negedge I_RST_N)
    begin : u_enable_delay
      if (!I_RST_N) begin
        tb_enb_delay <= 0;
      end
      else begin
        tb_enb_delay <= tb_enb;
      end
    end

  assign rdEnb = (snkDone == 1'b0 ? tb_enb_delay :
              1'b0);



  assign #2 I_CLK_EN = rdEnb;

  initial
    begin : I_RST_N_gen
      I_RST_N <= 1'b0;
      # (20);
      @ (posedge I_CLK)
      # (2);
      I_RST_N <= 1'b1;
    end

  always 
    begin : I_CLK_gen
      I_CLK <= 1'b1;
      # (5);
      I_CLK <= 1'b0;
      # (5);
      if (snkDone == 1'b1) begin
        I_CLK <= 1'b1;
        # (5);
        I_CLK <= 1'b0;
        # (5);
        $stop;
      end
    end

  CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT u_CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT (.I_CLK(I_CLK),
                                                                               .I_RST_N(I_RST_N),
                                                                               .I_CLK_EN(I_CLK_EN),
                                                                               .i_WALID(i_WALID_1),
                                                                               .i_COMPLEX_VALUE_re(i_COMPLEX_VALUE_re_2),  // single
                                                                               .i_COMPLEX_VALUE_im(i_COMPLEX_VALUE_im_2),  // single
                                                                               .ce_out(ce_out),
                                                                               .o_VALID(o_VALID),
                                                                               .o_MAGNITUDE(o_MAGNITUDE),  // single
                                                                               .o_PHASE(o_PHASE)  // single
                                                                               );

  assign o_VALID_enb = ce_out & o_VALID_active;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 10
  always @(posedge I_CLK or negedge I_RST_N)
    begin : c_2_process
      if (I_RST_N == 1'b0) begin
        o_VALID_addr <= 4'b0000;
      end
      else begin
        if (o_VALID_enb) begin
          if (o_VALID_addr >= 4'b1010) begin
            o_VALID_addr <= 4'b0000;
          end
          else begin
            o_VALID_addr <= o_VALID_addr + 4'b0001;
          end
        end
      end
    end



  assign o_VALID_lastAddr = o_VALID_addr >= 4'b1010;



  assign o_VALID_done = o_VALID_lastAddr & I_RST_N;



  // Delay to allow last sim cycle to complete
  always @(posedge I_CLK or negedge I_RST_N)
    begin : checkDone_1
      if (!I_RST_N) begin
        check1_done <= 0;
      end
      else begin
        if (o_VALID_done_enb) begin
          check1_done <= o_VALID_done;
        end
      end
    end

  assign snkDone = check3_done & (check1_done & check2_done);



  assign o_VALID_ignCntDone = o_VALID_chkcnt != 6'b101111;



  assign o_VALID_needToCount = ce_out & o_VALID_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_VALID_IgnoreDataChecking_process
      if (I_RST_N == 1'b0) begin
        o_VALID_chkcnt <= 6'b000000;
      end
      else begin
        if (o_VALID_needToCount) begin
          if (o_VALID_chkcnt >= 6'b101111) begin
            o_VALID_chkcnt <= 6'b000000;
          end
          else begin
            o_VALID_chkcnt <= o_VALID_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_VALID_chkenb = o_VALID_chkcnt == 6'b101111;



  assign o_VALID_chkdata = ce_out & o_VALID_chkenb;



  // Data source for o_VALID_expected
  assign o_VALID_expected_1 = 1'b0;



  assign o_VALID_ref = o_VALID_expected_1;

  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_VALID_checker
      if (I_RST_N == 1'b0) begin
        o_VALID_testFailure <= 1'b0;
      end
      else begin
        if (o_VALID_chkdata == 1'b1 && o_VALID !== o_VALID_ref) begin
          o_VALID_testFailure <= 1'b1;
          $display("ERROR in o_VALID at time %t : Expected '%h' Actual '%h'", $time, o_VALID_ref, o_VALID);
        end
      end
    end

  assign o_MAGNITUDE_ignCntDone = o_MAGNITUDE_chkcnt != 6'b101111;



  assign o_MAGNITUDE_needToCount = ce_out & o_MAGNITUDE_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_MAGNITUDE_IgnoreDataChecking_process
      if (I_RST_N == 1'b0) begin
        o_MAGNITUDE_chkcnt <= 6'b000000;
      end
      else begin
        if (o_MAGNITUDE_needToCount) begin
          if (o_MAGNITUDE_chkcnt >= 6'b101111) begin
            o_MAGNITUDE_chkcnt <= 6'b000000;
          end
          else begin
            o_MAGNITUDE_chkcnt <= o_MAGNITUDE_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_MAGNITUDE_chkenb = o_MAGNITUDE_chkcnt == 6'b101111;



  assign o_MAGNITUDE_chkdata = ce_out & o_MAGNITUDE_chkenb;



  // Data source for o_MAGNITUDE_expected
  assign o_MAGNITUDE_expected_1 = 32'h00000000;



  assign o_MAGNITUDE_ref = o_MAGNITUDE_expected_1;

  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_MAGNITUDE_checker
      if (I_RST_N == 1'b0) begin
        o_MAGNITUDE_testFailure <= 1'b0;
      end
      else begin
        if (o_MAGNITUDE_chkdata == 1'b1 && !isFloatSingleEpsEqual(o_MAGNITUDE, o_MAGNITUDE_ref, 9.9999999999999995e-08)) begin
          o_MAGNITUDE_testFailure <= 1'b1;
          $display("ERROR in o_MAGNITUDE at time %t : Expected '%h' Actual '%h'", $time, o_MAGNITUDE_ref, o_MAGNITUDE);
        end
      end
    end

  assign o_PHASE_ignCntDone = o_PHASE_chkcnt != 6'b101111;



  assign o_PHASE_needToCount = ce_out & o_PHASE_ignCntDone;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 47
  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_PHASE_IgnoreDataChecking_process
      if (I_RST_N == 1'b0) begin
        o_PHASE_chkcnt <= 6'b000000;
      end
      else begin
        if (o_PHASE_needToCount) begin
          if (o_PHASE_chkcnt >= 6'b101111) begin
            o_PHASE_chkcnt <= 6'b000000;
          end
          else begin
            o_PHASE_chkcnt <= o_PHASE_chkcnt + 6'b000001;
          end
        end
      end
    end



  assign o_PHASE_chkenb = o_PHASE_chkcnt == 6'b101111;



  assign o_PHASE_chkdata = ce_out & o_PHASE_chkenb;



  // Data source for o_PHASE_expected
  assign o_PHASE_expected_1 = 32'h00000000;



  assign o_PHASE_ref = o_PHASE_expected_1;

  always @(posedge I_CLK or negedge I_RST_N)
    begin : o_PHASE_checker
      if (I_RST_N == 1'b0) begin
        o_PHASE_testFailure <= 1'b0;
      end
      else begin
        if (o_PHASE_chkdata == 1'b1 && !isFloatSingleEpsEqual(o_PHASE, o_PHASE_ref, 9.9999999999999995e-08)) begin
          o_PHASE_testFailure <= 1'b1;
          $display("ERROR in o_PHASE at time %t : Expected '%h' Actual '%h'", $time, o_PHASE_ref, o_PHASE);
        end
      end
    end

  assign testFailure = o_PHASE_testFailure | (o_VALID_testFailure | o_MAGNITUDE_testFailure);



  always @(posedge I_CLK)
    begin : completed_msg
      if (snkDone == 1'b1) begin
        if (testFailure == 1'b0) begin
          $display("**************TEST COMPLETED (PASSED)**************");
        end
        else begin
          $display("**************TEST COMPLETED (FAILED)**************");
        end
      end
    end

endmodule  // CALC_MAGNITUDE_AND_PHASE_FLOAT_POINT_tb

