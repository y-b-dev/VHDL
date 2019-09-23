library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity vgasync is 
   port (resetN, clk: in std_logic;
      sync_v, sync_h, frame_end, frame_odd, video: out std_logic;
      count_h, count_v: out std_logic_vector( 9 downto 0 ));
end vgasync ;
architecture arc_vgasync of vgasync is 
   
    constant a    :integer   := 800 ; --scanline pixsels
    constant b    :integer   :=  95 ; --horizontal sync
    constant c    :integer   :=  45 ; --back porch
    constant d    :integer   := 640 ; --video
    constant e    :integer   :=  20 ; --front porch
    constant o    :integer   := 525 ; --frame line
    constant p    :integer   :=   2 ; --vertical sync
    constant q    :integer   :=  32 ; --back porch
    constant r    :integer   := 480 ; --video
    constant s    :integer   :=  11 ; --front porch
    constant pol_h   :std_logic := '0' ;
    constant pol_v   :std_logic := '0' ;
    
    
    signal count_h_int      :integer range 0 to 1023 ;
    signal count_v_int      :integer range 0 to 1023 ;
    signal tc_h,tc_v        :std_logic               ;
    signal ce_v             :std_logic               ;
    signal sync_h_int       :std_logic               ;
    signal sync_v_int       :std_logic               ;
    signal frame_end_int    :std_logic               ;
    signal frame_odd_int    :std_logic               ;
    signal video_int        :std_logic               ;
begin
    
    --Horizontal Counter 
    process  ( resetN ,clk )
    begin
       if resetN = '0' then
          count_h_int <= 0 ;
       elsif  rising_edge(clk) then 
         if tc_h = '1' then --mod 800 counter
            count_h_int <= 0 ;
         else 
            count_h_int <= count_h_int +1 ;
         end if ;  
       end if ;
    end process ;
   
    --Counter loop creator
    tc_h <= '1' when count_h_int = a - 1 else '0'  ;
    --Horizontal sync
    sync_h_int <= '1' when ( d + e <=  count_h_int) and ( count_h_int < d + e + b ) else '0' ;
    --Interconnect bwtween hor & vert counters
    ce_v <= '1' when ( count_h_int = d + e + b/2 ) else '0' ;
 
    --Vertical Counter
    process ( resetN , clk )
    begin
        if resetN = '0' then
           count_v_int <= 0 ;
        elsif rising_edge(clk) then
           if ce_v = '1' then 
              if tc_v = '1' then --mod 525
                 count_v_int <= 0 ;
              else 
                 count_v_int <= count_v_int + 1 ;
              end if ;
           end if ;
        end if ;
    end process ;
    tc_v <= '1' when count_v_int = o -1 else '0' ;
    sync_v_int <= '1' when  ( r + s <= count_v_int ) and ( count_v_int < r + s + p ) else '0' ;

    --Video enable
    video_int <= '1' when ( count_h_int < d ) and ( count_v_int < r ) else '0' ;
    --Last pixle count
    frame_end_int <= '1' when ( count_h_int = d -1 ) and ( count_v_int = r -1 ) else '0' ;

    --Internal frame_odd toggle ff
    process ( clk , resetN ) 
    begin 
        if resetN = '0' then 
           frame_odd_int <= '0' ;
        elsif rising_edge(clk) then 
           frame_odd_int <= frame_end_int xor frame_odd_int ;
        end if ;
    end process ;

    --Output Sync
    process ( clk ,resetN )
    begin 
        if resetN = '0' then 
           sync_h  <= not pol_h      ;
           sync_v  <= not pol_v      ;
           count_v <= ( others => '0' ) ;
           count_h <= ( others => '0' ) ;
           frame_end <= '0'             ;
           frame_odd <= '0'             ;
           video     <= '1'             ;
        elsif rising_edge(clk) then 
           sync_h  <= sync_h_int xor not pol_h   ;
           sync_v  <= sync_v_int xor not pol_v   ;
           count_h <= count_h_int + "0000000000" ;
           count_v <= count_v_int + "0000000000" ;
           frame_end <= frame_end_int            ;
           frame_odd <= frame_odd_int            ;
           video <= video_int                    ;
        end if ;
    end process ;
    end arc_vgasync ;
        
         
    