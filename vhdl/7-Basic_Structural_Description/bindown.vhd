library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity bindown is
   port (sload, clk, resetN: in  std_logic;
   		 bin: in  std_logic_vector(7 downto 0);
         count_enable: out std_logic);
end bindown ;
architecture arc_bindown of bindown is
	signal count : integer range 0 to 255;
begin
    process ( clk , resetN )
    begin
       if resetN = '0' then
         count <= 0;
       elsif rising_edge(clk) then
          if sload = '1' then
          	count <= conv_integer(bin);
          elsif count > 0 then
          	count <= count-1;
          end if;
       end if;
    end process;
    count_enable <= '0' when count=0 else '1';
end arc_bindown;