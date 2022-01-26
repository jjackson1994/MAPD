--Clock frequency= 100 Mhz
-- Baudrate = 115200
--100000000/115200 = 868 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_RX is
  generic ( --just  a constant
    CLK_CYCLE_PER_BIT : integer := 868
    );
  port (
    clk       : in  std_logic;
    i_RX_serial : in  std_logic; --data stream from computer 
    o_RX_data_valid     : out std_logic; -- 1 clk cycle lets us know o_RX_output_byte can be looked at
    o_RX_output_byte   : out std_logic_vector(7 downto 0)
    );
end UART_RX;

architecture rtl of UART_RX is
--create state machine varible 
  type t_SM_Main is (s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
                     s_RX_Stop_Bit, s_Cleanup);

--using signal not varible  as inside process
  signal r_SM_Main : t_SM_Main := s_Idle; --state machine starts set to idle
  signal sim_SM_Main : std_logic_vector(2 downto 0); -- for simulation only
  signal clk_counter : integer range 0 to CLK_CYCLE_PER_BIT-1 := 0;
  signal r_Bit_Index : integer range 0 to 7 := 0;  -- 8 Bits Total
  signal r_RX_Byte   : std_logic_vector(7 downto 0) := (others => '0'); --stores bits in vector elements to make byte
  signal r_RX_DV     : std_logic := '0'; -- data valid tracker
  
begin
  -- Purpose: Control RX state machine
  p_UART_RX : process (clk) --sequential process that controls the state machine
  begin
    if rising_edge(clk) then
      case r_SM_Main is
        when s_Idle => ------------------------------------------------------------------------------IDLE BIT STATE
          r_RX_DV     <= '0';
          clk_counter <= 0;
          r_Bit_Index <= 0;

          if i_RX_serial = '0' then       --Start bit detected, idle is high as long as we set both accordingly don't really matter 
            r_SM_Main <= s_RX_Start_Bit;  --enter next state of machine ie start bit state
          else
            r_SM_Main <= s_Idle;
          end if;

        -- Check middle of start bit to make sure it's still low,
        -- reading middle of bits for accuracy as less likley for delay to put you in next bit,  we can change this if need be 
        
        when s_RX_Start_Bit => ------------------------------------------------------------------------------START BIT STATE
          if clk_counter = (CLK_CYCLE_PER_BIT-1)/2 then
            if i_RX_serial = '0' then -- already done this but double checking
              clk_counter <= 0;  -- reset counter since were in middle now,  our full count moves to center of next bit ect
              r_SM_Main   <= s_RX_Data_Bits; --next state 
            else
              r_SM_Main   <= s_Idle; --return to idle false positive detected
            end if;
          else
            clk_counter <= clk_counter + 1; -- loops back, this stops when middle is found
            r_SM_Main   <= s_RX_Start_Bit;
          end if;
          
          report("arived here");


        when s_RX_Data_Bits => ------------------------------------------------------------------------------DATA RECIVING STATE
        -- Wait CLK_CYCLE_PER_BIT-1 clock cycles to move from one bit to next
            if clk_counter < CLK_CYCLE_PER_BIT-1 then
            clk_counter <= clk_counter + 1;
            r_SM_Main   <= s_RX_Data_Bits;
          else
            clk_counter            <= 0;
            r_RX_Byte(r_Bit_Index) <= i_RX_serial;
            
            -- Check if we have sent out all bits
            if r_Bit_Index < 7 then
              r_Bit_Index <= r_Bit_Index + 1; -- every bit index 
              r_SM_Main   <= s_RX_Data_Bits;
            else
              r_Bit_Index <= 0;
              r_SM_Main   <= s_RX_Stop_Bit;
            end if;
          end if;


        -- Receive Stop bit.  Stop bit = 1
        when s_RX_Stop_Bit => ------------------------------------------------------------------------------STOP BIT STATE
          -- Wait CLK_CYCLE_PER_BIT-1 clock cycles for Stop bit to finish
          if clk_counter < CLK_CYCLE_PER_BIT-1 then
            clk_counter <= clk_counter + 1;
            r_SM_Main   <= s_RX_Stop_Bit;
          else
            r_RX_DV     <= '1';  -- fully received byte so data valid here
            clk_counter <= 0;
            r_SM_Main   <= s_Cleanup;
          end if;

                 
        -- Stay here 1 clock
        when s_Cleanup => ------------------------------------------------------------------------------  CLEAN UP (RETURN TO IDLE) STATE
          r_SM_Main <= s_Idle;
          r_RX_DV   <= '0';
            
        when others =>
          r_SM_Main <= s_Idle;

      end case;
    end if;
  end process p_UART_RX;



  o_RX_data_valid   <= r_RX_DV;
  o_RX_output_byte <= r_RX_Byte;
  
  -- Create a signal for simulation purposes (allows waveform display)
  sim_SM_Main <= "000" when r_SM_Main = s_Idle else
               "001" when r_SM_Main = s_RX_Start_Bit else
               "010" when r_SM_Main = s_RX_Data_Bits else
               "011" when r_SM_Main = s_RX_Stop_Bit else
               "100" when r_SM_Main = s_Cleanup else
               "101"; -- should never get here
end rtl;
