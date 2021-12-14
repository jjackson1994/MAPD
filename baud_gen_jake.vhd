----------------------------------------------------------------------------------

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
variable count : integer;
variable max : integer;
begin
max:=868;
if rising_edge(clk) then
  count := count + 1;
end if;
  
if count > max then
  Q <= '1';
  wait for 10 ns; --- wait can only be used in simulation, we have a sysclock pin 
  Q<='0';
end if;
  
end baud_gen

end Behavioral;
