library ieee;
use ieee.std_logic_1164.all;
entity vpipe is
   generic (depth: natural := 1;
   			width: positive := 1);
   port (resetN, clk: in std_logic;
   		din: in std_logic_vector(width-1 downto 0);
        dout: out std_logic_vector(width-1 downto 0));
end vpipe;
architecture arc_vpipe of vpipe is
	component pipe is 
		generic (depth: natural := 1);
   		port (resetN, clk, din: in std_logic;
        dout: out std_logic);
    end component;
begin
	ui: for i in 0 to (width-1) generate
		u0: pipe generic map(depth) 
			port map(resetN, clk, din(i), dout(i));
	end generate;
end arc_vpipe;