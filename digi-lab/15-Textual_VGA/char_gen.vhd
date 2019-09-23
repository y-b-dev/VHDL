-- 64 X 8 X 8 Character generator 
-- [64 characters X 8 pixels X 8 pixels] X 1 = 4096 X 1 ROM table 
-- Using 1 M4K (out of 105) to implement this ROM table (LPM_ROM) => each unit is a 4k memory unit 

library ieee;
library lpm;
use ieee.std_logic_1164.all;
use lpm.lpm_components.all;

entity char_gen is
   port (clk: in std_logic;
        char_code: out std_logic_vector(5 downto 0);
        pos_pix_v, pos_pix_h: out std_logic_vector(2 downto 0)
        dout: out std_logic);
end char_gen;

architecture arc_char_gen of char_gen is 

    signal rom_address_int: std_logic_vector(11 downto 0); 
    signal rom_data_int: std_logic_vector(0 downto 0); 

begin
    rom_address_int <= char_code & pos_pix_v & pos_pix_h;

    rom: LPM_ROM
    generic map (
        lpm_widthad => 12, -- address width
        lpm_numwords => 4096, -- length = 2**lpm_widthad
        lpm_outdata => "REGISTERED", -- registered outputs
        lpm_address_control => "UNREGISTERED", -- combinatorial inputs
        lpm_file => "char_gen_8.mif", -- ROM code file name
        lpm_width => 1)
    port map (
        address => rom_address_int,
        outclock => clk,
        q => rom_data_int)

    dout <= rom_data_int(0);
end arc_char_gen; 