use IEEE. NUMERIC_STD. ALL;
entity blink is
Port (clk
in std_logic;
in std logic;
out std logic);
:
rst
:
y_out:
end blink;
architecture rtl of blink is
signal counter : unsigned (27 downto 0);
begin
P_cnt: process (clk, rst) is
begin
if rst = '1' then
counter <=(others => '0');
%3D
elsif rising_edge (clk) then
counter <= counter + 1;
end if;
end process;
felock
226
100MHZ
folink
y_out <= counter(26);
226
end rtl;