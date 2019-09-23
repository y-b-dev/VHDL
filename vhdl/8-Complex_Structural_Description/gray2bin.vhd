entity gray2bin is
   generic (wid: integer := 4);
   port (g: in bit_vector(wid-1 downto 0);
        b: buffer bit_vector(wid-1 downto 0));
end gray2bin;
architecture arc_gray2bin of gray2bin is
	component fxor is 
		generic(size: integer := 2);
   		port(ins: in bit_vector(size-1 downto 0);
        outs: buffer bit);
    end component;
begin
	gen: for i in 0 to wid-1 generate
		u: fxor generic map(i+1) port map(g(wid-1 downto wid-1-i), b(wid-1-i));
	end generate;
end arc_gray2bin;