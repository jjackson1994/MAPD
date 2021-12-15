----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 13:44:57
-- Design Name: 
-- Module Name: tb_cnt - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity tb_cnt is 
end tb_cnt;

architecture Behavioral of tb_cnt is

component cnt is
Port (clk  : in std_logic;
      rst  : in std_logic;
      sw_0 : in std_logic;
      sw_1 : in std_logic;
      y_out: out std_logic_vector (3 downto 0));
end component;

signal clk,rst : std_logic; signal sw_0,sw_1 : std_logic; signal y : std_logic_vector (3 downto 0);

begin

uut : cnt port map (clk=>clk, rst=>rst, sw_0=>sw_0, sw_1=>sw_1, y_out=>y);

p_clk : process--100 MHz
begin
clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns;
end process;

p_rst : process
begin
rst <= '1'; wait for 1 ns; rst <= '0'; wait for 1 ns;
end process;

p_cmb :process
begin
sw_0 <= '1'; wait for 1 ns; 
sw_1 <= '0'; wait for 1 ns; 
end process;

end Behavioral;
