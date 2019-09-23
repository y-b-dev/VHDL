library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bin2bcd is
    generic (width_bin: positive := 8;  
            width_bcd: positive := 3); 	   
   port (bin: in std_logic_vector(width_bin - 1 downto 0);
   bcd: out std_logic_vector(width_bcd * 4 - 1 downto 0));
end bin2bcd;
architecture arc_bin2bcd of bin2bcd is
constant w: integer := width_bcd - 1;
begin
    process (bin)
       variable temp: integer;
    begin
   	   temp := conv_integer(bin);
   	   for i in 0 to w - 1 loop
   	      bcd(4 * i + 3 downto 4 * i) <= (temp mod 10) + "0000";
   	      temp := temp/10;	
   	   end loop;
   	   bcd(w * 4 + 3 downto w * 4) <= temp + "0000";
    end process;
end arc_bin2bcd;