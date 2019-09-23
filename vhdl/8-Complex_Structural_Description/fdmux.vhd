library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fdmux is
   generic (size: integer := 2);
   port (din: in std_logic;
   		sel: in std_logic_vector(size-1 downto 0);
        dout: out std_logic_vector(2**size-1 downto 0));
end fdmux;
architecture arc_fdmux of fdmux is
begin
	process(din, sel)
	begin
		dout <= (others => '0');
		dout(conv_integer(sel)) <= din;
	end process;
end arc_fdmux;