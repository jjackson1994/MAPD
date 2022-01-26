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
         --isbusy : out std_logic;
         tx : out std_logic;
         data : in std_logic_vector(7 downto 0));--set for testing, ascii a
end transmitdaniel;
--Possible to declare intigers here
--Possible to declate state and signal variables here 
--type state is (S0, S1,S2);
--signal slow_clk :std_logic; --Signals represent wires between components
architecture transmitarc of transmitdaniel is
signal pad1 : std_logic_vector(0 downto 0) := "1";
signal pad0 : std_logic_vector(0 downto 0) := "0";
signal datapad : std_logic_vector(9 downto 0) := "0011000011"; --set to value for testing
--signal data2 : std_logic_vector(7 downto 0):= ;--for testing

begin
    transmit : process (baudpulse, valid_pul, data) is
    variable index : integer := 9;
    variable valid : boolean := false;
    variable count : integer := 0;  
    variable vcount : integer := 0;--for testing
    
    begin
        
        --when data is assigned and is ready to send, pad the data
--        if rising_edge(valid_pul) then
--            datapad <= pad0 & data & pad1;
--        end if;
        
        --if not transmitting then set ilde to 1
        if valid = false then
            tx <= '1';
        end if;
        
        --set valid = true every second for testing
        if rising_edge(baudpulse) then
            vcount := vcount + 1;
        end if;
        --115200
        if vcount > 115200 then
            valid := true;
            vcount := 0;
        end if;
        
        -- valid is true if a valid pulse was detected.
        if rising_edge(baudpulse) and valid = true then
            tx <= datapad(index);
            index := index - 1;
            count := count + 1;   
            report "Index is: " & integer'image(index); 
        end if;
        
        --needed because data(-1) causes an error.
        if index = -1 then
            index := 0;
        end if;
        
        --dectection of valid pulse
--        if rising_edge(valid_pul) then 
--            valid := true;
--        end if;
        
        --all data is sent, lets reset things ready for the next valid pulse
        --count is used rather than index because I had issues with the index 
        --needing to go into data(index)
        if count = 11 then
            valid := false;
            index := 9;
            count := 0;
            report "The value of valis is: " & boolean'image(valid);
        end if;
        
--        if index < 9 and index >= -1 then 
--            isbusy <= '1';
--        else isbusy <= '0';
--        end if;
        
    end process transmit;

end transmitarc;
