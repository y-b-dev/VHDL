-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Sun Oct 07 16:32:56 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY parking IS 
	PORT
	(
		resetN :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		aN :  IN  STD_LOGIC;
		bN :  IN  STD_LOGIC;
		aout :  OUT  STD_LOGIC;
		bout :  OUT  STD_LOGIC;
		hex0s :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex1s :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END parking;

ARCHITECTURE bdf_type OF parking IS 

COMPONENT counter
	PORT(resetN : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 up : IN STD_LOGIC;
		 down : IN STD_LOGIC;
		 count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT move
	PORT(resetN : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 a : IN STD_LOGIC;
		 b : IN STD_LOGIC;
		 dout : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT hexss
	PORT(din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ss : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a :  STD_LOGIC;
SIGNAL	b :  STD_LOGIC;
SIGNAL	count :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;


BEGIN 



b2v_car_counter : counter
PORT MAP(resetN => resetN,
		 clk => clk,
		 up => SYNTHESIZED_WIRE_0,
		 down => SYNTHESIZED_WIRE_1,
		 count => count);


b2v_enter_detect : move
PORT MAP(resetN => resetN,
		 clk => clk,
		 a => a,
		 b => b,
		 dout => SYNTHESIZED_WIRE_0);


b2v_exit_detect : move
PORT MAP(resetN => resetN,
		 clk => clk,
		 a => b,
		 b => a,
		 dout => SYNTHESIZED_WIRE_1);


b2v_high_hexss : hexss
PORT MAP(din => count(7 DOWNTO 4),
		 ss => hex1s);


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	a <= SYNTHESIZED_WIRE_2;
END IF;
END PROCESS;


PROCESS(clk)
BEGIN
IF (RISING_EDGE(clk)) THEN
	b <= SYNTHESIZED_WIRE_3;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_3 <= NOT(bN);



SYNTHESIZED_WIRE_2 <= NOT(aN);



b2v_low_hexss : hexss
PORT MAP(din => count(3 DOWNTO 0),
		 ss => hex0s);

aout <= a;
bout <= b;

END bdf_type;