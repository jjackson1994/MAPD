set_property -dict {PACKAGE_PIN E3   I0STANDARD LVCM0S33} [get-ports { clk }];
create_clock -period -name  sys_clk_pin -period 10.00 -waveform {0.000 4.000} [get_ports{clk}];
set_property PACKAGE_PIN D9 [get_ports { rst }];
set_property IOSTANDARD LVCMOS33 [get_ports { rst }];
set_property PACKAGE_PIN E1 [get_ports { y_out[0] }];
set_property IOSTANDARD LVCMOS33 [get_ports { y_out[0] }];
set_property PACKAGE_PIN G4 [get_ports { y_out[1] }];
set_property IOSTANDARD LVCMOS33 [get_ports { y_out[1] }];
set_property PACKAGE_PIN H4 [get_ports { y_out[2] }];
set_property IOSTANDARD LVCMOS33 [get_ports { y_out[2] }];
set_property PACKAGE_PIN K2 [get_ports { y_out[3] }];
set_property IOSTANDARD LVCMOS33 [get_ports { y_out[3] }];


set_property PACKAGE_PIN D10 [get_ports o_RX_output_byte]
set_property IOSTANDARD LVCMOS33 [get_ports o_RX_output_byte]
set_property PULLUP true [get_ports o_RX_output_byte]

set_property PACKAGE_PIN A9 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]