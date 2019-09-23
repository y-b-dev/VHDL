library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.pkg_rom_p_enc.all;
entity ram_p_enc is
   port (clk, we, polarity: in std_logic;
        din, write_address: in std_logic_vector(3 downto 0);
        data: in std_logic_vector(1 downto 0);
        dout: out std_logic_vector(1 downto 0));
end ram_p_enc;
architecture arc_ram_p_enc of ram_p_enc is
    signal ram: mem_rom := rom;
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (we = '1') then
                if (polarity = '0') then
                    ram(conv_integer(write_address)) <= data;
                else 
                    ram(conv_integer(write_address)) <= not data;
                end if;
            end if;
        end if;
    end process;
    dout <= ram(conv_integer(din));
end arc_ram_p_enc;