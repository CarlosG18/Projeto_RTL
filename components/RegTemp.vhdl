LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RegTemp IS
  PORT ( 
  data_RegTemp : IN INTEGER RANGE 3599 DOWNTO 0;
  RegTemp_Clear, Clock_RegTemp: IN BIT;
  Q_RegTemp : OUT INTEGER RANGE 3599 DOWNTO 0;
  RegTemp_Load : IN BIT
  ) ;
END RegTemp ;

ARCHITECTURE Behavior OF RegTemp IS
SIGNAL p: INTEGER RANGE 3599 DOWNTO 0;
BEGIN
  PROCESS ( RegTemp_Clear, Clock_RegTemp, RegTemp_Load)
  BEGIN
    IF Clock_RegTemp'EVENT AND Clock_RegTemp = '1' AND RegTemp_Clear = '1' THEN
      p <= 0;
    ELSIF Clock_RegTemp'EVENT AND Clock_RegTemp = '1' AND RegTemp_Load = '1' THEN 
      p <= data_RegTemp;
    END IF ;
	 Q_RegTemp <= p;
  END PROCESS ;
END Behavior ;
