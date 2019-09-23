library ieee;
use ieee.std_logic_1164.all;

entity text_gen is
   port (clk: in std_logic;
        count_v, count_h: in std_logic_vector(9 downto 0);
        char_code: out std_logic_vector(5 downto 0);
        pos_pix_h, pos_pix_v: out std_logic_vector(2 downto 0));
end text_gen;

architecture arc_text_gen of text_gen is 

    type charbox_letter is std_logic_vector(5 downto 0); 
    constant T: charbox_letter := "011101";
    constant H: charbox_letter := "010001";
    constant E: charbox_letter := "001110";
    constant space: charbox_letter := "110000";
    constant U: charbox_letter := "011110";
    constant P: charbox_letter := "011001";
    constant minus: charbox_letter := "101110";
    constant one: charbox_letter := "000001";
    constant I: charbox_letter := "010010";
    constant S: charbox_letter := "011100";
    constant F: charbox_letter := "001111";
    constant N: charbox_letter := "010111";
    constant exclamation: charbox_letter := "100101";

    signal char_code_int: charbox_letter;
    signal pos_pix_h_int, pos_pix_v_int: std_logic_vector(2 downto 0); --3 bit/8 pix
    signal pos_char_h_int, pos_char_v_int: std_logic_vector(6 downto 0); --7 bit/max 80 for columns, 60 for lines

begin
    
    -- Low bits are the column of the pixel in the character box 
    pos_pix_h_int <= count_h(2 downto 0);
    -- High bits are the column of the text on the screen 
    pos_char_h_int <= count_h(9 downto 3);
    -- Low bits are the line of the pixel in the character box 
    pos_pix_v_int <= count_v(2 downto 0);
    -- High bits are the line of the text on the screen 
    pos_char_v_int <= count_v(9 downto 3);

    text_generation : process(pos_char_h_int, pos_char_v_int)
    begin
        case conv_integer(pos_char_v_int) is 

            when 0 => -- Line 0
                case conv_integer(pos_char_h_int) is

                    when 0 => 
                        char_code_int <= T;
                    when 1 => 
                        char_code_int <= H;
                    when 2 => 
                        char_code_int <= E;
                    when 3 => 
                        char_code_int <= space;
                    when 4 => 
                        char_code_int <= U;
                    when 5 => 
                        char_code_int <= P; 
                    when 6 => 
                        char_code_int <= minus; 
                    when 7 => 
                        char_code_int <= one;
                    when others => 
                        char_code_int <= space; 
                end case;

            when 2 => -- Line 2
                case conv_integer(pos_char_h_int) is

                    when 0 => 
                        char_code_int <= I;
                    when 1 => 
                        char_code_int <= S;
                    when 2 => 
                        char_code_int <= space;
                    when 3 => 
                        char_code_int <= F;
                    when 4 => 
                        char_code_int <= U;
                    when 5 => 
                        char_code_int <= N; 
                    when 6 => 
                        char_code_int <= space; 
                    when 7 => 
                        char_code_int <= exclamation;
                    when others => 
                        char_code_int <= space; 
                end case;    

        end case;
    end process; -- text_generation

    process (clk)
    begin
        if rising_edge(clk) then
            char_code <= char_code;
            pos_pix_h <= pos_pix_h_int;
            pos_pix_v <= pos_pix_v_int;
        end if;
    end process; 

end arc_text_gen; 