library ieee;
use ieee.std_logic_1164.all;

entity vga_auto_color_change is
   generic (bit_resolution: integer range 1 to 10 := 1;
        change_time_ms: integer := 500);
   port (resetN, clk: in std_logic;
        horiz_sync: out std_logic;
        vert_sync: out std_logic;
        red: out std_logic_vector(9 downto 0);
        green: out std_logic_vector(9 downto 0);
        blue: out std_logic_vector(9 downto 0);
        vga_blank: out std_logic;
        vga_clk: out std_logic;
        vga_sync: out std_logic);
end vga_auto_color_change;

architecture arc_vga_auto_color_change of vga_auto_color_change is

    component vgasync is 
        port ( resetN      : in std_logic  ;
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

    component mili_sec_gen is
        generic (mil_sec: integer := 1000;
            freq: positive := 50);
        port (resetN, clk: in std_logic;
               ms_sec_gen: out std_logic);
    end component;

    component c_counter is
        generic (width: positive := 3);
        port (resetN, clk: in std_logic;
            dout: out std_logic_vector(width-1 downto 0));
    end component;

    component reg_ena is
        generic (width: natural := 3);
        port (resetN, clk, ena: in std_logic;
                din: in std_logic_vector(width-1 downto 0);
             dout: out std_logic_vector(width-1 downto 0));
    end component;

    component rescolor is
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
    end component ;

    signal clk_int, sync_h_int, sync_v_int, int_secgen: std_logic;
    signal count_h, count_v: std_logic_vector (9 downto 0);
    signal frame_end_int, frame_odd_int, video: std_logic;
    signal counter_out, reg_out: std_logic_vector (bit_resolution * 3 - 1 downto 0);
    constant red_start: integer := 0;
    constant red_end: integer := bit_resolution - 1;
    constant green_start: integer := bit_resolution;
    constant green_end: integer := bit_resolution * 2 - 1;
    constant blue_start: integer := bit_resolution * 2;
    constant blue_end: integer := bit_resolution * 3 - 1;

begin

	tff_com: t_ff
    port map(resetN, clk, clk_int);

    vgasync_com: vgasync 
    port map(resetN, clk_int, sync_h_int, sync_v_int, open, open, frame_end_int, open, video);

    mili_sec_gen_com: mili_sec_gen
    generic map(change_time_ms)
    port map(resetN, clk, int_secgen);

    c_counter_com: c_counter
    generic map(bit_resolution * 3)
    port map(resetN, int_secgen, counter_out);
    
    reg_ena_com: reg_ena
    generic map(bit_resolution * 3)
    port map(resetN, clk_int, frame_end_int, counter_out, reg_out);

    pipe_horiz_com: pipe
    port map(resetN, clk_int, sync_h_int, horiz_sync);

    pipe_vert_com: pipe
    port map(resetN, clk_int, sync_v_int, vert_sync);

    rescolor_com: rescolor
    generic map(bit_resolution)
    port map(resetN, clk_int, reg_out(red_end downto red_start), reg_out(green_end downto green_start), reg_out(blue_end downto blue_start), video, vga_sync, vga_clk, red, green, blue, vga_blank);
    
end arc_vga_auto_color_change;