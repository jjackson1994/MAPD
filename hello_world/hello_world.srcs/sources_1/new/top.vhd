----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2021 13:12:15
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
entity top is 
  port (btn_in : in std_logic; led_out : out std_logic);
end top;
architecture Behavioral of top is 
begin 
--led_out <= btn_in; --signal assignment standard
--- ******************* Alternate to button press experiment **********************
-- Only the input is declared in the process as output must be getrated from input with logic 
main: process(btn_in) is
begin
if btn_in ='1' then
    led_out <='0';
else 
    led_out <= '1';
end if; 

end process main;
--- ******************************************************************************* 

end Behavioral;
