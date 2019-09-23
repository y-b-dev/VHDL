library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bin2bcd  is
   port (start, clk, resetN: in  std_logic;
   		 din: in std_logic_vector(7 downto 0);
   		 dout_high, dout_mid, dout_low: out std_logic_vector(3 downto 0);
         ready: out std_logic);
end bin2bcd  ;
architecture arc_bin2bcd  of bin2bcd  is
	component bindown
      port (sload, clk, resetN: in  std_logic;
   		 bin: in  std_logic_vector(7 downto 0);
         count_enable: out std_logic);
    end component;
    component bcdup
      port (sclear, clk, resetN, cep, cet : in  std_logic;
          tc           : out std_logic; 
          qout : buffer integer range 0 to 9);
    end component;
	signal tc1, tc2, count_enable: std_logic;
begin
	l1: bindown port map (start, clk, resetN, din, count_enable);
	l2: BCD_UP port map (start, clk, resetN, count_enable, tc2, open, dout_high);
	l3: BCD_UP port map (start, clk, resetN, count_enable, tc1, tc2, dout_mid);
	l4: BCD_UP port map (start, clk, resetN, count_enable, '1', tc1, dout_low);
	ready <= not count_enable;
end arc_bin2bcd  ;