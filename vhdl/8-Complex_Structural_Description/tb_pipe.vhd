-- a simple pipelate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
entity tb_pipe is
end tb_pipe ;
architecture arc_tb_pipe of tb_pipe is
   component pipe
      generic (depth: natural := 1);
   	  port (resetN, clk, din: in std_logic;
        dout: out std_logic);
   end component;
   signal resetN, clk, din, dout: std_logic;
begin
   eut: pipe generic map(3) port map(resetN, clk, din, dout);
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
   	  din <= '0'; wait for 100 ns; -- do nothing during reset
   	  din <= '1'; wait for 300 ns; -- wait until the '1' gets to dout
   	  assert (dout = '1') report " in piping";
   	  report "end of test";
      wait;
   end process;
end arc_tb_pipe;