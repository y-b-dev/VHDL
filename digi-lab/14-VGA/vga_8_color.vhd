library ieee;
use ieee.std_logic_1164.all;

entity vga_8_color is
   port (resetN, clk, din_red, din_green, din_blue: in std_logic;
        horiz_sync: out std_logic;
        vert_sync: out std_logic;
        red: out std_logic_vector(9 downto 0);
        green: out std_logic_vector(9 downto 0);
        blue: out std_logic_vector(9 downto 0);
        vga_blank: out std_logic;
        vga_clk: out std_logic;
        vga_sync: out std_logic);
        end vga_8_color;

architecture arc_vga_8_color of vga_8_color is

    component vgasync is 
        port ( resetN      : in std_logic         ;
        clk         : in std_logic         ;
        sync_h      : out std_logic        ;
        sync_v      : out std_logic        ;
        count_h     : out std_logic_vector ( 9 downto 0 ) ;
        count_v     : out std_logic_vector ( 9 downto 0 ) ;
        frame_end   : out std_logic        ;
        frame_odd   : out std_logic        ;
        video       : out std_logic      ) ;
    end component;

    component t_ff is 
        port ( resetN: in std_logic ;
        clk: in std_logic ;
        q: out std_logic );
    end component;

    component pipe is
        generic (depth: natural := 1);
        port (resetN, clk, din: in std_logic;
            dout: out std_logic);
    end component;
    component dup10 is
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
    end component;
    
    signal clk_int, sync_h_int, sync_v_int: std_logic;
    signal count_h, count_v: std_logic_vector (9 downto 0);
    signal frame_end_int, frame_odd_int, video: std_logic;
begin
	tff_com: t_ff
	port map(resetN, clk, clk_int);
    vgasync_com: vgasync 
    port map(resetN, clk_int, sync_h_int, sync_v_int, open, open, open, open, video);
    pipe_horiz_com: pipe
    port map(resetN, clk_int, sync_h_int, horiz_sync);
    pipe_vert_com: pipe
    port map(resetN, clk_int, sync_v_int, vert_sync);
    dup10_com: dup10
    port map(resetN, clk_int, din_red, din_green, din_blue, video, vga_sync, vga_clk, red, green, blue, vga_blank);
end arc_vga_8_color;