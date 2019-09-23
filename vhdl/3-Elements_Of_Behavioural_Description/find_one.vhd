entity find_one is
  port (
    din : in bit_vector(7 downto 0);
    dout : out bit_vector(7 downto 0)
  ) ;
end find_one ;

architecture arch_find_one of find_one is
begin
    process( din )
    variable tmp : bit_vector(7 downto 0);
    variable flag : boolean;
    begin
        tmp := "00000000";
        flag := true;
        for i in 7 downto 0 loop
            if (din(i) = '1') and (flag=true) then
                tmp(i) := '1';
				flag := false;
            end if ;    
        end loop ; 
        dout <= tmp;
   end process ; 
end architecture ; 