----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2021 10:49:40 AM
-- Design Name: 
-- Module Name: uart - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rocket is
  Port ( 
        --for testing
        --but0 : in std_logic := '1';
        led0 : out std_logic;
        --led1 : out std_logic;
        --
        
        i_RX_serial : in std_logic;
        -- linked together for testing so not needed
        --o_RX_output_byte : out std_logic_vector(9 downto 0);
        --data : in std_logic_vector(9 downto 0);--data to be transmitted to computer by transmitter
        --o_RX_data_valid : out std_logic;
        --valid_pul : in std_logic;
        tx : out std_logic;
        
        --isbusy : out std_logic; -- is 1 while transmitting, 0 otherwise        
        clk : in std_logic
        
        
  );
end uart_rocket;

architecture Behavioral of uart_rocket is

component UART_RX is
    port (
    --used for pyserial testing
--    led0 : out std_logic;
--    led1 : out std_logic;
--    but0 : in std_logic;
    --
    clk       : in  std_logic;
    i_RX_serial : in  std_logic; --data stream from computer 
    o_RX_data_valid     : out std_logic; -- 1 clk cycle lets us know o_RX_output_byte can be looked at
    o_RX_output_byte   : out std_logic_vector(7 downto 0)
    );
end component;

component transmitdaniel is
    Port(
         baudpulse : in std_logic;
         valid_pul : in std_logic;
         --isbusy : out std_logic;
         tx : out std_logic := '0';
         data : in std_logic_vector(7 downto 0));
end component;

component BaudGen is
    Port (
     clk : in std_logic;
     Q : out std_logic := '0'
          );
end component;

component blinky is 
    Port ( 
    clk : in std_logic;
    data : in std_logic_vector(7 downto 0);
    led0 : out std_logic;
    datavalid: in std_logic);
end component;

--declare the signal variables to be the internal wires
signal datavalid : std_logic;
signal baudpulse : std_logic;
signal RtoT : std_logic_vector(7 downto 0);
begin

rec : UART_RX port map(i_RX_serial => i_RX_serial, o_RX_output_byte => RtoT, o_RX_data_valid => datavalid, clk => clk); 
--but0 => but0, led0 => led0, led1 => led1);
bau : BaudGen port map(clk => clk, Q => baudpulse);
tra : transmitdaniel port map(tx => tx, data => RtoT, baudpulse => baudpulse, valid_pul => datavalid);
bli : blinky port map(clk => clk, data => RtoT, led0 => led0, datavalid => datavalid);

end Behavioral;
