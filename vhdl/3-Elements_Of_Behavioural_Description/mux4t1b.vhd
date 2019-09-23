entity mux4t1b is
  port (
    din: in bit_vector(3 downto 0);
    sel: in bit_vector(1 downto 0);
    dout: out bit
  ) ;
end mux4t1b ;
architecture arch_mux4t1b of mux4t1b is
begin
    with sel select
    dout <= din(0) when "00",
            din(1) when "01",
            din(2) when "10",
            din(3) when others;
end architecture ; 