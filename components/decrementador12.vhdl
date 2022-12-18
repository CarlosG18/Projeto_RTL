LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY decrementador12 IS
  PORT(
    data_decre : IN INTEGER RANGE 3599 DOWNTO 0;
    Clock_decre : IN BIT;
    tc : OUT BIT;
    load : IN BIT;
    Q_decre : OUT INTEGER RANGE 3599 DOWNTO 0
  );
END decrementador12;

ARCHITECTURE comportamento OF decrementador12 IS
BEGIN
  PROCESS (data_decre, Clock_decre, load)
  VARIABLE qv : INTEGER RANGE 3599 DOWNTO 0;
  BEGIN

    IF Clock_decre 'EVENT AND Clock_decre = '1'AND load = '1' THEN
	qv := data_decre;
	IF Clock_decre 'EVENT AND Clock_decre = '1' THEN
	  qv := qv - 1;
	END IF;
    END IF;

    IF Clock_decre 'EVENT AND Clock_decre = '1' AND qv = 0 THEN
      tc <= '1';
    END IF;

    Q_decre <= qv;
  END PROCESS;
END comportamento;
