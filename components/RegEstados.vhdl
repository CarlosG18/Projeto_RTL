LIBRARY ieee ;                        
USE ieee.std_logic_1164.all ;

ENTITY RegEstados IS                   
PORT (                        
  data_estados : IN STD_LOGIC_VECTOR(2 downto 0);
  Clock_estados: IN STD_LOGIC ;
  Q_estados : OUT STD_LOGIC_VECTOR(2 downto 0)
  ) ;
END RegEstados;                             

ARCHITECTURE Behavior OF RegEstados IS 
signal p: STD_LOGIC_VECTOR(2 downto 0);
BEGIN                               
  PROCESS (Clock_estados)
  BEGIN
    IF Clock_estados 'EVENT AND Clock_estados = '1' THEN
      Q_estados <= "000" ;
	 END IF;
    IF Clock_estados 'EVENT AND Clock_estados = '1' THEN 
      p <= data_estados;
    END IF ;
	 Q_estados <= p;
	 
  END PROCESS ;
END Behavior ;
