LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY main IS
  PORT ( 
  data_Time : IN INTEGER RANGE 3599 DOWNTO 0;
  BtnTime : IN BIT;
  BtnOn : IN BIT;
  CDoor : IN BIT;
  Clock : IN BIT;
  tc_decre : OUT BIT;
  b1, b2, b3 : IN BIT;
  RegTemp_END : OUT BIT;
  n1, n2, n3 : OUT BIT;
  RegTemp_C : OUT BIT;
  RegTemp_L : OUT BIT;
  OnMicro : OUT BIT;
  OnAlarm : OUT BIT;
  On_decre : OUT BIT;
  Q_data_decre : OUT INTEGER RANGE 3599 DOWNTO 0;
  Q_data_Time : OUT INTEGER RANGE 3599 DOWNTO 0
  ) ;
END main ;

ARCHITECTURE Behavior OF main IS
signal Q_decre_aux : INTEGER RANGE 3599 DOWNTO 0;
signal Load : BIT;
signal Q_comp : BIT;
signal saida_RegTemp:INTEGER RANGE 3599 DOWNTO 0;
signal regtemp_end_aux : BIT;
signal in_decrementador :INTEGER RANGE 3599 DOWNTO 0;
signal regtempLoad : BIT;
signal regtempClear : BIT;
signal On_decre_aux : BIT;

component comparador12 is 
  port(
    data_comp : IN INTEGER RANGE 3599 DOWNTO 0;
    RegTemp_END_comp : OUT BIT
  );
end component;

component RegTemp is
  port(
    data_RegTemp : IN INTEGER RANGE 3599 DOWNTO 0;
    RegTemp_Clear, Clock_RegTemp: IN BIT;  
    Q_RegTemp : OUT INTEGER RANGE 3599 DOWNTO 0;
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
  OnAlarm <=(b1 and not(b2) and not(b3) and not(CDoor)) or (b1 and not(b2) and not(b3) and CDoor);
  RegTemp_L <= (not(b1) and not(b2) and b3 and not(BtnTime)) or (not(b1) and not(b2) and b3 and BtnTime);
  regtempLoad <=(not(b1) and not(b2) and b3 and not(BtnTime)) or (not(b1) and not(b2) and b3 and BtnTime);
  RegTemp_C <= b1 and not(b2) and not(b3);
  regtempClear <= b1 and not(b2) and not(b3);
  n1 <= (not(b1) and b2 and b3 and regtemp_end_aux) and (b1 and not(b2) and not(b3) and not(CDoor));
  n2 <= (not(b1) and not(b2) and b3 and BtnTime) or (not(b1) and b2 and not(b3)) or (not(b1) and b2 and b3 and not(regtemp_end_aux));
  n3 <= (not(b1) and not(b2) and not(b3)) or (not(b1) and b2 and not(b3) and BtnOn and CDoor) or (not(b1) and b2 and b3 and not(regtemp_end_aux)) or (b1 and not(b2) and not(b3) and CDoor);
  
  u1 : RegTemp port map(data_RegTemp => data_Time, RegTemp_Clear => regtempClear, Clock_RegTemp => Clock, Q_RegTemp => saida_RegTemp, RegTemp_Load => regtempLoad);
  
  Q_data_Time <= saida_RegTemp;
  in_decrementador <= saida_RegTemp;
  Load <= On_decre_aux;
  
  u2 : decrementador12 port map(data_decre => in_decrementador, Clock_decre => Clock, load => Load, tc => tc_decre, Q_decre => Q_decre_aux);
  
  Q_data_decre <= Q_decre_aux;

  u3 : comparador12 port map(data_comp => Q_decre_aux, RegTemp_END_comp => regtemp_end_aux);
  
  RegTemp_END <= regtemp_end_aux;

END Behavior ;
