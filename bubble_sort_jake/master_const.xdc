## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

## USB-UART Interface
set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out  }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in  }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

#failed i_RX_Serial     o_TX_Serial
#

#entity UART_RX is
#  generic (
#    g_CLKS_PER_BIT : integer := 868     -- Needs to be set correctly
#    );
#  port (
#    i_Clk       : in  std_logic;
#    i_RX_Serial : in  std_logic;
#    o_RX_DV     : out std_logic;
#    o_RX_Byte   : out std_logic_vector(7 downto 0)
#    );
#end UART_RX;

#o_TX_Done