-- a simple movelate file in VHDL
-- more useful info in my VHDL book or www.amos.eguru-il.com
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity dup10 is
   port ( resetN           : in std_logic                  ;
          clk              : in std_logic                  ;
          din_r            : in std_logic                  ;
          din_g            : in std_logic                  ;
          din_b            : in std_logic                  ;
          ena              : in std_logic                  ;
          vga_sync         : out std_logic                 ;
          vga_clk          : out std_logic                 ;
          dout_r           : out std_logic_vector ( 9 downto 0 ) ;
          dout_g           : out std_logic_vector ( 9 downto 0 ) ;
          dout_b           : out std_logic_vector ( 9 downto 0 ) ;
          vga_blank        : out std_logic                     ) ;
end dup10 ;
architecture arc_dup10 of dup10 is 
begin
   vga_sync <= '0' ;
   vga_clk  <= clk ;
   process ( resetN , clk ) 
   begin
       if resetN = '0' then
          dout_r <= ( others => '0' ) ;
          dout_g <= ( others => '0' ) ;
          dout_b <= ( others => '0' ) ;
          vga_blank <= '0' ;
       elsif rising_edge(clk) then
          dout_r <= ( others => din_r ) ;
          dout_g <= ( others => din_g ) ;
          dout_b <= ( others => din_b ) ;
          vga_blank <= ena ;
      end if ;
   end process ;
end arc_dup10 ; 