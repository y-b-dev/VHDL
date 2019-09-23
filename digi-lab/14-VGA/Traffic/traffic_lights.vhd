library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity traffic_lights is
   port (r1, y1, g1, r2, y2, g2: in std_logic;
        count_h, count_v: in std_logic_vector(9 downto 0);
        red, green, blue: out std_logic);
        end traffic_lights;

architecture arc_traffic_lights of traffic_lights is

begin

    process( r1, y1, g1, r2, y2, g2, count_h, count_v )
    begin
        red <= '0';
        green <= '0';
        blue <= '0';

        if ((r1 = '1' or r2 = '1') 
            and ( 
                    (count_v > 63 and count_v < 128) 
                    and (
                            (count_h > 63 and count_h < 128) or (count_h > 191 and count_h < 256)
                    ) 
            )
        ) 
        then 
            red <= '1';
        
        elsif ((y1 = '1' or y2 = '1') 
            and ( 
                    (count_v > 127 and count_v < 192) 
                    and (
                            (count_h > 63 and count_h < 128) or (count_h > 191 and count_h < 256)
                    ) 
            )
        ) 
        then 
            red <= '1';
            green <= '1';

        elsif ((g1 = '1' or g2 = '1') 
            and ( 
                    (count_v > 127 and count_v < 192) 
                    and (
                            (count_h > 63 and count_h < 128) or (count_h > 191 and count_h < 256)
                    ) 
            )
        ) 
        then 
            green <= '1';
            
        end if;

    end process ;  
	
end arc_traffic_lights;

