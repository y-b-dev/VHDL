library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;

entity counter is
  port (
    resetN, clk, up, down: in std_logic;
    count: out std_logic_vector(7 downto 0)
  ) ;
end counter ; 

architecture arch of counter is
    signal cnt: integer range 0 to 255;
begin
    process( resetN, clk )
    begin
        if resetN = '0' then
            cnt <= 0;
        elsif rising_edge(clk) then
            if up = '1' and down = '0' and cnt /= 255 then
                cnt <= cnt + 1;
            elsif up = '0' and down = '1' and cnt /= 0 then
                cnt <= cnt - 1;
            end if ;
        end if ;    
    end process ; 
    count <= cnt + "00000000";    
end arch ;
