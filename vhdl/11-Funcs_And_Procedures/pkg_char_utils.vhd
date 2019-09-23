library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	

package pkg_char_utils is
	function to_stdlogicvector(c: character) return std_logic_vector;
end pkg_char_utils;

package body pkg_char_utils is
	function to_stdlogicvector(c: character) return std_logic_vector is 
	begin
		return (character'pos(c) + "00000000");
	end to_stdlogicvector;
end pkg_char_utils;
