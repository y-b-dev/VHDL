entity fxor is
   generic(size: integer := 2);
   port(ins: in bit_vector(size-1 downto 0);
        outs: buffer bit);
end fxor;
architecture arc_fxor of fxor is
begin
	process(ins)
		variable res: bit;
	begin
		res := '0';
		for i in 0 to size-1 loop
			res := res xor ins(i);
		end loop;
		outs <= res;
	end process;
end arc_fxor;