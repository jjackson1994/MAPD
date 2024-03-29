set_property -dict { PACKAGE_PIN D9 IOSTANDARD LVCM0S33 } [get_ports { a_in }]; #IO_L6N_TO_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN C9 IOSTANDARD LVCM0S33 } [get_ports { b_in }]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property -dict { PACKAGE_PIN B9 IOSTANDARD LVCM0S33 } [get_ports { c_in }]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property -dict { PACKAGE_PIN B8 IOSTANDARD LVCM0S33 } [get_ports { d_in }]; #IO_L12P_T1_MRCC_16 Sch=btn[3]
## switches 
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCM0S33 } [get_ports { sel_in[0] }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCM0S33 } [get_ports { sel_in[1] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
## RGB LEDs 
set_property -dict { PACKAGE_PIN E1 IOSTANDARD LVCM0S33 } [get_ports { y_out }]; #IO_L18N_T2_35 Sch=led0_b
 