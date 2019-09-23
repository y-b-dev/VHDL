library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity rescolor is
 
         generic ( width : integer range 1 to 10 := 1 )                     ;
         port    ( resetN       : in std_logic                              ;
                   clk          : in std_logic                              ;
                   din_r        : in std_logic_vector ( width -1 downto 0 ) ;
                   din_g        : in std_logic_vector ( width -1 downto 0 ) ;
                   din_b        : in std_logic_vector ( width -1 downto 0 ) ;
                   ena          : in std_logic                              ;
                   vga_sync     : out std_logic                             ;
                   vga_clk      : out std_logic                             ;
                   dout_r       : out std_logic_vector ( 9 downto 0 )       ;
                   dout_g       : out std_logic_vector ( 9 downto 0 )       ;
                   dout_b       : out std_logic_vector ( 9 downto 0 )       ;
                   vga_blank    : out std_logic                            );
end rescolor ;
architecture arc_rescolor of rescolor is
signal r,g,b :std_logic_vector(width - 1 downto 0 ) ;
begin
   vga_sync <= '0' ;
   vga_clk <= clk  ;
   r <= din_r ; g <= din_g ; b <= din_b ;

   process ( resetN , clk ) 
   begin 
       if resetN = '0' then 
          dout_r <= ( others => '0' ) ;
          dout_g <= ( others => '0' ) ;
          dout_b <= ( others => '0' ) ;
          vga_blank <= '0' ;
       elsif clk'event and clk = '1' then 
          if  width = 1  then
          dout_r <= ( others => '0' ) ;
          dout_g <= ( others => '0' ) ;
          dout_b <= ( others => '0' ) ;
          elsif width = 2 then 
             dout_r <= (r(1),r(0),r(1),r(0),r(1),r(0),r(1),r(0),r(1),r(0)) ;
             dout_g <= (g(1),g(0),g(1),g(0),g(1),g(0),g(1),g(0),g(1),g(0)) ;
             dout_b <= (b(1),b(0),b(1),b(0),b(1),b(0),b(1),b(0),b(1),b(0)) ;
             
          elsif width = 3 then 
             dout_r <= (r(2),r(1),r(0),r(2),r(1),r(0),r(2),r(1),r(0),r(2)) ;
             dout_g <= (g(2),g(1),g(0),g(2),g(1),g(0),g(2),g(1),g(0),g(2)) ;
             dout_b <= (b(2),b(1),b(0),b(2),b(1),b(0),b(2),b(1),b(0),b(2)) ;
             
          elsif width = 4 then 
             dout_r <= (r(3),r(2),r(1),r(0),r(3),r(2),r(1),r(0),r(3),r(2)) ;
             dout_g <= (g(3),g(2),g(1),g(0),g(3),g(2),g(1),g(0),g(3),g(2)) ;
             dout_b <= (b(3),b(2),b(1),b(0),b(3),b(2),b(1),b(0),b(3),b(2)) ;
             
          elsif width = 5 then 
             dout_r <= (r(4),r(3),r(2),r(1),r(0),r(4),r(3),r(2),r(1),r(0)) ;
             dout_g <= (g(4),g(3),g(2),g(1),g(0),g(4),g(3),g(2),g(1),g(0)) ;
             dout_b <= (b(4),b(3),b(2),b(1),b(0),b(4),b(3),b(2),b(1),b(0)) ;
             
          elsif width = 6 then 
             dout_r <= (r(5),r(4),r(3),r(2),r(1),r(0),r(5),r(4),r(3),r(2)) ;
             dout_g <= (g(5),g(4),g(3),g(2),g(1),g(0),g(5),g(4),g(3),g(2)) ;
             dout_b <= (b(5),b(4),b(3),b(2),b(1),b(0),b(5),b(4),b(3),b(2)) ;
             
          elsif width = 7 then 
             dout_r <= (r(6),r(5),r(4),r(3),r(2),r(1),r(0),r(6),r(5),r(4)) ;
             dout_g <= (g(6),g(5),g(4),g(3),g(2),g(1),g(0),g(6),g(5),g(4)) ;
             dout_b <= (b(6),b(5),b(4),b(3),b(2),b(1),b(0),b(6),b(5),b(4)) ;
             
          elsif width = 8 then 
             dout_r <= (r(7),r(6),r(5),r(4),r(3),r(2),r(1),r(0),r(7),r(6)) ;
             dout_g <= (g(7),g(6),g(5),g(4),g(3),g(2),g(1),g(0),g(7),g(6)) ;
             dout_b <= (b(7),b(6),b(5),b(4),b(3),b(2),b(1),b(0),b(7),b(6)) ;
             
          elsif width = 9 then 
             dout_r <= (r(8),r(7),r(6),r(5),r(4),r(3),r(2),r(1),r(0),r(8)) ;
             dout_g <= (g(8),g(7),g(6),g(5),g(4),g(3),g(2),g(1),g(0),g(8)) ;
             dout_b <= (b(8),b(7),b(6),b(5),b(4),b(3),b(2),b(1),b(0),b(8)) ;
          elsif width = 10 then
             dout_r <= r ;
             dout_g <= g ;
             dout_b <= b ;
          end if ;
          vga_blank <= ena ;
        end if ;
      end process ;
end arc_rescolor ;