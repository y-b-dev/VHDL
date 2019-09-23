library ieee;
use ieee.std_logic_1164.all;
entity mealy_serial_adder is
   port (a, b, resetN, clk: in std_logic;
         s: out std_logic);
end mealy_serial_adder;
architecture arc_mealy_serial_adder of mealy_serial_adder is
   type state is (carry, nocarry);
   signal present_state: state;
begin
	process (clk , resetN)
	begin
		if resetN = '0' then
         	present_state <= nocarry;
         	s <= '0';
       	elsif rising_edge(clk) then
       		case present_state is
       			when nocarry =>
       				present_state <= nocarry;
       				if a = '1' then
       					if b = '1' then
       						s <= '0';
       						present_state <= carry;
       					else
       						s <= '1';
       					end if;
       				else
       					if b = '1' then
       						s <= '1';
       					else
       						s <= '0';
       					end if;
       				end if;
       			when carry =>
       				present_state <= carry;
       				if a = '1' then
       					if b = '1' then
       						s <= '1';    						
       					else
       						s <= '0';
       					end if;
       				else
       					if b = '1' then
       						s <= '0';
       					else
       						s <= '1';
       						present_state <= nocarry;
       					end if;
       				end if;
       		end case;
   		end if;
    end process;
end arc_mealy_serial_adder ;