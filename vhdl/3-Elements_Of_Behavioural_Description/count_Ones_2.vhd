library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity count_Ones_2 is
  port (
    din : in std_logic_vector(7 downto 0);
    dout : out std_logic_vector(2 downto 0)
  ) ;
end count_Ones_2 ;
architecture arch_count_Ones_2 of count_Ones_2 is
begin
    process( din )
    variable tmp : std_logic_vector(2 downto 0);
    begin
        tmp := "000";
        for i in 0 to 7 loop
            if din(i) = '1' then
                tmp := tmp + "001";
            end if ;    
        end loop ; 
        dout <= tmp;
   end process ; 
end architecture ; 

