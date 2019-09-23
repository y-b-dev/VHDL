library ieee ;
use ieee.std_logic_1164.all ;
entity demux2vec is
   generic (size: integer := 1);
   port (dinvec: in std_logic_vector(size-1 downto 0);
   		sel: in std_logic;
        dout0vec, dout1vec: out std_logic_vector(size-1 downto 0));
end demux2vec ;
architecture arc_demux2vec of demux2vec is
begin
	process(dinvec, sel)
	begin
		dout0vec <= (others => '0');
		dout1vec <= (others => '0');
		if sel = '0' then
			dout0vec <= dinvec;
		else
			dout1vec <= dinvec;
		end if;
	end process;
end arc_demux2vec;