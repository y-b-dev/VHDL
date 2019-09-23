-- a simple template file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity TEMP is
   port ( din,clk,resetN : in  std_logic ;
          dout           : out std_logic ) ;
end TEMP ;
architecture arc_TEMP of TEMP is
   signal sampled1 , sampled2 : std_logic ;
begin
    process ( clk , resetN )
    begin
       if resetN = '0' then
          sampled1 <= '0' ;
          sampled2 <= '0' ;
       elsif clk'event and clk = '1' then
          sampled1 <= din      ;
          sampled2 <= sampled1 ;
       end if ;
    end process ;
    dout <= sampled1 and not sampled2 ;
end arc_TEMP ;