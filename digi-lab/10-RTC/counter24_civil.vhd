--A mod 24 counter for RTC
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter24_civil is
   port (clk, resetN, ce, set_civil: in std_logic;
   		count, count10: out std_logic_vector(3 downto 0);
        tc, out_pm: out std_logic);
end counter24_civil;
architecture arc_counter24_civil of counter24_civil is
   signal cnt: integer range 0 to 23;
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          cnt <= 0;
       elsif rising_edge(clk) then
          if ce = '1' then
             if cnt = 23 then
             	cnt <= 0;
             else 
             	cnt <= cnt + 1;
             end if;
          end if;
       end if;
    end process;
    tc <= '1' when ce = '1' and cnt = 23;
    count <= ((cnt mod 10) + "0000") when set_civil = '0' or cnt < 13
    else (((cnt - 12) mod 10) + "0000");
    count10 <= ((cnt / 10) + "0000") when set_civil = '0' or cnt < 13
    else (((cnt - 12) / 10) + "0000");
    out_pm <= '1' when cnt > 12 else '0';
end arc_counter24_civil;