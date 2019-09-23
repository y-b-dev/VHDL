entity tb_gray2bin is
end tb_gray2bin ;
architecture arc_tb_gray2bin of tb_gray2bin is
   component gray2bin
      generic (wid: integer := 4);
  	  port (g: in bit_vector(wid-1 downto 0);
        b: buffer bit_vector(wid-1 downto 0));
   end component;
   signal g,b: bit_vector(2 downto 0);
begin
   eut: gray2bin generic map(3) port map(g,b);
   process
   begin
   	  g <= "111"; wait for 100 ns; 
   	  assert (b = "101") report " in gray to bin";
   	  report "end of test";
      wait;
   end process;
end arc_tb_gray2bin;