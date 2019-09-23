library ieee ;
use ieee.std_logic_1164.all ;
entity t_ff is
   port ( resetN: in std_logic ;
          clk: in std_logic ;
          q: out std_logic );
end t_ff;
architecture arc_t_ff of t_ff is 
    signal q_int: std_logic;
begin
   process ( resetN , clk ) 
   begin
        if resetN = '0' then
            q_int <= '0';
        elsif rising_edge(clk) then
            q_int <= not q_int;
        end if;
   end process;
   q <= q_int;
end arc_t_ff ; 