-- a simple mux2veclate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
entity tb_mux2vec is
end tb_mux2vec ;
architecture arc_tb_mux2vec of tb_mux2vec is
   component mux2vec
      generic (size: integer := 1);
  	  port (din0vec, din1vec: in std_logic_vector(size-1 downto 0);
   		sel: in std_logic;
        doutvec: out std_logic_vector(size-1 downto 0));
   end component ;
   signal din0vec, din1vec, doutvec: std_logic_vector(3 downto 0);
   signal sel: std_logic;
begin
   eut: mux2vec generic map (4)
   port map (din0vec, din1vec, sel, doutvec) ;
   process 
   begin
   	   -- getting i0
   	   sel <= '0'; din0vec <= "0010"; din1vec <= "1100"; wait for 100 ns;
   	   assert (doutvec = "0010") report " in selecting i0";
   	  -- getting i1
   	  sel <= '1'; din0vec <= "0010"; din1vec <= "1100"; wait for 100 ns;
   	  assert (doutvec = "1100") report " in selecting i1";
   	  report "end of test";
   wait;
   end process;
end arc_tb_mux2vec ;