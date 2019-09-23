library ieee;
use ieee.std_logic_1164.all;

entity reg_ena is
   generic (width: natural := 3);
   port (resetN, clk, ena: in std_logic;
   		din: in std_logic_vector(width-1 downto 0);
        dout: out std_logic_vector(width-1 downto 0));
end reg_ena;

architecture arc_reg_ena of reg_ena is
begin
	
	process( resetN, clk )
	begin
		if resetN = '0' then
			dout <= (others => '0');
		elsif rising_edge(clk) then
			if ena = '1' then
				dout <= din;
			end if ;
		end if ;
	end process ; -- 
	
end arc_reg_ena;