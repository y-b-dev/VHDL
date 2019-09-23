library ieee;
use ieee.std_logic_1164.all;

entity traffic_sm is
   generic (start_time: positive := 2;
	stop_time: positive := 4;
	go_secondary_time: positive := 15;
	go_main_time: positive := 30);
   port (resetN, clk, req: in std_logic;
		 t_in: in positive;
         r1, y1, g1, r2, y2, g2, sc, ack: out std_logic);
end traffic_sm ;

architecture arc_traffic_sm of traffic_sm is

   subtype state is std_logic_vector(2 downto 0);

   constant go_main: state := "000";
   constant stop_main: state := "001";
   constant start_secondary: state := "010";
   constant go_secondary: state := "011"; 
   constant stop_secondary: state := "100";
   constant start_main: state := "101";

   signal present_state, next_state: state;

   type state_n is (go_main_n, stop_main_n, start_secondary_n,
   			go_secondary_n, stop_secondary_n, start_main_n, bad);
   signal present_state_n: state_n;

begin
	process (clk , resetN)
	begin
		if resetN = '0' then
         	present_state <= go_main;
			next_state <= go_main;

			r1 <= '0';
			r2 <= '0';
			y1 <= '0';
			y2 <= '0';
			g1 <= '0';
			g2 <= '0';
			sc <= '0';
			ack <= '0';

       	elsif rising_edge(clk) then
       	 	present_state <= next_state;
	
			r1 <= '0';
			r2 <= '0';
			y1 <= '0';
			y2 <= '0';
			g1 <= '0';
			g2 <= '0';
			sc <= '0';
			ack <= '0';

		    case present_state is
			
       			when go_main => 
       				if req = '1' and t_in > go_main_time - 1 then
						next_state <= stop_main;			
						sc <= '1';			   
					end if;
					g1 <= '1';
					r2 <= '1';

       			when stop_main => 
       				if t_in = stop_time then
						next_state <= start_secondary;
					end if;
					y1 <= '1';
					r2 <= '1';
					
       			when start_secondary => 
       				if t_in = stop_time + start_time then
					   next_state <= go_secondary;
					end if;
					r1 <= '1';
				    r2 <= '1';
					y2 <= '1';
					
       			when go_secondary => 
       				if t_in = stop_time + start_time + go_secondary_time then
						next_state <= stop_secondary;
					end if;
					r1 <= '1';
					g2 <= '1';
					
       			when stop_secondary => 
       				if t_in = stop_time + start_time + go_secondary_time + stop_time then
						next_state <= start_main;
						ack <= '1';
					end if;
					r1 <= '1';
					y2 <= '1';
					
       			when start_main => 
       				if t_in = stop_time + start_time + go_secondary_time + stop_time + start_time then
						next_state <= go_main;
						sc <= '1';
					end if;
					r1 <= '1';
					r2 <= '1';
					y2 <= '1';
					
				when others => next_state <= stop_secondary;
			   
		    end case;
		end if;
	end process;
	
	process (present_state)
    begin
    	case present_state is
    		when go_main => present_state_n <= go_main_n;
    		when stop_main => present_state_n <= stop_main_n;
    		when start_secondary => present_state_n <= start_secondary_n;
    		when go_secondary => present_state_n <= go_secondary_n;
    		when stop_secondary => present_state_n <= stop_secondary_n;
    		when start_main => present_state_n <= start_main_n;
    		when others => present_state_n <= bad;
    	end case;
    end process;

end arc_traffic_sm ;