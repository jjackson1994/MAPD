library ieee;
use ieee.std_logic_1164.all;

entity top is

  port (
    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic;
    led0          : out std_logic;
    led1       : out std_logic;
    led2       : out std_logic;
    led3       : out std_logic);

end entity top;

architecture str of top is
  signal i_Clk        : std_logic;
  signal i_TX_Byte    : std_logic_vector(7 downto 0);
  signal i_bs_Byte    : std_logic_vector(7 downto 0);
  signal i_bs_TX_Active : std_logic;
  --signal i_TX_Byte    : std_logic_vector(7 downto 0) := X"61";
  signal i_TX_DV      : std_logic;
  signal o_TX_Active  : std_logic;
  signal o_TX_Serial  : std_logic;
  signal o_TX_Done    : std_logic;
  signal i_bs_DV      : std_logic;
  signal o_bs_DV      : std_logic;
  signal o_bs_LED0    : std_logic;
  signal o_bs_LED1    : std_logic;
  signal o_bs_LED2    : std_logic;
  signal o_bs_LED3    : std_logic;
  component UART_TX is
    port (
      i_Clk        : in  std_logic;
      i_TX_Byte : in  std_logic_vector(7 downto 0);
      i_TX_DV   : in  std_logic;
      o_TX_Active         : out std_logic;
      o_TX_Serial      : out std_logic;
      o_TX_Done   : out std_logic);
  end component UART_TX;

  component bubble_sort is
    port (
      i_bs_DV     : in std_logic;
      i_Clk       : in  std_logic;
      i_bs_TX_Active  : in  std_logic;
      i_bs_Byte   : in  std_logic_vector(7 downto 0);
      o_bs_Byte   : out  std_logic_vector(7 downto 0);
      o_bs_DV     :  out std_logic;
      o_bs_LED0    : out  std_logic;
      o_bs_LED1    : out  std_logic;
      o_bs_LED2    : out  std_logic;
      o_bs_LED3    : out std_logic);
      
  end component bubble_sort;

  component UART_RX is
    port (
      i_Clk         : in  std_logic;
      i_RX_Serial       : in  std_logic;
      o_RX_DV         : out std_logic;
      o_RX_Byte : out std_logic_vector(7 downto 0));
  end component UART_RX;

begin  -- architecture str

   UART_RX_1 : UART_RX
    port map (
      i_Clk         => CLK100MHZ,
      i_RX_Serial       => uart_txd_in,
      o_RX_DV         => i_bs_DV,
      o_RX_Byte => i_bs_Byte); -- this is where wee are setting loop
 
 
  bubble_sort_1 : bubble_sort
    port map (
      i_bs_DV   => i_bs_DV,
      i_bs_TX_Active => i_bs_TX_Active,
      i_Clk         => CLK100MHZ,
      i_bs_Byte         => i_bs_Byte,
      o_bs_DV  => i_TX_DV,
      o_bs_Byte       => i_TX_Byte,
      o_bs_LED0 => led0,
      o_bs_LED1 => led1,
      o_bs_LED2 => led2,
      o_bs_LED3 => led3
      ); -- this is where wee are setting loop back
 
  UART_TX_1 : UART_TX
    port map (
      i_Clk        => CLK100MHZ,
      i_TX_Byte => i_TX_Byte,
      i_TX_DV   => i_TX_DV,
      o_TX_Done => o_TX_Done,
      o_TX_Active  => i_bs_TX_Active,
      o_TX_Serial      => uart_rxd_out
      );

end architecture str;