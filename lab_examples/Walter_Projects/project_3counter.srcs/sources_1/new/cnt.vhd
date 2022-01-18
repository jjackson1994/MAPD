----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 17:36:01
-- Design Name: 
-- Module Name: cnt - Behavioral
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

use IEEE.NUMERIC_STD.ALL;
entity cnt is
Port (clk  : in std_logic;
      rst  : in std_logic;
      sw_0 : in std_logic;
      sw_1 : in std_logic;
      y_out: out std_logic_vector (3 downto 0));
end cnt;
architecture rtl of cnt is
signal slow_clk, slow_clk_p : std_logic; signal counter : unsigned (27 downto 0);
signal slow_counter : unsigned (3 downto 0);
begin
p_cnt: process (clk, rst) is
begin
if rst = '1' then
counter <= (others => '0');
elsif rising_edge(clk) then
counter <= counter +1;
end if;
end process;
slow_clk <= counter(26);
p_slv_cnt: process (clk, rst, slow_clk, sw_0, sw_1) is
begin
if rst = '1' then
slow_counter <= (others => '0');
elsif rising_edge(clk) then
      slow_clk_p <= slow_clk;
      if slow_clk = '1' and slow_clk_p = '0' then
          if sw_0 = '0' then
          slow_counter <= slow_counter + 1;
          elsif sw_0 = '1' then
          slow_counter <= slow_counter + 1;
          end if; 
       end if; 
      if sw_1 = '1' then
      slow_counter <= slow_counter;
      
      
     end if;
end if;

end process;
y_out <= std_logic_vector(slow_counter);
end rtl;