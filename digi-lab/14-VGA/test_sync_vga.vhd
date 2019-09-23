library ieee;
use ieee.std_logic_1164.all;

entity test_sync_vga is
   port (resetN, clk: in std_logic;
        horiz_sync: out std_logic;
        vert_sync: out std_logic;
        red: out std_logic_vector(9 downto 0);
        green: out std_logic_vector(9 downto 0);
        blue: out std_logic_vector(9 downto 0);
        vga_blank: out std_logic;
        vga_clk: out std_logic;
        vga_sync: out std_logic);
end test_sync_vga;

architecture arc_test_sync_vga of test_sync_vga is

    component vga_auto_color_change is
        generic (bit_resolution: integer range 1 to 10 := 2;
        change_time_ms: integer := 200);
        port (resetN, clk: in std_logic;
             horiz_sync: out std_logic;
             vert_sync: out std_logic;
             red: out std_logic_vector(9 downto 0);
             green: out std_logic_vector(9 downto 0);
             blue: out std_logic_vector(9 downto 0);
             vga_blank: out std_logic;
             vga_clk: out std_logic;
             vga_sync: out std_logic);
    end component;
 
begin

    vga_auto_color_change_com: vga_auto_color_change 
    port map(resetN, clk, horiz_sync, vert_sync, red, green, blue, vga_blank, vga_clk, vga_sync);
    
end arc_test_sync_vga;