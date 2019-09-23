-- a simple fdmuxlate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_fdmux is
end tb_fdmux ;
architecture arc_tb_fdmux of tb_fdmux is
   component fdmux
      generic (size: integer := 2);
  	  port (din: in std_logic;
   		sel: in std_logic_vector(size-1 downto 0);
        dout: out std_logic_vector(2**size-1 downto 0));
   end component;
   signal din: std_logic;
   signal sel: std_logic_vector(2 downto 0);
   signal dout: std_logic_vector(7 downto 0);
begin
   eut: fdmux generic map(3) port map(din, sel, dout);
   process 
   begin
   	  -- selecting i0
   	  sel <= "000"; din <= '1'; wait for 100 ns;
   	  assert(dout = 1) report " in dmux";
   	  report "end of test";
      wait;
   end process;
end arc_tb_fdmux;