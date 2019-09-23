library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package std_logic_integers is
	function "and"(a, b: integer) return integer;
end std_logic_integers;

package body std_logic_integers is
	function "and"(a, b: integer) return integer is 
		variable res, a_vec, b_vec: std_logic_vector(31 downto 0);
		constant zero_vec: std_logic_vector(31 downto 0) := (others => '0');
	begin
		a_vec := a + zero_vec;
		b_vec := b + zero_vec;
		for i in 0 to 31 loop
			res(i) := a_vec(i) and b_vec(i);
		end loop;
		return conv_integer(res);
	end "and";
end std_logic_integers;
