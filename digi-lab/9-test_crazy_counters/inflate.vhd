library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity inflate is
   port (clk, resetN, ena: in  std_logic;
       count: out std_logic_vector(3 downto 0));
end inflate ;
architecture arc_inflate of inflate is
   signal slow_cnt, fast_cnt: std_logic_vector(3 downto 0);
begin
    process (clk , resetN)
    begin
       if resetN = '0' then
          slow_cnt <= (others => '0');
          fast_cnt <= (others => '0');
       elsif rising_edge(clk) then
       	 if ena = '1' then
       	   if slow_cnt = fast_cnt then
        	  	slow_cnt <= (others => '0');
            	fast_cnt <= fast_cnt + 1;
          	else 
          		slow_cnt <= slow_cnt + 1;
         	end if;
         end if;
       end if;
    end process;
    count <= slow_cnt ;
end arc_inflate ;