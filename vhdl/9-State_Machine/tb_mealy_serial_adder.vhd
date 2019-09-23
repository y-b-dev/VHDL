library ieee;
use ieee.std_logic_1164.all;
entity tb_mealy_serial_adder is
end tb_mealy_serial_adder;
architecture arc_tb_mealy_serial_adder of tb_mealy_serial_adder is
   component mealy_serial_adder
      port (a, b, resetN, clk: in std_logic;
         s: out std_logic);
   end component ;
   signal a, b, resetN, clk, s: std_logic;
begin
   eut: mealy_serial_adder port map (a, b, resetN, clk, s);
   resetN <= '0' , '1' after 100 ns ;
   process
   begin
      clk <= '0' ;  wait for 50 ns;
      clk <= '1' ;  wait for 50 ns;
   end process;
   process
   begin
      a <= '0'; b <= '0'; wait for 100 ns;
      a <= '1'; b <= '0'; wait for 100 ns;
      assert (s = '1') report " in adding with no carry";
      a <= '1'; b <= '1'; wait for 100 ns;
      assert (s = '0') report " in adding with no carry";
      a <= '1'; b <= '1'; wait for 100 ns;
      assert (s = '1') report " in adding with carry";
      a <= '0'; b <= '1'; wait for 100 ns;
      assert (s = '0') report " in adding with carry";
   report "end of test"; wait;
   end process;
end arc_tb_mealy_serial_adder;