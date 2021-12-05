use IEEE. NUMERIC_STD. ALL;
entity cnt 1s
Port (clk
rst
in std logic;
in std logic;
out std_logic_vector (3 downto 0));
:
y_out:
end cnt;
architecture rtl of cnt is
signal slow_clk, slow_clk_p : std_logic; signal counter : unsigned (27 downto 0);
signal slow_counter : unsigned (3 downto 0):
begin
P_čnt: process (clk, rst) is
begin
if rst - '1' then
counter <- (others -> '0');
elsif rising edge (clk) then
counter <- counter + 1:
end if:
end process:
<- counter(26);
slov_clk
P_slv_cnt: process (clk, rst, slow_clk) is
begin
if rst - '1' then
slov counter <- (others -> '0');
elsif rising edge (clk) then
slov_clk_p <- slow_clk;
if slov clk 'l' and slov_clk_P
- '0' then
"RISING EDGE"
slov_counter <- slov_counter + 1;
end if:
end if;
end process;
y_out <e std_logic_vector (slov_counter);
end rtl: