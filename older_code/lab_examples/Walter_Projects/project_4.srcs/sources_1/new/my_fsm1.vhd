----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 17:23:04
-- Design Name: 
-- Module Name: my_fsm1 - Behavioral
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

library IEEE;
use IEEE.std_logic_1164.all; -- entity
entity my_fsm1 is
port (TOG_EN, CLK, CLR : in std_logic;
Z1 : out std_logic);
end my_fsm1;
architecture fsm2 of my_fsm1 is
type state_type is (ST0, ST1);
signal state : state_type;
begin
sync_proc : process(CLK)
begin
if (rising_edge(CLK)) then
if (CLR = '1') then
state <= ST0;
Z1 <= '0'; -- pre-assign
else
case state is
when ST0 => -- items regarding state ST0 Z1 <= '0'; -- Moore output
Z1 <= '0'; -- pre-assign
if (TOG_EN = '1') then state <= ST1;
end if;
when ST1 => -- items regarding state ST1
Z1 <= '1'; -- Moore output
if (TOG_EN = '1') then state <= ST0;
end if;
when others => -- the catch-all condition
Z1 <= '0'; -- arbitrary; it should never
state <= ST0; -- make it to these two statements
end case;
end if;
end if;
end process sync_proc;
end fsm2;