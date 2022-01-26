library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bubble_sort is
  generic (
    g_CLKS_PER_BIT : integer := 868     -- Needs to be set correctly
    );
    
    
    port (
      i_bs_DV     : in std_logic;
      i_Clk       : in  std_logic;
      i_bs_TX_Active  : in  std_logic;
      i_bs_Byte   : in  std_logic_vector(7 downto 0);
      o_bs_Byte   : out  std_logic_vector(7 downto 0);
      o_bs_DV     : out std_logic);

end bubble_sort;

architecture bs of bubble_sort is

      type t_SM_Main is (s_pass_through, s_build_array, s_bubble_sort, s_print_array); --STATE MACHINE 
      type t_data_array is array (0 to 99) of  std_logic_vector(7 downto 0);
      signal bs_SM_Main : t_SM_Main := s_pass_through;
      signal r_bs_Data   : std_logic_vector(7 downto 0) := (others => '0');
      signal o_bs_Data   : std_logic_vector(7 downto 0) := (others => '0');
      signal DATA_SIZE : integer := 100;
      signal r_i_bs_DV   : std_logic := '0';
      signal r_DV_Count : integer range 0 to 99:= 0;
      signal print_index : integer range 0 to 99:= 0;  
      signal recived_data_array : t_data_array;  
      signal w_data_array : t_data_array; --tried with and without this 
      signal bs_index : integer range 0 to 99:= 0;
      signal sort_num : integer range 0 to 99:= 0; --just seeing if can loop all the way with no swaps then done
      signal bs_mem : std_logic_vector(7 downto 0) := (others => '0');     
 
begin

  p_bubble_sort : process (i_Clk)

  begin   
     if rising_edge(i_Clk) then
     
     case bs_SM_Main is
     
       when s_pass_through => -- works 
          if to_integer(unsigned(i_bs_Byte)) = 105 then --just using this as a start bit to know when to build array
            bs_SM_Main <= s_build_array;
            o_bs_Byte <= std_logic_vector(to_unsigned(119, 8));
          else
            o_bs_Byte <= i_bs_Byte;
            bs_SM_Main <= s_pass_through;
          end if;
       
       when s_build_array => -- assigns but the array does revert back to its empty state late
         if r_DV_Count < DATA_SIZE then -- we are using the  data valid pulse to know when to move to next byte
            if i_bs_DV = '1' then  -- got data 
               r_DV_Count <= r_DV_Count +1; --rising edge cant be used twice but this does work
            end if;
            recived_data_array(r_DV_Count) <=  i_bs_Byte;
            --o_bs_Byte <= recived_data_array(r_DV_Count); -- verified assignment as printed from array with index 
            o_bs_Byte <= std_logic_vector(to_unsigned(120, 8));
         else 
            r_DV_Count <= 0;
            w_data_array <= recived_data_array; 
            o_bs_Byte <= std_logic_vector(to_unsigned(121, 8));
            bs_SM_Main <= s_print_array; --whist debugging arrays nice to set this to print array as its simplier.  Put bubble sort back in after 
            --bs_SM_Main <= s_bubble_sort;
         end if;
         
       when s_bubble_sort => --untested as arrays revert to 0,1,2 ect which is already sorted 
         if bs_index < DATA_SIZE then 
            if to_integer(unsigned(w_data_array(bs_index))) >  to_integer(unsigned(w_data_array(bs_index+1))) then --swap
               bs_mem <= w_data_array(bs_index);
               w_data_array(bs_index) <= w_data_array(bs_index+1);
               w_data_array(bs_index+1) <= bs_mem;
               sort_num <= 0; 
            end if;        
            sort_num <= sort_num+1;
            bs_index <= bs_index+1;
         else -- now at full data size
             if sort_num = bs_index then  -- can only happen if no swaps occured as due to reset of sort_num 
                sort_num <= 0; 
                bs_index <= 0;
                bs_SM_Main <= s_print_array;     
             else
                bs_index <= 0;
             end if;          
         end if;

       when s_print_array => --tested and working 
         if i_bs_TX_Active = '0' then -- dont send when trasmitter is busy
             if print_index < DATA_SIZE then
               o_bs_Byte <=  w_data_array(print_index);
               print_index <= print_index +1;
             else
               print_index <= 0;
               bs_SM_Main <= s_pass_through;
               o_bs_Byte <= std_logic_vector(to_unsigned(122, 8));
             end if;
         end if; 
      end case;
      
      o_bs_DV <= i_bs_DV; -- will change this 
    end if;
  end process p_bubble_sort;
 end bs;
 