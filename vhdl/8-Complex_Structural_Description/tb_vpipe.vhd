-- a simple vpipelate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
entity tb_vpipe is
end tb_vpipe ;
architecture arc_tb_vpipe of tb_vpipe is
   component vpipe
      generic (depth: natural := 1;
   			width: positive := 1);
   	  port (resetN, clk: in std_logic;
   		din: in std_logic_vector(width-1 downto 0);
        dout: out std_logic_vector(width-1 downto 0));
   end component;
   signal resetN, clk: std_logic;
   signal din, dout: std_logic_vector(2 downto 0);
begin
   eut: vpipe generic map(3, 3) port map(resetN, clk, din, dout);
   -- reset cycle
   resetN <= '0' , '1' after 100 ns;
   -- clock process
   process
   begin
      clk <= '0' ;  wait for 50 ns ;
      clk <= '1' ;  wait for 50 ns ;
   end process ;
   -- input process
   process
   begin
   	  din <= (others => '0'); wait for 100 ns; -- do nothing during reset
   	  din(0) <= '1'; din(1) <= '1'; din(2) <= '1'; 
   	  wait for 300 ns; -- wait until the '1' gets to dout
   	  assert (dout(0) = '1' and dout(1) = '1' and dout(2) = '1') report " in piping";
   	  report "end of test";
      wait;
   end process;
end arc_tb_vpipe;