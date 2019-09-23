library ieee;
use ieee.std_logic_1164.all;

entity test_traffic is
   port (resetN, clk, reqN: in std_logic;
        horiz_sync, vert_sync, vga_sync, vga_clk, vga_blank, req: out std_logic;
        red, green, blue: out std_logic_vector(9 downto 0));
end test_traffic;

architecture arc_test_traffic of test_traffic is

    component t_ff is 
        port ( resetN: in std_logic ;
            clk: in std_logic ;
            q: out std_logic );
    end component;

    component vgasync is 
        port (resetN, clk: in std_logic;
        sync_h, sync_v, frame_end, frame_odd, video: out std_logic;
        count_h, count_v: out std_logic_vector( 9 downto 0 ));
    end component;

    component pipe is
        generic (depth: positive := 1);
        port (resetN, clk, din: in std_logic;
            dout: out std_logic);
    end component;

    component controller is
        port (resetN, clk, reqN: in std_logic;
             req, r1, y1, g1, r2, y2, g2: out std_logic);
    end component;

    component traffic_lights is
        port (r1, y1, g1, r2, y2, g2: in std_logic;
             count_h, count_v: in std_logic_vector(9 downto 0);
             red, green, blue: out std_logic);
    end component;

    component dup10 is
        port (resetN ,clk, din_r, din_g, din_b, ena: in std_logic; 
         vga_sync, vga_clk, vga_blank: out std_logic;
         dout_r, dout_g, dout_b: out std_logic_vector (9 downto 0));
    end component;

    signal clk_int, sync_h_int, sync_v_int, video, r1, y1, g1, r2, y2, g2, r,  g, b: std_logic;
    signal count_h, count_v: std_logic_vector (9 downto 0);
 
begin
    tff_com: t_ff
    port map(resetN, clk, clk_int);

    vgasync_com: vgasync 
    port map(resetN, clk_int, sync_h_int, sync_v_int, open, open, video, count_h, count_v);

    pipe_horiz_com: pipe
    port map(resetN, clk_int, sync_h_int, horiz_sync);

    pipe_vert_com: pipe
    port map(resetN, clk_int, sync_v_int, vert_sync);

    controller_com: controller
    port map(resetN, clk_int, reqN, req, r1, y1, g1, r2, y2, g2);

    traffic_lights_com: traffic_lights
    port map(r1, y1, g1, r2, y2, g2, count_h, count_v, r,  g, b);

    dup10_com: dup10
    port map(resetN, clk_int, r, g, b, video, vga_sync, vga_clk, vga_blank, red, green, blue);
end arc_test_traffic;