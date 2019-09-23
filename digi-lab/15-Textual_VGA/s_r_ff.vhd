library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity s_r_ff is
   port (resetN, clk, s, r: in std_logic;
        q: out std_logic);
        end s_r_ff;

architecture arc_s_r_ff of s_r_ff is
    signal int_q: std_logic;
begin
    process (resetN, clk)
    begin
        if resetN = '0' then
            int_q <= '0';
        elsif rising_edge(clk) then
            if s = '0' and r = '1' then
                int_q <= '0';
            elsif s = '1' and r = '0' then
                int_q <= '1';
            elsif s = '1' and r = '1' then
                int_q <= not int_q;
            end if;
        end if;
    end process;
    q <= int_q;  
end arc_s_r_ff;

