LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY main IS
  PORT ( 
  --data_Time : IN STD_LOGIC_VECTOR(11 downto 0) ;
  data_Time : IN INTEGER RANGE 3599 DOWNTO 0;
  BtnTime : IN BIT;
  BtnOn : IN BIT;
  CDoor : IN BIT;
  Clock : IN BIT;
  b1, b2, b3 : IN BIT;
  RegTemp_END : IN BIT;
  Load : IN BIT;
  n1, n2, n3 : OUT BIT;
  RegTemp_C : OUT BIT;
  RegTemp_L : OUT BIT;
  OnMicro : OUT BIT;
  OnAlarm : OUT BIT;
  end_decrementador : OUT BIT;
  --Q_data_Time : OUT STD_LOGIC_VECTOR(11 downto 0)
  Q_data_Time : OUT INTEGER RANGE 3599 DOWNTO 0
  ) ;
END main ;

ARCHITECTURE Behavior OF main IS
signal Q_decre : INTEGER RANGE 3599 DOWNTO 0);
signal saida_RegTemp:bit;
signal in_regEstados : STD_LOGIC_VECTOR(2 DOWNTO 0);
--signal Q_decrementador : STD_LOGIC_VECTOR(11 downto 0);
signal Q_regEstados : STD_LOGIC_VECTOR(2 DOWNTO 0);

component comparador12 is 
  port(
    data_comp : IN INTEGER RANGE 3599 DOWNTO 0;
    RegTemp_END_comp : OUT BIT
  );
end component;

component RegTemp is
  port(
    data_RegTemp : IN STD_LOGIC_VECTOR(11 downto 0) ;
    RegTemp_Clear, Clock_RegTemp: IN STD_LOGIC ;  
    Q_RegTemp : OUT STD_LOGIC_VECTOR(11 downto 0);              
    RegTemp_Load : IN BIT
  );
end component;

component decrementador12 is
  port(
    data_decre : IN INTEGER RANGE 3599 DOWNTO 0;
    Clock_decre : IN BIT;
    load : IN BIT;
    tc : OUT BIT;
    Q_decre : OUT INTEGER RANGE 3599 DOWNTO 0
  );
end component;

component RegEstados is
  port(
    data_estados : IN STD_LOGIC_VECTOR(2 downto 0);             
    Clock_estados: IN STD_LOGIC ;    
    Q_estados : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
end component;

BEGIN
  OnMicro <= not(b1) and b2 and b3;
  OnAlarm <= b1 and not(b2) and not(b3);
  RegTemp_L <= (not(b1) and b3 and BtnTime) or (not(b1) and b2 and b3);
  RegTemp_C <= b1 and not(b2) and not(b3);
  n1 <= (not(b1) and b2 and b3 and RegTemp_END) and (b1 and not(b2) and not(b3) and not(CDoor));
  n2 <= (not(b1) and not(b2) and b3 and BtnTime) or (not(b1) and b2 and not(b3)) or (not(b1) and b2 and b3 and not(RegTemp_END));
  n3 <= (not(b1) and not(b2) and not(b3)) or (not(b1) and b2 and not(b3) and BtnOn and CDoor) or (not(b1) and b2 and b3 and not(RegTemp_END)) or (b1 and not(b2) and not(b3) and CDoor);

  u1 : decrementador12 port map(data_decre => data_Time, Clock_decre => Clock, load => Load,tc => end_decrementador, Q_decre => Q_decre);

  u2 : comparador12 port map(data_comp => Q_decre, RegTemp_END_comp => RegTemp_END);

  --PROCESS (Clock)
  --BEGIN
    --IF Clock 'EVENT AND Clock = '1' THEN     
      --in_regEstados(0) <= n3;
      --in_regEstados(1) <= n2;
      --in_regEstados(2) <= n1;

      --u1 : RegTemp port map(data_RegTemp => data_Time, RegTemp_Clear => RegTemp_C, Clock_RegTemp => Clock, Q_RegTemp => Q_data_Time, RegTemp_Load => RegTemp_L);
     -- u2 : comparador12 port map(data_comp => Q_data_Time, RegTemp_END_comp => RegTemp_END);
      --u3 : RegEstados port map(data_estados => in_regEstados, Clock_estados => Clock, Q_estados => Q_regEstados);
      --u4 : decrementador12 port map(data_decre => Q_data_Time, Clock_decre => Clock, tc => end_decrementador, Q_decre => Q_decrementador);

     -- data_Time => Q_decrementador;
      --b1 => Q_regEstados(3); 
      --b2 => Q_regEstados(2);
      --b3 => Q_regEstados(1);
    --END IF;
  --END PROCESS;

END Behavior ;
