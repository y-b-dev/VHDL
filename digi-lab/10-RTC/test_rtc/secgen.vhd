--Time base generator for RTC
library ieee;
use ieee.std_logic_1164.all;
entity secgen is
   port (clk, resetN: in std_logic;
          sec_gen, half_gen, sym_gen: out std_logic);
end secgen;
architecture arc_secgen of secgen is
   constant clk_freq: integer:= 50000000;
   constant one_sec_count: integer := clk_freq - 1;
   constant half_sec_count: integer := clk_freq/2 - 1;
   signal count: integer range 0 to one_sec_count;
   signal internal_sec_gen, internal_half_gen: std_logic;
   signal internal_sym_gen: std_logic := '0';
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          count <= 0;
       elsif rising_edge(clk) then
          if one_sec_count <= count then
             count <= 0;
          else
             count <= count + 1;
          end if;
       end if;
    end process;
    internal_sec_gen <= '1' when count = one_sec_count else '0';
    internal_half_gen <= '1' when count = half_sec_count
    or count = one_sec_count else '0';
    process (clk, resetN)
    begin
       if resetN = '0' then
          internal_sym_gen <= '0';
          sec_gen <= '0';
          half_gen <= '0';
       elsif rising_edge(clk) then
          if internal_half_gen = '1' then
             internal_sym_gen <= not internal_sym_gen;
          end if;
          sec_gen <= internal_sec_gen;
          half_gen <= internal_half_gen;
       end if;
    end process;
    sym_gen <= internal_sym_gen;
end arc_secgen;