entity mux4t1c is
  port (
    din: in bit_vector(3 downto 0);
    sel: in bit_vector(1 downto 0);
    dout: out bit
  ) ;
end mux4t1c ;
architecture arch_mux4t1c of mux4t1c is
begin
    process( sel )
    begin
      if sel = "00" then dout <= din(0);
      elsif sel = "01" then dout <= din(1);
      elsif sel = "10" then dout <= din(2);
      else dout <= din(3);
      end if;
    end process ; 
end architecture ; 