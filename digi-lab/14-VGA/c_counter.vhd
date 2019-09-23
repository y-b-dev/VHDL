library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;

entity c_counter is
   generic (width: positive := 3);
   port (resetN, clk: in std_logic;
        dout: out std_logic_vector(width-1 downto 0));
end c_counter;

architecture arc_c_counter of c_counter is

	signal int_count: std_logic_vector(width-1 downto 0);

begin

	process( resetN, clk )
	begin
		if resetN = '0' then
			int_count <= (others => '0');
		elsif rising_edge(clk) then
			int_count <= int_count + 1;
		end if ;
    end process ; 
    dout <= int_count; 
	
end arc_c_counter;