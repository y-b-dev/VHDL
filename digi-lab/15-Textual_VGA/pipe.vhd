library ieee;
use ieee.std_logic_1164.all;

entity pipe is
   generic (depth: positive := 1);
   port (resetN, clk, din: in std_logic;
        dout: out std_logic);
end pipe;

architecture arc_pipe of pipe is

	component dffx is 
		port (resetN, clk, d: in std_logic;
        q: out std_logic);
	end component;
	
	signal d: std_logic_vector(depth downto 0);
	
begin
	u0: if (depth = 0) generate
		dout <= din;
	end generate;
	gen: if (depth > 0) generate
		d(depth) <= din;
	    ui: for i in 0 to (depth-1) generate
	    	u1: dffx port map(resetN, clk, d(i+1), d(i));
	    end generate;
	    dout <= d(0);
	end generate;
end arc_pipe;