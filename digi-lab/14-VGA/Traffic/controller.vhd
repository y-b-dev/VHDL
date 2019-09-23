library ieee;
use ieee.std_logic_1164.all;

entity controller is
   port (resetN, clk, reqN: in std_logic;
        req, r1, y1, g1, r2, y2, g2: out std_logic);
end controller;

architecture arc_controller of controller is

    component timer is
        generic (mili_secs: integer := 1000;
                 freq_in_MH: positive := 25;
                 slow_num_of_bits: positive := 5);
        port (resetN, clk, sc: in std_logic;
               t_out: out integer range 0 to 2 ** slow_num_of_bits - 1);
    end component;

    component s_r_ff is
        port (resetN, clk, s, r: in std_logic;
             q: out std_logic);
    end component;

    component traffic_sm is
        generic (start_time: positive := 2;
         stop_time: positive := 4;
         go_secondary_time: positive := 15;
         go_main_time: positive := 30);
        port (resetN, clk, req: in std_logic;
              t_in: in positive;
              r1, y1, g1, r2, y2, g2, sc, ack: out std_logic);
    end component;

    signal req_input_int, req_output_int ,sc, ack: std_logic;
    signal t_int: integer;
 
begin
    req_input_int <= not reqN;

    req <= req_output_int;

    timer_com: timer
    port map(resetN, clk, sc, t_int);

    s_r_ff_com: s_r_ff
    port map(resetN, clk, req_input_int, ack, req_output_int);

    traffic_sm_com: traffic_sm
    port map(resetN, clk, req_output_int, t_int, r1, y1, g1, r2, y2, g2, sc, ack);
end arc_controller;