entity count_seq_zeros is
  port (
    din : in bit_vector(7 downto 0);
    dout : out bit_vector(2 downto 0)
  ) ;
end count_seq_zeros ;

architecture arch_count_seq_zeros of count_seq_zeros is
begin
    process( din )
    variable max,counter : integer range 0 to 7;
    begin
        counter:=0;
        max:=0;
        for i in 0 to 7 loop
            if din(i) = '0' then
                counter := counter+1;
            else 
                if counter > max then
                    max:=counter;
                end if ;   
                counter:=0;
            end if ;    
        end loop ; 
        for i in 0 to 2 loop
            if max mod 2 = 0 then
                dout(i) <= '0';
            else
                dout(i) <= '1';
            end if ;
            max:=max/2;
        end loop ;  
    end process ; 
end architecture ; 