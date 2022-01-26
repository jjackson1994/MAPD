library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bubble_sort is
  generic (
    g_CLKS_PER_BIT : integer := 868; 
    DATA_SIZE : integer := 8; -- set to 100 when using pyserial 
    LED_FIN_WAIT : integer := 500000000     -- 5s
    );
     
    port (
      i_bs_DV     : in std_logic;
      i_Clk       : in  std_logic;
      i_bs_TX_Active  : in  std_logic;
      i_bs_Byte   : in  std_logic_vector(7 downto 0);
      o_bs_Byte   : out  std_logic_vector(7 downto 0);
      o_bs_DV     :  out std_logic;
      o_bs_LED0    : out  std_logic :='0'; --pass through
      o_bs_LED1    : out  std_logic :='0'; --build array 
      o_bs_LED2    : out  std_logic := '0'; -- bubble sort 
      o_bs_LED3    : out std_logic  :='0' ); -- array write
      -- ALL ON IF GETS THOUGH 5s

end bubble_sort;

architecture bs of bubble_sort is
      
      --Type declerations 
      type t_SM_Main is (s_pass_through, s_build_array, s_bubble_sort, s_print_array, s_done); --STATE MACHINE 
      type t_data_array is array (0 to DATA_SIZE) of  std_logic_vector(7 downto 0);

      --type usage 
      signal bs_SM_Main : t_SM_Main := s_pass_through;
      signal recived_data_array : t_data_array := (others => (others => '0'));  
      signal w_data_array : t_data_array := (others => (others => '0')); --tried with and without this
                   
      --Indexes 
      signal r_DV_Count : integer range 0 to DATA_SIZE:= 0;
      signal bs_index : integer range 0 to DATA_SIZE:= 0;
      signal sort_num : integer range 0 to DATA_SIZE:= 0; --just seeing if can loop all the way with no swaps then done
      signal print_index : integer range 0 to DATA_SIZE:= 0; 
      signal led_wait_index : integer range 0 to 500000000:= 0;
      signal print_wait_index : integer range 0 to 868:= 0;
      
      --bs swaping memory
      signal bs_mem : std_logic_vector(7 downto 0) := (others => '0');   
      signal byte_sent : integer range 0 to 1:= 0;  
begin

  p_bubble_sort : process (i_Clk)

  begin   
     if rising_edge(i_Clk) then
     
     case bs_SM_Main is
     
       when s_pass_through => -- works 
          if i_bs_Byte = std_logic_vector(to_unsigned(105, 8)) then --just using this as a start bit to know when to build array
            o_bs_LED0 <= '0';
            o_bs_DV <= '0';
            bs_SM_Main <= s_build_array;
            
          else
            o_bs_LED0 <= '1';
            
            o_bs_Byte <= i_bs_Byte;
            o_bs_DV <= i_bs_DV;
            
            bs_SM_Main <= s_pass_through;
          end if;
       
       when s_build_array => -- assigns but the array does revert back to its empty state late
         if r_DV_Count < DATA_SIZE-1 then -- we are using the  data valid pulse to know when to move to next byte
            if i_bs_DV = '1' then  -- got data 
               r_DV_Count <= r_DV_Count +1; --rising edge cant be used twice but this does work
            end if;
            recived_data_array(r_DV_Count) <=  i_bs_Byte;
            o_bs_LED1 <= '1';
         else 
            r_DV_Count <= 0;
            w_data_array <= recived_data_array;
            o_bs_LED1 <= '0';
     
            bs_SM_Main <= s_bubble_sort; --whist debugging arrays nice to set this to print array as its simplier.  Put bubble sort back in after 
            --bs_SM_Main <= s_bubble_sort;
         end if;
         
       when s_bubble_sort => --untested as arrays revert to 0,1,2 ect which is already sorted 
         if bs_index < DATA_SIZE then 
            o_bs_LED2 <= '1';  
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
             o_bs_LED2 <= '0';
             if sort_num = bs_index then  -- can only happen if no swaps occured as due to reset of sort_num 
                sort_num <= 0; --reset for next time
                bs_index <= 0;
                
                bs_SM_Main <= s_print_array;     
             else
                sort_num <= 0;
                bs_index <= 0;
                
                bs_SM_Main <= s_bubble_sort;
             end if;
         end if;

       when s_print_array => --tested and working 
             if print_index < DATA_SIZE then
                 o_bs_LED3 <= '1';
                 o_bs_DV <= '0';

                 if i_bs_TX_Active = '0' then -- dont send when trasmitter is busy
                    if byte_sent = 0 then --stops index increasing in the lag before the transmitter starts up 
                    o_bs_DV <= '1';
                    o_bs_Byte <=  w_data_array(print_index);
                    print_index <= print_index +1;
                    end if;
                    byte_sent <= 1;
                 else
                   byte_sent <= 0; --can only be switched off when trabsmitter has started
                 end if;
  
                 
                 
             else
                 o_bs_DV <= '0';
                 o_bs_LED3 <= '0';
                 print_index <= 0;
                 
                 bs_SM_Main <= s_done;
             end if;
       
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
 