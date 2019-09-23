library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bcd2bin is
   generic (width_bin: positive := 8;  
            width_bcd: positive := 3); 		   
   port (bcd: in std_logic_vector(width_bcd * 4 - 1 downto 0);
            bin: out std_logic_vector(width_bin - 1 downto 0));
end bcd2bin;
architecture arc_bcd2bin of bcd2bin is
constant w: integer := width_bcd - 1;
constant bin_vec_zeros: std_logic_vector(width_bin - 1 downto 0) := (others => '0');
begin
    process (bcd)
       variable temp: integer;
    begin
   	   temp := 0;
   	   for i in w downto 0 loop
   	      if (i > 0) then
   	         temp := (temp + conv_integer(bcd(4 * i + 3 downto 4 * i))) * 10;	
   	      else 
   	         temp := temp + conv_integer(bcd(3 downto 0));
   	      end if;
   	   end loop;
   	   
   	   bin <= temp + bin_vec_zeros;
    end process;
end arc_bcd2bin;