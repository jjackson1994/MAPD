----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2021 05:14:51 PM
-- Design Name: 
-- Module Name: tb_BaudGen - Behavioral
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

entity tb_BaudGen is
--  Port ( );
end tb_BaudGen;

architecture Behavioral of tb_BaudGen is
component BaudGen is 
port( clk : in std_logic;
      Q : out std_logic);
end component;

signal clk_in : std_logic;
signal Q_out : std_logic;
begin

UUT: BaudGen port map(clk => clk_in, Q => Q_out); 

main : process
begin
clk_in <= '1'; wait for 5ns;
clk_in <= '0'; wait for 5ns;
end process main; 

end Behavioral;
