LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY decrementador12 IS
  PORT(
   data_decre : IN INTEGER RANGE 3599 DOWNTO 0;
   --data_decre : IN STD_LOGIC_VECTOR(11 downto 0) ;
    Clock_decre : IN BIT;
    tc : OUT BIT;
    load : IN BIT;
    --Q_decre : OUT STD_LOGIC_VECTOR(11 downto 0)
    Q_decre : OUT INTEGER RANGE 3599 DOWNTO 0
  );
END decrementador12;

ARCHITECTURE comportamento OF decrementador12 IS
BEGIN
  PROCESS (data_decre, Clock_decre, load)
  VARIABLE qv : INTEGER RANGE 3599 DOWNTO 0;
  VARIABLE cont : bit := '0';
  BEGIN

    IF Clock_decre 'EVENT AND Clock_decre = '1' THEN
	IF load = '1' and bit = '0' THEN
	  qv := data_decre;
	  bit <= '1';
	ELSE 
	  IF (qv > 0) THEN 
	    qv := qv - 1;
      ELSIF qv = 0 THEN
	    tc <= '1';
	    ELSE
	    tc <= '0';
	  END IF;
	END IF;
    END IF;

    Q_decre <= qv;
  END PROCESS;
END comportamento;
