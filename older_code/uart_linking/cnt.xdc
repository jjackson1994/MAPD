# Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVCMOS33} [get_ports uart_txd_in];
#set_property PULLUP true [get_ports tx]

set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports uart_rxd_out];




#used for pyserial testing
#set_property PACKAGE_PIN H5 [get_ports { led1 }];
#set_property IOSTANDARD LVCMOS33 [get_ports { led1 }];

#set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports { led0 }];

#set_property PACKAGE_PIN D9 [get_ports { but0 }];
#set_property IOSTANDARD LVCMOS33 [get_ports { but0 }];




#nothing in the design set to ck_rst. What is this for
#set_property -dict {PACKAGE_PIN D9   IOSTANDARD LVCMOS33} [get_ports { ck_rst }];

#set_property PACKAGE_PIN E1 [get_ports { y_out[0] }];
#set_property IOSTANDARD LVCMOS33 [get_ports { y_out[0] }];
#set_property PACKAGE_PIN G4 [get_ports { y_out[1] }];
#set_property IOSTANDARD LVCMOS33 [get_ports { y_out[1] }];
#set_property PACKAGE_PIN H4 [get_ports { y_out[2] }];
#set_property IOSTANDARD LVCMOS33 [get_ports { y_out[2] }];
#set_property PACKAGE_PIN K2 [get_ports { y_out[3] }];
#set_property IOSTANDARD LVCMOS33 [get_ports { y_out[3] }];



#set_property PULLUP true [get_ports i_RX_serial]
#set_property PACKAGE_PIN A9 [get_ports tx]
#set_property IOSTANDARD LVCMOS33 [get_ports tx]

#switch ports
#set_property PACKAGE_PIN A9 [get_ports i_RX_serial]
#set_property IOSTANDARD LVCMOS33 [get_ports i_RX_serial]
##set_property PULLUP true [get_ports tx]

#set_property PACKAGE_PIN D10 [get_ports tx]
#set_property IOSTANDARD LVCMOS33 [get_ports tx]