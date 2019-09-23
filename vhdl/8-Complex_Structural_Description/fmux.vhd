library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fmux is
   generic (size: integer := 2);
   port (din: in std_logic_vector(2**size-1 downto 0);
   		sel: in std_logic_vector(size-1 downto 0);
        y: out std_logic);
end fmux;
architecture arc_fmux of fmux is
begin
	y <= din(conv_integer(sel));
end arc_fmux;