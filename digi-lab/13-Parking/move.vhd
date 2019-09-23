library ieee ;
use ieee.std_logic_1164.all ;

entity move is
  port (
    resetN, clk, a, b: in std_logic;
    dout: out std_logic
  ) ;
end move ; 

architecture arch of move is
    type state is (idle, front, mid, back, car_in);
    signal p_state, n_state: state;
begin

    sync : process( resetN, clk )
    begin
        if resetN = '0' then
            p_state <= idle;
        elsif rising_edge(clk) then
            p_state <= n_state;
        end if ;
    end process ; -- sync

    comb : process( p_state, a, b )
    begin
        dout <= '0';
        case( p_state ) is
            when idle =>
                if a = '1' and b = '0' then
                    n_state <= front;
                else
                    n_state <= idle;
                end if ;
            when front =>
                if a = '1' and b = '1' then
                    n_state <= mid;
                elsif a = '0' and b = '0' then
                    n_state <= idle;
                else
                    n_state <= front;
                end if ;
            when mid =>
                if a = '0' and b = '1' then
                    n_state <= back;
                elsif a = '1' and b = '0' then
                    n_state <= front;
                else
                    n_state <= mid;
                end if ;
            when back =>
                if a = '0' and b = '0' then
                    n_state <= car_in;
                elsif a = '1' and b = '1' then
                    n_state <= mid;
                else
                    n_state <= back;
                end if ;
            when car_in =>
                    n_state <= idle;
                    dout <= '1';
            when others => n_state <= idle;
        end case ;
        
    end process ; -- comb
end arch ;
