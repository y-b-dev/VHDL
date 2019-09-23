library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity bcdup is
   port ( sclear, clk, resetN, cep, cet : in  std_logic;
          tc           : out std_logic; 
          qout : buffer integer range 0 to 9);
end bcdup ;
architecture arc_bcdup of bcdup is
begin
    process ( clk , resetN )
    begin
       if resetN = '0' then
          qout <= 0;
       elsif rising_edge(clk) then
          if sclear='1' then 
          	qout <= 0;
          elsif cep='1' and cet='1' then
          	if qout < 9 then
          		qout <= qout+1;
          	end if;
          end if;
       end if ;
    end process ;
    tc <= '1' when cet='1' and qout=9 else '0';
end arc_bcdup ;