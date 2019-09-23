--Time base generator for RTC
library ieee;
use ieee.std_logic_1164.all;
entity cent_sec_gen is
   port (clk, resetN: in std_logic;
          cent_sec_gen: out std_logic);
end cent_sec_gen;
architecture arc_cent_sec_gen of cent_sec_gen is
   constant sec_div: integer:= 100;
   constant clk_freq: integer:= 50000000;
   constant one_cent_sec_count: integer := clk_freq/sec_div - 1;
   signal count: integer range 0 to one_cent_sec_count;
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          count <= 0;
       elsif rising_edge(clk) then
        	  if count = one_cent_sec_count then
        	     count <= 0;
       	      else
          	     count <= count + 1;
        	  end if;
       end if;
    end process;
    cent_sec_gen <= '1' when count = one_cent_sec_count else '0';
end arc_cent_sec_gen;