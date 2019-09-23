library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity zigzag is
   port (clk, resetN, ena: in  std_logic;
       count: out std_logic_vector(3 downto 0));
end zigzag ;
architecture arc_zigzag of zigzag is
   signal cnt: std_logic_vector(3 downto 0);
   signal up: std_logic;
begin
    process ( clk , resetN )
    begin
       if resetN = '0' then
          cnt <= (others => '0');
       elsif rising_edge(clk) then
          if ena = '1' then
             if up = '1' then
          	   cnt <= cnt + 1;
             else
               cnt <= cnt - 1;
             end if;
          end if;
       end if;
    end process;
    process ( clk , resetN )
    begin
       if resetN = '0' then
          up <= '1';
       elsif rising_edge(clk) then
          if ena = '1' then
             if cnt = 14 then
             	up <= '0';
             end if;
             if cnt = 1 then
             	up <= '1';
             end if;
          end if;
       end if ;
    end process ;
    count <= cnt ;
end arc_zigzag ;