-------------------------------------------------------------------------------
-- Title      : Testbench for design "baudrate_generator"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : baudrate_generator_tb.vhd
-- Author     : Antonio  <antonio@MacBook-Pro-di-Antonio-2.local>
-- Company    : 
-- Created    : 2020-12-09
-- Last update: 2020-12-09
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-09  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity baudrate_generator_tb is

end entity baudrate_generator_tb;

-------------------------------------------------------------------------------

architecture test of baudrate_generator_tb is

  -- component ports
  signal clock        : std_logic;
  signal baudrate_out : std_logic;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture test
  clock <= clk;
  -- component instantiation
  DUT : entity work.baudrate_generator
    port map (
      clock        => clock,
      baudrate_out => baudrate_out);

  -- clock generation
  Clk <= not Clk after 5 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here

    wait until Clk = '1';
  end process WaveGen_Proc;



end architecture test;

-------------------------------------------------------------------------------

configuration baudrate_generator_tb_test_cfg of baudrate_generator_tb is
  for test
  end for;
end baudrate_generator_tb_test_cfg;

-------------------------------------------------------------------------------
