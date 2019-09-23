entity count_Ones is
  port (
    din : in bit_vector(7 downto 0);
    dout : out integer range 0 to 7
  ) ;
end count_Ones ;

architecture arch_count_Ones of count_Ones is
begin
    process( din )
    variable counter : integer range 0 to 7;
    begin
        counter:=0;
        for i in 0 to 7 loop
            if din(i) = '1' then
                counter := counter+1;
            end if ;    
        end loop ; 
        dout <= counter;
   end process ; 
end architecture ; 