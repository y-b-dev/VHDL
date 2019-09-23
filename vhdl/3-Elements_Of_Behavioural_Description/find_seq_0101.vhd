library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity find_seq_0101 is
  port (
    din : in std_logic_vector(9 downto 0);
    dout : out std_logic_vector(2 downto 0)
  ) ;
end find_seq_0101 ;

architecture arch_find_seq_0101 of find_seq_0101 is
begin
    process( din )
    variable tmp : std_logic_vector(2 downto 0);
    begin
        tmp := "000";
        for i in 9 downto 3 loop
            if din(i) = '0' then
            	if din(i-1) = '1' and din(i-2) = '0' and din(i-3) = '1' then
            		tmp := tmp + "001";
            	end if;
            end if;       
        end loop ; 
        dout <= tmp;
   end process ; 
end architecture ; 