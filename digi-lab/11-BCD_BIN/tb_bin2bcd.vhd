library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_bin2bcd is
end tb_bin2bcd ;
architecture arc_tb_bin2bcd of tb_bin2bcd is
   component bin2bcd
       generic (width_bin: positive := 8;  
               width_bcd: positive := 3);  		   
      port (bin: in std_logic_vector(width_bin - 1 downto 0);
      bcd: out std_logic_vector(width_bcd * 4 - 1 downto 0));
   end component;
   constant bin_zero_vec: std_logic_vector(7 downto 0) := (others => '0');
   signal bin: std_logic_vector(7 downto 0);
   signal bcd: std_logic_vector(11 downto 0);
   signal bcd_res: std_logic_vector(11 downto 0);
begin
   eut: bin2bcd generic map(8, 3) port map(bin, bcd);
   process
   begin
      bin <= (1 + bin_zero_vec);
      bcd_res <= (0 => '1', others => '0');
      assert bcd = bcd_res report "ERROR";
      wait for 100 ns;
      bin <= (128 + bin_zero_vec);
      bcd_res <= (3 => '1', 5 => '1', 8 => '1', others => '0');
      assert bcd = bcd_res report "ERROR";
      wait for 100 ns;
      report "end of test";
      wait;
   end process ;
end arc_tb_bin2bcd ;