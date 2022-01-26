----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2021 11:42:41 AM
-- Design Name: 
-- Module Name: tb_uart - Behavioral
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

entity tb_uart is
--  Port ( );
end tb_uart;

architecture Behavioral of tb_uart is
component uart_rocket is 
port(  
        led0 : out std_logic;
        i_RX_serial : in std_logic;
        -- linked together for testing so not needed
        --o_RX_output_byte : out std_logic_vector(9 downto 0);
        --data : in std_logic_vector(9 downto 0);--data to be transmitted to computer by transmitter
        tx : out std_logic;
        
        --isbusy : out std_logic; -- is 1 while transmitting, 0 otherwise        
        clk : in std_logic);
end component;

signal i_RX_serial : std_logic;
signal tx : std_logic;
signal clk: std_logic;

signal a : std_logic_vector(9 downto 0):= "1100001100";  --"0011000011";
signal b : std_logic_vector(9 downto 0):= "1010001100";  --"0011000101";

signal led0: std_logic;

begin

UUT: uart_rocket port map(i_RX_serial => i_RX_serial, tx => tx, clk => clk, led0 => led0); 



clock : process
begin
clk <= '1'; wait for 5ns;
clk <= '0'; wait for 5ns;
end process clock; 

send : process
begin
i_RX_serial <= '1'; wait for 11000 ns; --idle
for i in 0 to 9 loop
i_RX_serial <= a(i); wait for 8680 ns;
end loop;
i_RX_serial <= '1'; wait for 110000 ns; --idle
for i in 0 to 9 loop
i_RX_serial <= b(i); wait for 8680 ns;
end loop;
i_RX_serial <= '1'; wait for 11000 ns; --idle
wait;
end process;

--serialIn : process
--begin

--wait for 10 ns;

--i_RX_serial <= '1'; wait for 5000 ns; --idle

--i_RX_serial <= '0'; wait for 8680 ns;-- start bit

--i_RX_serial <= '1'; wait for 8680 ns;-- signal

--i_RX_serial <= '0'; wait for 8680 ns;

--i_RX_serial <= '1'; wait for 8680 ns;

--i_RX_serial <= '1'; wait for 8680 ns;

--i_RX_serial <= '0'; wait for 8680 ns;

--i_RX_serial <= '0'; wait for 8680 ns;

--i_RX_serial <= '1'; wait for 8680 ns;

--i_RX_serial <= '0'; wait for 8680 ns;

--i_RX_serial <= '1'; wait for 8680 ns;--end bit

--i_RX_serial <= '1'; wait for 5000 ns; --idle



--wait;

--end process serialIn;

end Behavioral;
