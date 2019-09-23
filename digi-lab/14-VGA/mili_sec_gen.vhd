--Time base generator for RTC
library ieee;
use ieee.std_logic_1164.all;

entity mili_sec_gen is
   generic (mil_sec: integer := 1000;
            freq: positive := 50);
   port (resetN, clk: in std_logic;
          ms_sec_gen: out std_logic);
end mili_sec_gen;

architecture arc_mili_sec_gen of mili_sec_gen is

   constant clk_freq: integer:= 10**6 / 1000 * mil_sec * freq;
   constant one_unit_count: integer := clk_freq - 1;
   signal count: integer range 0 to one_unit_count;
   signal internal_unit_gen: std_logic;

begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          count <= 0;
       elsif rising_edge(clk) then
          if one_unit_count = count then
             count <= 0;
          else
             count <= count + 1;
          end if;
       end if;
    end process;

    internal_unit_gen <= '1' when count = one_unit_count else '0';

    process (clk, resetN)
    begin
       if resetN = '0' then
          ms_sec_gen <= '0';
       elsif rising_edge(clk) then
          ms_sec_gen <= internal_unit_gen;
       end if;
    end process;

end arc_mili_sec_gen;