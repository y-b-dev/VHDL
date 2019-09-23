--A mod 100 counter for RTC
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter100 is
   port (clk, resetN, ce: in std_logic;
   		count, count10: out std_logic_vector(3 downto 0);
   		tc: out std_logic);
end counter100;
architecture arc_counter100 of counter100 is
   signal cnt, cnt10: std_logic_vector(3 downto 0);
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          cnt <= (others => '0');
       elsif rising_edge(clk) then
          if ce = '1' then
             if cnt = 9 then
                cnt <= (others => '0');
             else
             	cnt <= cnt + 1;
             end if;
          end if;
       end if;
    end process;
    process (clk, resetN)
    begin
       if resetN = '0' then
          cnt10 <= (others => '0');
       elsif rising_edge(clk) then
          if ce = '1' then
             if cnt = 9 then
             	if cnt10 = 9 then
             		cnt10 <= (others => '0');             
             	else
             		cnt10 <= cnt10 + 1;
             	end if;
             end if;
          end if;
       end if;
    end process;
    tc <= '1' when ce = '1' and cnt = 9 and cnt10 = 9 else '0';
    count <= cnt;
    count10 <= cnt10;
end arc_counter100;