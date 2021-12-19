library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity transmitdaniel is 
    Port(
         --Possible to declare integers here -to be used in vector declaration
         --generic(N: integer := 4);
         -- vecexample : in std_logic_vector(N downto 0);
         baudpulse : in std_logic;
         valid_pul : in std_logic;
         isbusy : out std_logic;
         tx : out std_logic := '0';
         data : in std_logic_vector(9 downto 0));
end transmitdaniel;
--Possible to declare intigers here
--Possible to declate state and signal variables here 
--type state is (S0, S1,S2);
--signal slow_clk :std_logic; --Signals represent wires between components
architecture transmitarc of transmitdaniel is
begin
    transmit : process (baudpulse, valid_pul, data) is
    variable index : integer := 9;
    variable valid : boolean := false;
    variable count : integer := 0;
    begin
        -- valid is true if a valid pulse was detected.
        if rising_edge(baudpulse) and valid = true then
            tx <= data(index);
            index := index - 1;
            count := count + 1;   
            report "Index is: " & integer'image(index); 
        end if;
        
        --needed because data(-1) causes an error.
        if index = -1 then
            index := 0;
        end if;
        
        --dectection of valid pulse
        if rising_edge(valid_pul) then 
            valid := true;
        end if;
        
        --all data is sent, lets reset things ready for the next valid pulse
        --count is used rather than index because I had issues with the index 
        --needing to go into data(index)
        if count = 11 then
            valid := false;
            tx <= '0';
            index := 9;
            count := 0;
            report "The value of valis is: " & boolean'image(valid);
        end if;
        
        if index < 9 and index >= -1 then 
            isbusy <= '1';
        else isbusy <= '0';
        end if;
        
    end process transmit;

end transmitarc;