----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2021 04:02:45 PM
-- Design Name: 
-- Module Name: tb_transmitdaniel - Behavioral
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

entity tb_transmitdaniel is
--  Port ( );
end tb_transmitdaniel;



architecture Behavioral of tb_transmitdaniel is
component transmitdaniel is 
port(
         baudpulse : in std_logic;
         valid_pul : in std_logic;
         isbusy : out std_logic;
         tx : out std_logic;
         data : in std_logic_vector(9 downto 0));
end component;

signal baudpulse_in, valid_in : std_logic; 
signal isbusy_out : std_logic;
signal tx_out: std_logic;
signal data_in: std_logic_vector(9 downto 0);

begin

UUT: transmitdaniel port map (baudpulse => baudpulse_in, 
valid_pul => valid_in, isbusy => isbusy_out, tx => tx_out,
data => data_in);

baudprocess : process
begin
    baudpulse_in <= '0'; 
    wait for 8685 ns;
    baudpulse_in <= '1'; 
    wait for 5 ns;
end process baudprocess;

validprocess : process
begin
    data_in <= "1011111010";
    valid_in <= '0'; wait for 1000 ns;
    valid_in <='1'; wait for 10 ns;
    valid_in <= '0'; wait for 120us;
    
    data_in <= "1001001010";
    valid_in <= '0'; wait for 1000 ns;
    valid_in <='1'; wait for 10 ns;
    valid_in <= '0';
    
    
    wait;
end process validprocess;

end Behavioral;
