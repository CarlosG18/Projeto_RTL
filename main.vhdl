LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY main IS
  PORT ( 
  data_Time : IN STD_LOGIC_VECTOR(11 downto 0) ;
  BtnTime : IN BIT;
  BtnOn : IN BIT;
  CDoor : IN BIT;
  Clock : IN BIT;
  b1, b2, b3 : IN BIT;
  RegTemp_END : IN BIT;
  n1, n2, n3 : OUT BIT;
  RegTemp_C : OUT BIT;
  RegTemp_L : OUT BIT;
  OnMicro : OUT BIT;
  OnAlarm : OUT BIT
  ) ;
END main ;

ARCHITECTURE Behavior OF main IS
signal saida_RegTemp:bit;
signal in_regEstados : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal out_regEstados : STD_LOGIC_VECTOR(2 DOWNTO 0);

component comparador12 is 
  port(
    data_comp : IN STD_LOGIC_VECTOR(11 downto 0) ;
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
    tc : OUT BIT;
    Q_decre : OUT INTEGER RANGE 3599 DOWNTO 0
  );
end component;

component RegEstados is
  port(
    data_estados : IN STD_LOGIC_VECTOR(2 downto 0);             
    RegEstados_C, Clock_estados: IN STD_LOGIC ;
    RegEstados_L : IN BIT;    
    Q_estados : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
end component;

BEGIN
  in_regEstados(0) <= n3;
  in_regEstados(1) <= n2;
  in_regEstados(2) <= n1;

  OnMicro <= not(b1) and b2 and b3;
  OnAlarm <= b1 and not(b2) and not(b3);
  RegTemp_L <= (not(b1) and b3 and BtnTime) or (not(b1) and b2 and b3);
  RegTemp_C <= b1 and not(b2) and not(b3);
  n1 <= (not(b1) and b2 and b3 and RegTemp_END) and (b1 and not(b2) and not(b3) and not(CDoor));
  n2 <= (not(b1) and not(b2) and b3 and BtnTime) or (not(b1) and b2 and not(b3)) or (not(b1) and b2 and b3 and not(RegTemp_END));
  n3 <= (not(b1) and not(b2) and not(b3)) or (not(b1) and b2 and not(b3) and BtnOn and CDoor) or (not(b1) and b2 and b3 and not(RegTemp_END)) or (b1 and not(b2) and not(b3) and CDoor);
  
  u1 : RegTemp port map();
  u2 : comparador12 port map();
  u3 : RegEstados port map();
  u4 : decrementador12 port map();
  
END Behavior ;
