
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BaudGen is
  Port (
        clk : in std_logic;
          Q : out std_logic := '0'
          );
end BaudGen;

architecture Behavioral of BaudGen is

begin

BaudGen: process(clk) is  
variable count : integer := 0;
variable max : integer := 868;
begin

if rising_edge(clk) then
  count := count + 1;
end if;
  
if count >= max then
  Q <= '1';
end if;

if (falling_edge(clk) and count >= max) then
  Q <= '0';
  count := 0;
end if;

end process BaudGen;

end Behavioral;


