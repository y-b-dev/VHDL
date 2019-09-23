--Connections when doing setup or running
library ieee;
use ieee.std_logic_1164.all;
entity ena_sel_improved is
   port (set, set_s, set_m, set_h ,cs_out, tc_cs, tc_s, tc_m: in std_logic;
        ce_cs, ce_s, ce_m, ce_h: out std_logic);
end ena_sel_improved;
architecture arc_ena_sel_improved of ena_sel_improved is
   signal cnt, cnt10: std_logic_vector(3 downto 0);
begin
    process (set, set_s, set_m, set_h ,cs_out, tc_cs, tc_s, tc_m)
    begin
       if set = '1' then
          ce_s <= set_s;
          ce_m <= set_m;
          ce_h <= set_h;
          ce_cs <= '0';
       else 
          ce_s <= tc_cs;
          ce_m <= tc_s;
          ce_h <= tc_m;
          ce_cs <= cs_out;
       end if;
    end process;
end arc_ena_sel_improved;