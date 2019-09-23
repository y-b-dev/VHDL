--A mod 24 counter for RTC
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter24 is
   port (clk, resetN, ce: in std_logic;
   		count, count10: out std_logic_vector(3 downto 0);
        tc: out std_logic);
end counter24;
architecture arc_counter24 of counter24 is
   signal cnt, cnt10: std_logic_vector(3 downto 0);
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          cnt <= (others => '0');
          cnt10 <= (others => '0');
       elsif rising_edge(clk) then
          if ce = '1' then
             if cnt10 = 2 then
             	if cnt = 3 then
             		cnt <= (others => '0');
             		cnt10 <= (others => '0');
             	else
             		cnt <= cnt + 1;
             	end if;
             elsif cnt = 9 then
             	cnt10 <= cnt10 + 1;
             	cnt <= (others => '0');
             else
             	cnt <= cnt + 1;
             end if;
          end if;
       end if;
    end process;
    tc <= '1' when ce = '1' and cnt = 3 and cnt10 = 2 else '0';
    count <= cnt;
    count10 <= cnt10;
end arc_counter24;