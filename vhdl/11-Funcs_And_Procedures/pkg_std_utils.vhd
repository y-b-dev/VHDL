library ieee;
use ieee.std_logic_1164.all;

package pkg_std_utils is
	function twist(vec: std_logic_vector) return std_logic_vector;
end pkg_std_utils;

package body pkg_std_utils is
	function twist(vec: std_logic_vector) return std_logic_vector is 
		variable len: integer := vec'length - 1;
		variable res: std_logic_vector(len downto 0);
	begin
		for i in 0 to len loop
			res(len -i) := vec(i);
		end loop;
		return res;
	end twist;
end pkg_std_utils;
