onbreak resume
onerror resume
vsim -voptargs=+acc work.CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb

add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/I_CLK
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/I_RST_N
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/I_CLK_EN
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/i_WALID
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/i_COMPLEX_VALUE_re
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/i_COMPLEX_VALUE_im
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/ce_out
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/o_VALID
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/o_VALID_ref
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/o_MAGNITUDE
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/o_MAGNITUDE_ref
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/u_CALC_MAGNITUDE_AND_PHASE_FIXED_POINT/o_PHASE
add wave sim:/CALC_MAGNITUDE_AND_PHASE_FIXED_POINT_tb/o_PHASE_ref
run -all
