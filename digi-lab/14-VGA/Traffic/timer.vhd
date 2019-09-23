library ieee;
use ieee.std_logic_1164.all;

entity timer is
   generic (mili_secs: integer := 1000;
            freq_in_MH: positive := 25;
            slow_num_of_bits: positive := 5);
   port (resetN, clk, sc: in std_logic;
          t_out: out integer range 0 to 2 ** slow_num_of_bits - 1);
end timer;

architecture arc_timer of timer is

   constant clk_freq: integer:= freq_in_MH * 10**6 / 1000 * mili_secs;
   constant one_unit_count: integer := clk_freq - 1;
   constant slow_count_limit: integer :=  2 ** slow_num_of_bits - 1;

   signal fast_count: integer range 0 to one_unit_count;
   signal slow_count: integer range 0 to slow_count_limit;
   
begin
    process (clk, resetN)
    begin
       if resetN = '0' then
          fast_count <= 0;
          slow_count <= 0;
       elsif rising_edge(clk) then
          if sc = '1' then
            fast_count <= 0;
            slow_count <= 0;
          elsif fast_count = one_unit_count then
             fast_count <= 0;
             if slow_count /= slow_count_limit then
                slow_count <= slow_count + 1; 
             end if;
          else
             fast_count <= fast_count + 1;
          end if;
       end if;
    end process;

    t_out <= slow_count;

end arc_timer;