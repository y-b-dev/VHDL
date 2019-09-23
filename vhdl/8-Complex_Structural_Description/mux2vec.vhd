library ieee ;
use ieee.std_logic_1164.all ;
entity mux2vec is
   generic (size: integer := 1);
   port (din0vec, din1vec: in std_logic_vector(size-1 downto 0);
   		sel: in std_logic;
        doutvec: out std_logic_vector(size-1 downto 0));
end mux2vec ;
architecture arc_mux2vec of mux2vec is
begin
	doutvec <= din0vec when sel = '0' else din1vec;
end arc_mux2vec;