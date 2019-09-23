-- a simple fmuxlate of test bench file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all;
entity tb_fmux is
end tb_fmux ;
architecture arc_tb_fmux of tb_fmux is
   component fmux
      generic (size: integer := 2);
  	  port (din: in std_logic_vector(2**size-1 downto 0);
   		sel: in std_logic_vector(size-1 downto 0);
        y: out std_logic);
   end component;
   signal din: std_logic_vector(3 downto 0);
   signal sel: std_logic_vector(1 downto 0);
   signal y: std_logic;
begin
   eut: fmux port map(din, sel, y);
   process 
   begin
   	  -- selecting i0
   	  sel <= "00"; din <= "0001"; wait for 100 ns;
   	  assert(y = '1') report " in i0";
   	  -- selecting i1
   	  sel <= "01"; din <= "0010"; wait for 100 ns;
   	  assert(y = '1') report " in i1";
   	  -- selecting i2
   	  sel <= "10"; din <= "0100"; wait for 100 ns;
   	  assert(y = '1') report " in i2";
   	  -- selecting i3
   	  sel <= "11"; din <= "1000"; wait for 100 ns;
   	  assert(y = '1') report " in i3";
   	  report "end of test";
      wait;
   end process;
end arc_tb_fmux;