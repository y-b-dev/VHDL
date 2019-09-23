-- a simple template of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all ;
entity tb_TEMP is
   -- test bench with no ports
end tb_TEMP ;
architecture arc_tb_TEMP of tb_TEMP is
   component TEMP
      port ( din,clk,resetN : in  std_logic ;
             dout           : out std_logic ) ;
   end component ;
   signal din, clk, resetN : std_logic ;
   signal dout             : std_logic ;
begin
   eut: TEMP port map ( din , clk , resetN , dout ) ;
   -- active low reset pulse
   resetN <= '0' , '1' after 100 ns ;
   -- clock process
   process
   begin
      clk <= '0' ;  wait for 50 ns ;
      clk <= '1' ;  wait for 50 ns ;
   end process ;
   din <= '0' , '1' after 200 ns , '0' after 600 ns ;
end arc_tb_TEMP ;