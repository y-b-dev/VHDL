entity mux4t1d is
  port (
    din: in bit_vector(3 downto 0);
    sel: in bit_vector(1 downto 0);
    dout: out bit
  ) ;
end mux4t1d;
architecture arch_mux4t1d of mux4t1d is
begin
    process( sel )
    begin
      case( sel ) is
      
        when "00" =>
          dout <= din(0);       
        when "01" =>
          dout <= din(1);
        when "10" =>
          dout <= din(2);             
        when others =>
          dout <= din(3);
      end case ;
    end process ; 
end architecture ; 