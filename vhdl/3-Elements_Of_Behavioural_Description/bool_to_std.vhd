library ieee ;
use ieee.std_logic_1164.all ;

entity bool_to_std is
  port (
    in_bool : in boolean;
    out_stdLogic : out std_logic
  ) ;
end bool_to_std ;

architecture arch_bool_to_std of bool_to_std is
begin

    out_stdLogic <= '1' when in_bool = true else '0';

end architecture ; 