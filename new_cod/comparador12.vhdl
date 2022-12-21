LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all;

ENTITY comparador12 IS
  PORT ( 
    data_comp : IN unsigned(12 downto 0);
    Reg_showtime_END_comp : OUT std_logic
  ) ;
END comparador12 ;

ARCHITECTURE Behavior OF comparador12 IS
BEGIN
  PROCESS ( data_comp )
  BEGIN
    IF data_comp = 0 THEN
      Reg_showtime_END_comp <= '1';
    ELSE
      Reg_showtime_END_comp <= '0';
    END IF ;
  END PROCESS ;
END Behavior ;
