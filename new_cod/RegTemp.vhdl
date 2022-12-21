LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all;

ENTITY Reg_showtime IS
  PORT ( 
    data_Reg_showtime : IN unsigned(12 downto 0);
    reg_showtime_clear, Clock_Reg_showtime: IN std_logic;  
    Q_Reg_showtime : OUT unsigned(12 downto 0);
    reg_showtime_load : IN std_logic
  ) ;
END RegTemp ;

ARCHITECTURE Behavior OF reg_showtime IS
SIGNAL p: unsigned(12 downto 0);
BEGIN
  PROCESS ( reg_showtime_clear, Clock_Reg_showtime, reg_showtime_load)
  BEGIN
    IF Clock_Reg_showtime'EVENT AND Clock_Reg_showtime = '1' AND reg_showtime_clear = '1' THEN
      p <= 0;
    ELSIF Clock_Reg_showtime'EVENT AND Clock_Reg_showtime = '1' AND reg_showtime_load = '1' THEN 
      p <= data_Reg_showtime;
    END IF ;
	 Q_Reg_showtime <= p;
  END PROCESS ;
END Behavior ;
