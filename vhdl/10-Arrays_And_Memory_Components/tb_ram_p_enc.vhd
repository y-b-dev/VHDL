library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_ram_p_enc is
end tb_ram_p_enc;
architecture arc_tb_ram_p_enc of tb_ram_p_enc is
   component ram_p_enc
        port (clk, we, polarity: in std_logic;
            din, write_address: in std_logic_vector(3 downto 0);
            data: in std_logic_vector(1 downto 0);
            dout: out std_logic_vector(1 downto 0));
   end component;
   signal clk, we, polarity: std_logic;
   signal din, write_address: std_logic_vector(3 downto 0);
   signal data, dout: std_logic_vector(1 downto 0);
begin
   eut: ram_p_enc port map(clk, we, polarity, din, write_address, data, dout);
   process
   begin
      clk <= '0'; wait for 50 ns;
      clk <= '1'; wait for 50 ns;
   end process;
   process
   begin
    polarity <= '0'; we <= '0'; write_address <= "0000"; data <= "10"; din <= "0001"; wait for 100 ns;
    assert(dout = "00") report " in priority encoding";
    din <= "0101"; wait for 100 ns;
    assert(dout = "10") report " in priority encoding";
    din <= "1001"; wait for 100 ns;
    assert(dout = "11") report " in priority encoding";
    we <= '1'; din <= "0000"; wait for 100 ns;
    assert(dout = "10") report " in writing";
    polarity <= '1'; wait for 100 ns;
    assert(dout = "01") report " in polarity";
    report "end of test";
    wait;
   end process;
end arc_tb_ram_p_enc ;