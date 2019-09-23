library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_bin2bcd  is
	-- test bench with no ports
end tb_bin2bcd ;
architecture arc_tb_bin2bcd  of tb_bin2bcd  is
   component bin2bcd
      port (start, clk, resetN: in  std_logic;
   		 din: in std_logic_vector(7 downto 0);
   		 dout_high, dout_mid, dout_low: out std_logic_vector(3 downto 0);
         ready: out std_logic);
   end component;
   signal start, clk, resetN, ready : std_logic;
   signal din : std_logic_vector(7 downto 0);
   signal dout_high, dout_mid, dout_low : std_logic_vector(3 downto 0);
begin
   eut: bin2bcd  port map (start, clk, resetN, din, dout_high, dout_mid,
   							 dout_low, ready);
   -- active low reset pulse
   resetN <= '0' , '1' after 100 ns;
   -- clock process
   process
   begin
      clk <= '0';  wait for 50 ns;
      clk <= '1';  wait for 50 ns;
   end process;
   -- sync input process
   process
   begin
   		-- reset cycle
   		start <= '0'; din <= (others => '0'); wait for 100 ns;
   		-- sload
   		start <= '1'; din <= "00000111"; wait for 100 ns;
   		assert (din = 7) report " in sload";
   		assert (count_enable = '1') report " in count_enable";
   		-- counter running for 700 ns
  		sload <= '0'; din <= (others => '0'); wait for 700 ns;
  		assert (count_enable = '0') report " in count_enable reaching 0";
   		report "end of test";
   		wait;
   end process;
end arc_tb_bin2bcd  ;