LIBRARY ieee ;                        
USE ieee.std_logic_1164.all ;

ENTITY RegEstados IS                   
PORT (                        
  data_estados : IN STD_LOGIC_VECTOR(2 downto 0);
  RegEstados_C, Clock_estados: IN STD_LOGIC ;
  RegEstados_L : IN BIT
  Q_estados : OUT STD_LOGIC_VECTOR(2 downto 0);
  ) ;
END RegEstados;                             

ARCHITECTURE Behavior OF RegEstados IS 
BEGIN                               
  PROCESS ( RegEstados_C, Clock_estados, RegEstados_L)
  BEGIN
    IF RegEstados_C = '0' THEN
      Q <= "000" ;
    ELSIF Clock_estados 'EVENT AND Clock_estados = '1' AND RegEstados_L = '1' THEN 
      Q <= data_estados;
    END IF ;
  END PROCESS ;
END Behavior ;
