library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_bcd2bin is
end tb_bcd2bin ;
architecture arc_tb_bcd2bin of tb_bcd2bin is
   component bcd2bin
       generic (width_bin: positive := 8;  
            width_bcd: positive := 3); 		   
       port (bcd: in std_logic_vector(width_bcd * 4 - 1 downto 0);
                bin: out std_logic_vector(width_bin - 1 downto 0));
   end component;
   signal bin: std_logic_vector(7 downto 0);
   signal bcd: std_logic_vector(11 downto 0);
   signal bin_res: integer;
begin
   eut: bcd2bin generic map(8, 3) port map(bcd, bin);
   process
   begin
      bcd <= (0 => '1', others => '0');
      bin_res <= 1;
      assert bin = bin_res report "ERROR";
      wait for 100 ns;
      bcd <= (3 => '1', 5 => '1', 8 => '1', others => '0');
      bin_res <= 128;
      assert bin = bin_res report "ERROR";
      wait for 100 ns;
      report "end of test";
      wait;
   end process ;
end arc_tb_bcd2bin ;