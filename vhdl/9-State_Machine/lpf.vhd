library ieee;
use ieee.std_logic_1164.all;
entity lpf is
   port (din, enable, resetN, clk: in std_logic;
         dout: out std_logic);
end lpf ;
architecture arc_lpf of lpf is
   subtype state is std_logic_vector(2 downto 0);
   constant low: state := "000";
   constant l2h1: state := "001";
   constant l2h2: state := "010";
   constant l2h3: state := "011";
   constant high: state := "100"; 
   constant h2l1: state := "101";
   constant h2l2: state := "110";
   constant h2l3: state := "111";
   signal present_state, next_state: state;
   type state_n is (low_n, l2h1_n, l2h2_n, l2h3_n,
   			high_n, h2l1_n, h2l2_n, h2l3_n, bad);
   signal present_state_n: state_n;
begin
	process (clk , resetN)
	begin
		if resetN = '0' then
         	present_state <= low;
         	next_state <= low;
       	elsif rising_edge(clk) then
       		if enable = '1' then
       	 		present_state <= next_state;
       	 	end if;
       	end if;
       	case present_state is
       		when low => 
       			if din = '1' then
       				next_state <= l2h1;
       			end if;
       		when l2h1 => 
       			if din = '1' then
       				next_state <= l2h2;
       			end if;
       		when l2h2 => 
       			if din = '1' then
       				next_state <= l2h3;
       			end if;
       		when l2h3 => 
       			if din = '1' then
       				next_state <= high;
       			end if;
       		when high => 
       			if din = '0' then
       				next_state <= h2l1;
       			end if;
       		when h2l1 => 
       			if din = '0' then
       				next_state <= h2l2;
       			end if;
       		when h2l2 => 
       			if din = '0' then
       				next_state <= h2l3;
       			end if;
       		when h2l3 => 
       			if din = '0' then
       				next_state <= low;
       			end if;
       		when others => next_state <= low;
       	  end case;
    end process;
    dout <= next_state(2);
    process (present_state)
    begin
    	case present_state is
    		when low => present_state_n <= low_n;
    		when l2h1 => present_state_n <= l2h1_n;
    		when l2h2 => present_state_n <= l2h2_n;
    		when l2h3 => present_state_n <= l2h3_n;
    		when high => present_state_n <= high_n;
    		when h2l1 => present_state_n <= h2l1_n;
    		when h2l2 => present_state_n <= h2l2_n;
    		when h2l3 => present_state_n <= h2l3_n;
    		when others => present_state_n <= bad;
    	end case;
    end process;
end arc_lpf ;