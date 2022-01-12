library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity sampler_generator_tb is

end entity sampler_generator_tb;

-------------------------------------------------------------------------------

architecture test of sampler_generator_tb is

  -- component ports
  signal clock     : std_logic := '0';
  signal uart_rx   : std_logic;
  signal baudrate_out : std_logic;

begin
  -- component instantiation
  DUT : entity work.sampler_generator
    port map (
      clock     => clock,
      uart_rx       => uart_rx,
      baudrate_out => baudrate_out);

  -- clock generation
  clock <= not clock after 5 ns;

  -- waveform generation
  WaveGen_Proc : process
  begin
    uart_rx <= '1';
    wait for 1 us;
    uart_rx <= '0';
    wait for 10 us;
    uart_rx <= '1';
    wait;
  end process WaveGen_Proc;



end architecture test;

