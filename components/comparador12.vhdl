LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY comparador12 IS
  PORT ( 
  data_comp : IN STD_LOGIC_VECTOR(11 downto 0) ;
  RegTemp_END_comp : OUT BIT
  ) ;
END comparador12 ;

ARCHITECTURE Behavior OF comparador12 IS
BEGIN
  PROCESS ( data_comp )
  BEGIN
    IF data_comp = "000000000000" THEN
      RegTemp_END_comp  <= '1';
    ELSE
      RegTemp_END_comp <= '0';
    END IF ;
  END PROCESS ;
END Behavior ;
