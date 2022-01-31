--RUN SIMULATION FOR 1200us
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
type a_std_v is array (0 to 9) of std_logic_vector(9 downto 0);

component top
port (
    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic
    );
end component top;

signal CLK100MHZ : std_logic;
signal uart_txd_in :  std_logic;
signal uart_rxd_out :  std_logic;
signal value_bin : std_logic_vector(7 downto 0);
signal uart_txd_in_vec : std_logic_vector(7 downto 0);

begin
DUT : top port map(CLK100MHZ => CLK100MHZ, uart_txd_in => uart_txd_in, uart_rxd_out => uart_rxd_out);

main : process --set data size in the top in 8 when runing the sim 
    variable a : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(105, 8)) & '0';
    variable b : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(8, 8)) & '0';
    variable c : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(78, 8)) & '0';
    variable d : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(4, 8)) & '0';
    variable e : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(30, 8)) & '0';
    variable f : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(9, 8)) & '0';
    variable g : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(47, 8)) & '0';
    variable h : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(56, 8)) & '0';
    variable i : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(12, 8)) & '0';
    variable j : std_logic_vector(9 downto 0) := '1' & std_logic_vector(to_unsigned(69, 8)) & '0';
    variable data : a_std_v := (a,b,c,d,e,f,g,h,i,j);

begin--begin main

    --value_bin <= std_logic_vector(to_unsigned(105, 8));
    for i in 0 to 9 loop
        uart_txd_in <= '1'; wait for 8680 ns; --idle
        for j in 0 to 9 loop
            uart_txd_in <= data(i)(j); 
            uart_txd_in_vec <= data(i)(1) & data(i)(2) & data(i)(3) & data(i)(4) & data(i)(5) & data(i)(6) & data(i)(7) & data(i)(8);
            wait for 8680 ns;
            report(std_logic'Image(uart_txd_in));
        end loop;
        uart_txd_in <= '1'; wait for 8680 ns; --idle
    end loop;   
    
    wait for 2.5ms; 
    --value_bin <= std_logic_vector(to_unsigned(105, 8));
    for i in 0 to 9 loop
        uart_txd_in <= '1'; wait for 8680 ns; --idle
        for j in 0 to 9 loop
            uart_txd_in <= data(i)(j); 
            uart_txd_in_vec <= data(i)(1) & data(i)(2) & data(i)(3) & data(i)(4) & data(i)(5) & data(i)(6) & data(i)(7) & data(i)(8);
            wait for 8680 ns;
            report(std_logic'Image(uart_txd_in));
        end loop;
        uart_txd_in <= '1'; wait for 8680 ns; --idle        
    end loop;
    
    wait;
end process main;

clk : process
    begin
    CLK100MHZ <= '1'; wait for 5 ns;
    CLK100MHZ <= '0'; wait for 5 ns;
end process clk;

end Behavioral;
