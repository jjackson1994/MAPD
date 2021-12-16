library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity transmitentity is 
    Port(
         --Possible to declare integers here -to be used in vector declaration
         --generic(N: integer := 4);
         -- vecexample : in std_logic_vector(N downto 0);
         baudpulse : in std_logic;
         isvalid : in std_logic;
         isbusy : out std_logic;
         tx : out std_logic := '0');
         --data : in std_logic_vector(9 downto 0));
end transmitentity;
--Possible to declare intigers here
--Possible to declate state and signal variables here 
--type state is (S0, S1,S2);
--signal slow_clk :std_logic; --Signals represent wires between components
architecture transmitarc of transmitentity is
begin
    transmitprocess : process (baudpulse, isvalid) is
    variable index : integer ;
    begin
    if rising_edge(baudpulse) then
        tx <= '1';
        isbusy <= '1';    
    else 
        tx <= '0';
        isbusy <= '0';
    end if;
end process transmitprocess;

end transmitarc;