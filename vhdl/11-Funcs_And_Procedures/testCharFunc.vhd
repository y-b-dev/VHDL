library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;	
use work.pkg_char_utils.all;

entity testCharFunc is
end testCharFunc; 

architecture arch of testCharFunc is
    signal c: character;
begin
    process
    begin
        c <= 'a'; wait for 100 ns;
        assert(to_stdlogicvector(c) = 97) report " in func";
        report "end of test";
        wait;
   end process;
end arch ; -- arch