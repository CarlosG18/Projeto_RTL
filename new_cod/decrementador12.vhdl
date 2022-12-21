LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all;

ENTITY decrementador12 IS
  PORT(
   data_decre : IN unsigned(11 downto 0);
    Clock_decre : IN std_logic;
    load : IN std_logic;
    Q_decre : OUT unsigned(11 downto 0)
  );
END decrementador12;

ARCHITECTURE comportamento OF decrementador12 IS
signal load_aux : std_logic;
BEGIN
  load_aux <= load;

  PROCESS (data_decre, Clock_decre, load_aux)
  VARIABLE qv : unsigned(11 downto 0);
  BEGIN
    IF Clock_decre 'EVENT AND Clock_decre = '1' THEN
	    IF load_aux = '1' THEN
	      qv := data_decre;
	    ELSE 
	      IF (qv > 0) THEN 
	      qv := qv - 1;
	      END IF;
	  END IF;
  END IF;

    Q_decre <= qv;
  END PROCESS;
END comportamento;
