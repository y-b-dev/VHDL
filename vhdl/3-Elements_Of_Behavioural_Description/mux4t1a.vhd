entity mux4t1a is
  port (
    din: in bit_vector(3 downto 0);
    sel: in bit_vector(1 downto 0);
    dout: out bit
  ) ;
end mux4t1a ;
architecture arch_mux4t1a of mux4t1a is
begin
    dout<= din(0) when sel="00" else
    din(1) when sel="01" else
    din(2) when sel="10" else din(3);
end architecture ; 