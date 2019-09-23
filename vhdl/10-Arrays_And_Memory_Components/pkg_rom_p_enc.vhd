library ieee;
use ieee.std_logic_1164.all;
package pkg_rom_p_enc is
	type mem_rom is array (0 to 15) of std_logic_vector(1 downto 0);
	constant rom: mem_rom := (0 to 1 => "00",
							  2 to 3 => "01",
							  4 to 7 => "10",
							  others => "11");
end pkg_rom_p_enc;
