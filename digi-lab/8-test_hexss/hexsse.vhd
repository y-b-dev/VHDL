library ieee;
use ieee.std_logic_1164.all;
entity hexsse is
   port (din: in std_logic_vector(3 downto 0);
   		ena: in std_logic;
   		ss: out std_logic_vector(6 downto 0));
end hexsse ;
architecture arc_hexsse of hexsse is
	signal ss_sig: std_logic_vector(6 downto 0);
begin
	ss_sig <= "0000001" when din = "0000" else
		"1001111" when din = "0001" else
		"0010010" when din = "0010" else
		"0000110" when din = "0011" else
		"1001100" when din = "0100" else
		"0100100" when din = "0101" else
		"0100000" when din = "0110" else
		"0001111" when din = "0111" else
		"0000000" when din = "1000" else
		"0000100" when din = "1001" else
		"0001000" when din = "1010" else
		"1100000" when din = "1011" else
		"0110001" when din = "1100" else
		"1000010" when din = "1101" else
		"0110000" when din = "1110" else "0111000";
	ss <= ss_sig when ena = '1' else "1111111";
end arc_hexsse;