----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2022 04:54:20 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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

--RUN SIMULATION FOR 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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


signal uart_txd_in_vec : std_logic_vector(7 downto 0);

begin
DUT : top port map(CLK100MHZ => CLK100MHZ, uart_txd_in => uart_txd_in, uart_rxd_out => uart_rxd_out);

main : process
    variable a : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(23, 8)) & '1';
    variable b : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(2, 8)) & '1';
    variable c : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(78, 8)) & '1';
    variable d : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(4, 8)) & '1';
    variable e : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(30, 8)) & '1';
    variable f : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(9, 8)) & '1';
    variable g : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(47, 8)) & '1';
    variable h : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(56, 8)) & '1';
    variable i : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(12, 8)) & '1';
    variable j : std_logic_vector(9 downto 0) := '0' & std_logic_vector(to_unsigned(69, 8)) & '1';
    variable data : a_std_v := (a,b,c,d,e,f,g,h,i,j);
begin--begin main
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
