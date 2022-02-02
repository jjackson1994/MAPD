library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bubble_sort is
  generic (
    MAX_DATA_SIZE : integer := 250; --max number of array elements sortable
    LED_FIN_WAIT : integer := 500000000     -- 5s
    );
     
    port (
      i_bs_DV     : in std_logic;--signal that i_bs_Byte is ready to read
      i_Clk       : in  std_logic;
      i_bs_TX_Active  : in  std_logic;--when 1 the transmitter is sending
      i_bs_Byte   : in  std_logic_vector(7 downto 0);--data coming from receiver
      o_bs_Byte   : out  std_logic_vector(7 downto 0);--data sent to transmitter
      o_bs_DV     :  out std_logic;--signal for transmitter that o_bs_Byte is updated for sending 
      --led indicators for in the case the fpga is stuck in a state
      o_bs_LED0    : out  std_logic :='0'; --pass through
      o_bs_LED1    : out  std_logic :='0'; --build array 
      o_bs_LED2    : out  std_logic := '0'; -- bubble sort 
      o_bs_LED3    : out std_logic  :='0'); -- array write
      -- ALL ON IF GETS THOUGH 5s

end bubble_sort;

architecture bs of bubble_sort is
      
      --Type declarations, state machine and data array type
      type t_SM_Main is (s_pass_through, s_build_array, s_bubble_sort, s_print_array, s_done, s_sizing, s_cycles_taken); --STATE MACHINE 
      type t_data_array is array (0 to MAX_DATA_SIZE) of  std_logic_vector(7 downto 0);

      --Type usage
      signal bs_SM_Main : t_SM_Main := s_pass_through;
      signal recived_data_array : t_data_array := (others => (others => '0'));  
      signal w_data_array : t_data_array := (others => (others => '0')); --tried with and without this                 
      
      --Indexes 
      signal r_DV_Count : integer range 0 to MAX_DATA_SIZE:= 0;
      signal bs_index : integer  range 0 to MAX_DATA_SIZE:= 0;
      signal sort_num : integer range 0 to MAX_DATA_SIZE:= 0; --just seeing if can loop all the way with no swaps then done
      signal print_index : integer range 0 to MAX_DATA_SIZE:= 0;
      signal led_wait_index : integer range 0 to 500000000:= 0;
      signal print_wait_index : integer range 0 to 868:= 0;
      
      --Used to measure performance
      signal cycles_taken : integer range 0 to MAX_DATA_SIZE**2 := 0;
      
      --bs swapping memory
      signal bs_mem : std_logic_vector(7 downto 0) := (others => '0'); 
      
      --Used to wait for a byte to finish sending before updating o_bs_byte
      --i_bs_Active is only high while sending but not while a byte is waiting to be sent
      --This leads to some bytes being skipped. byte_sent resolves the issue.
      signal byte_sent : integer range 0 to 1:= 0;  
      --The number of array elements expected to be received.
      signal DATA_SIZE : integer := 0;
begin

  p_bubble_sort : process (i_Clk)
  
  begin   
     if rising_edge(i_Clk) then
     
     
     
     case bs_SM_Main is
       --pass though will return what is sent to it.
       --Used as an idle state and a testing state
       when s_pass_through => 
        o_bs_LED0 <= '1';   
        if i_bs_DV = '1' then
          --105 is the key, i.e. the signal from the computer we are about to receive data.
          if i_bs_Byte = std_logic_vector(to_unsigned(105, 8)) then
            o_bs_DV <= '0';
            bs_SM_Main <= s_sizing;
          else 
            o_bs_Byte <= i_bs_Byte;
            o_bs_DV <= i_bs_DV;
            o_bs_LED0 <= '0';
            bs_SM_Main <= s_pass_through;
          end if;
        end if;
       
       --sizing is used to receive the number of elements expected in the incoming array.
       when s_sizing => 
          if i_bs_DV = '1' then
            DATA_SIZE <= to_integer(unsigned(i_bs_Byte));
            bs_SM_Main <= s_build_array;
          else DATA_SIZE <= DATA_SIZE; 
          end if;
       
       --This state takes each byte received by the transmitter and places it in an array.
       when s_build_array =>
       o_bs_LED1 <= '1';  
         if r_DV_Count < DATA_SIZE then -- we are using the  data valid pulse to know when to move to next byte
            if i_bs_DV = '1' then  -- got data 
               r_DV_Count <= r_DV_Count +1; --rising edge cant be used twice but this does work
               recived_data_array(r_DV_Count) <=  i_bs_Byte;  
            end if;
            
         else 
            r_DV_Count <= 0;
            w_data_array <= recived_data_array;
            o_bs_LED1 <= '0';
            bs_SM_Main <= s_bubble_sort;
         end if;
       
       --Implementation of the optimized bubble sort algorithm on the built array
       when s_bubble_sort =>
       o_bs_LED2 <= '1';
         cycles_taken <= cycles_taken + 1;
         if bs_index < DATA_SIZE then 
              
            if w_data_array(bs_index) >  w_data_array(bs_index+1) then --swap
               bs_mem <= w_data_array(bs_index);
               w_data_array(bs_index) <= w_data_array(bs_index+1);
               w_data_array(bs_index+1) <= bs_mem;
               sort_num <= 0; 
            else
               sort_num <= sort_num+1;
            end if;
            bs_index <= bs_index+1;
         else -- now at full data size
             
             if sort_num = bs_index then  -- can only happen if no swaps occured as due to reset of sort_num 
                sort_num <= 0; --reset for next time
                bs_index <= 0;
                
                bs_SM_Main <= s_print_array;     
             else
                sort_num <= 0;
                bs_index <= 0;
                o_bs_LED2 <= '0';
                bs_SM_Main <= s_bubble_sort;
             end if;
         end if;
       
       --print array will pass each byte of the sorted array to the transmitter
       when s_print_array => --tested and working 
       o_bs_LED3 <= '1';
             if print_index < DATA_SIZE then
                 
                 o_bs_DV <= '0';

                 if i_bs_TX_Active = '0' then -- dont send when transmitter is sending
                    -- byte_sent stops index increasing in the lag before the transmitter starts sending 
                    if byte_sent = 0 then
                        o_bs_DV <= '1';
                        o_bs_Byte <=  w_data_array(print_index);
                        print_index <= print_index +1;
                    end if;
                    byte_sent <= 1;
                 else
                   byte_sent <= 0; --can only be switched off when transmitter has started
                 end if;
    
             else
                 o_bs_DV <= '0';
                 print_index <= 0;
                 byte_sent <= 0;
                 o_bs_LED3 <= '0';
                 bs_SM_Main <= s_cycles_taken;
             end if;
       
       --cycles taken is used for performance monitoring.
       when s_cycles_taken => 
       --This state will repeatedly send the number to the number of clock cycles the bubble sort took to complete.
       --This method was the simplest way of overcoming the 255 number size restriction of an 8 bit integer.
          if cycles_taken > 0 then  
             if i_bs_TX_Active = '0' then -- dont send when trasmitter is busy
                    if byte_sent = 0 then --stops index increasing in the lag before the transmitter starts sending 
                            o_bs_DV <= '1';
                            o_bs_Byte <= "00000010";
                            cycles_taken <= cycles_taken - 1;
                        end if;
                    byte_sent <= 1;
                 else
                   byte_sent <= 0; --can only be switched off when transmitter has started
                 end if;
           else
                 o_bs_DV <= '0';
                 byte_sent <= 0;
                 bs_SM_Main <= s_done;
           end if;
       
       --done is a final light show to confirm the states have been fully traversed.   
       when s_done => 
          if led_wait_index < LED_FIN_WAIT then
            led_wait_index <= led_wait_index + 1;
            o_bs_LED0 <= '1';
            o_bs_LED1 <= '1';
            o_bs_LED2 <= '1';
            o_bs_LED3 <= '1';
          else
            o_bs_LED0 <= '0';
            o_bs_LED1 <= '0';
            o_bs_LED2 <= '0';
            o_bs_LED3 <= '0';
            led_wait_index <= 0;
            bs_SM_Main <= s_pass_through;
          end if;
          
       when others =>
          bs_SM_Main <= s_pass_through;
                
      end case;
      
    end if;
  end process p_bubble_sort;
 end bs;


 
