--Connections when doing setup or running
library ieee;
use ieee.std_logic_1164.all;
entity ena_sel is
   port (set, set_s, set_m, set_h, secout, tc_s, tc_m: in std_logic;
        ce_s, ce_m, ce_h: out std_logic);
end ena_sel;
architecture arc_ena_sel of ena_sel is
   signal cnt, cnt10: std_logic_vector(3 downto 0);
begin
    process (set, set_s, set_m, set_h, secout, tc_s, tc_m)
    begin
       if set = '1' then
          ce_s <= set_s;
          ce_m <= set_m;
          ce_h <= set_h;
       else 
          ce_s <= secout;
          ce_m <= tc_s;
          ce_h <= tc_m;
       end if;
    end process;
end arc_ena_sel;