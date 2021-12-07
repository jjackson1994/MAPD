----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2021 16:57:21
-- Design Name: 
-- Module Name: baud_gen - Behavioral
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


entity baud_gen is
  Port (
        clk : in std_logic;
          Q : out std_logic
          );
end baud_gen;

architecture Behavioral of baud_gen is

begin

baud_gen: process(clk) is  
variable count: integer

begin
if rising_edge(clk) then
  count <= count + 1;
end if;
  
if count > 868 then
  Q <= 1; wait 10ns; Q<=0;
end if;

count <= 0;
  
end baud_gen

end Behavioral;
