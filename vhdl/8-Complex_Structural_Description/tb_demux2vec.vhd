-- a simple demux2veclate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
entity tb_demux2vec is
end tb_demux2vec ;
architecture arc_tb_demux2vec of tb_demux2vec is
   component demux2vec
      generic (size: integer := 1);
  	  port (dinvec: in std_logic_vector(size-1 downto 0);
   		sel: in std_logic;
        dout0vec, dout1vec: out std_logic_vector(size-1 downto 0));
   end component ;
   signal dinvec_2, dout0vec_2, dout1vec_2: std_logic_vector(1 downto 0);
   signal dinvec_5, dout0vec_5, dout1vec_5: std_logic_vector(4 downto 0);
   signal sel: std_logic;
begin
   eut2: demux2vec generic map (2)
   port map (dinvec_2, sel, dout0vec_2, dout1vec_2);
   eut5: demux2vec generic map (5)
   port map (dinvec_5, sel, dout0vec_5, dout1vec_5);
   process 
   begin
   	   -- getting 1st output
   	   sel <= '0'; dinvec_2 <= "10"; dinvec_5 <= "11100"; wait for 100 ns;
   	   assert (dout0vec_2 = "10" and dout1vec_2 = "00") report " in out0 vec_2";
   	   assert (dout0vec_5 = "11100" and dout1vec_5 = "00000") report " in out0 vec_5";
   	  -- getting 2nd output
   	  sel <= '1'; dinvec_2 <= "10"; dinvec_5 <= "11100"; wait for 100 ns;
   	  assert (dout1vec_2 = "10" and dout0vec_2 = "00") report " in out1 vec_2";
   	  assert (dout1vec_5 = "11100" and dout0vec_5 = "00000") report " in out1 vec_5";
   	  report "end of test";
      wait;
   end process;
end arc_tb_demux2vec;