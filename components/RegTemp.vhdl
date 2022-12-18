LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RegTemp IS
  PORT ( 
  data_RegTemp : IN STD_LOGIC_VECTOR(11 downto 0) ;
  RegTemp_Clear, Clock_RegTemp: IN STD_LOGIC ;
  Q_RegTemp : OUT STD_LOGIC_VECTOR(11 downto 0);
  RegTemp_Load : IN BIT
  ) ;
END RegTemp ;

ARCHITECTURE Behavior OF RegTemp IS
SIGNAL p: STD_LOGIC_VECTOR(11 downto 0);
BEGIN
  PROCESS ( RegTemp_Clear, Clock_RegTemp, RegTemp_Load)
  BEGIN
    IF Clock_RegTemp'EVENT AND Clock_RegTemp = '1' AND RegTemp_Clear = '0' THEN
      Q_RegTemp <= "000000000000" ;
	 END IF;
    IF Clock_RegTemp'EVENT AND Clock_RegTemp = '1' AND RegTemp_Load = '1' THEN 
      p <= data_RegTemp;
    END IF ;
	 Q_RegTemp <= P;
  END PROCESS ;
END Behavior ;
