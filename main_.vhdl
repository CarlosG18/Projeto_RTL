library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity main is
    port(
        clk, rst : in std_logic;
        BtnTime : IN std_logic;
        BtnOn : IN std_logic;
        CDoor : IN std_logic;
        onAlarm : OUT std_logic;
        onMicro : OUT std_logic;
        b1, b2, b3 : OUT std_logic;
        n1, n2, n3 : OUT std_logic;
        Data_time : IN unsigned(12 downto 0);
        Show_time: OUT unsigned (12 downto 0);
        reg_estados :OUT unsigned (2 downto 0)
    );
end main;

architecture comportamento of main is
    type tipoestado is (START, SETS, ESPERA, ONMICRO1, ONALARM1);

    signal estado : tipoestado;
    signal reg_showtime : unsigned (12 downto 0);
    signal reg_estados :unsigned (2 downto 0);
    signal reg_decre : unsigned (12 downto 0);
    signal tc : std_logic;
    signal b1_aux : std_logic;
    signal b2_aux : std_logic;
    signal b3_aux : std_logic;

    constant u_zero : unsigned (12 downto 0) := "0000000000000";
    constant u_um : unsigned (0 downto 0) := "1";
begin

  OnMicro <= not(b1_aux) and b2_aux and b3_aux;
  OnAlarm <=(b1_aux and not(b2_aux) and not(b3_aux) and not(CDoor)) or (b1_aux and not(b2_aux) and not(b3_aux) and CDoor);
  --RegTemp_L <= (not(b1_aux) and not(b2_aux) and b3_aux and not(BtnTime)) or (not(b1_aux) and not(b2_aux) and b3_aux and BtnTime);
  --regtempLoad <=(not(b1_aux) and not(b2) and b3_aux and not(BtnTime)) or (not(b1_aux) and not(b2_aux) and b3_aux and BtnTime);
  --RegTemp_C <= b1_aux and not(b2_aux) and not(b3_aux);
  --regtempClear <= b1_aux and not(b2_aux) and not(b3_aux);
  n1 <= (not(b1_aux) and b2_aux and b3_aux and regtemp_end_aux) and (b1_aux and not(b2_aux) and not(b3_aux) and not(CDoor));
  n2 <= (not(b1_aux) and not(b2_aux) and b3_aux and BtnTime) or (not(b1_aux) and b2_aux and not(b3_aux)) or (not(b1_aux) and b2_aux and b3_aux and not(tc));
  n3 <= (not(b1_aux) and not(b2_aux) and not(b3_aux)) or (not(b1_aux) and b2_aux and not(b3_aux) and BtnOn and CDoor) or (not(b1_aux) and b2_aux and b3_aux and not(tc)) or (b1_aux and not(b2_aux) and not(b3_aux) and CDoor);

    maquinadeestados : process(clk, rst)
    begin
        if (rst='1') then
        onMicro <= '0';
        onAlarm <= '0';
        reg_showtime <= u_zero;
        estado <= START;
        elsif (clk='1' and clk'event) then
            case estado is
                when START =>
                    --onMicro <= '0';
                    --onAlarm <= '0';
                    reg_estados <= '000';
                    b1_aux <= '0';
                    b2_aux <= '0';
                    b3_aux <= '0';
                    b1 <= '0';
                    b2 <= '0';
                    b3 <= '0';
                    if (BtnTime='1') then
                        estado <= SETS;
                    else
                        estado <= START;
                    end if;
                when SETS =>
                    reg_estados <= '001';
                    b1_aux <= '0';
                    b2_aux <= '0';
                    b3_aux <= '1';
                    b1 <= '0';
                    b2 <= '0';
                    b3 <= '1';
                    reg_showtime <= Data_time;
                    show_time <= reg_showtime;
                    estado <= ESPERA;
                when ESPERA =>
                    reg_estados <= '010';
                    b1_aux <= '0';
                    b2_aux <= '1';
                    b3_aux <= '0';
                    b1 <= '0';
                    b2 <= '1';
                    b3 <= '0';
                    if (BtnOn='1' and CDoor='1') then 
                        estado <= ONMICRO1;
                    else
                        estado <= ESPERA;
                    end if;
                when ONMICRO1 =>
                    reg_estados <= '011';
                    b1_aux <= '0';
                    b2_aux <= '1';
                    b3_aux <= '1';
                    b1 <= '0';
                    b2 <= '1';
                    b3 <= '1';
                    reg_showtime <= reg_showtime - 1;
                    show_time <= reg_showtime;
                    --onMicro <= '1';
                    if (reg_showtime = u_zero) then 
                        tc <= '1';
                        estado <= ONALARM1;
                    else  
                        tc <= '0';
                        estado <= ONMICRO1;
                    end if;
                when ONALARM1 =>
                    reg_estados <= '100';
                    b1_aux <= '1';
                    b2_aux <= '0';
                    b3_aux <= '0';
                    b1 <= '1';
                    b2 <= '0';
                    b3 <= '0';
                    --onAlarm <= '1';
                    --onMicro <= '0';
                    reg_showtime <= u_zero;
                    if (CDoor='1') then 
                        estado <= ONALARM1;
                    else
                        estado <= START;
                    end if;
            end case;
        end if;
    end process;        
end comportamento;
