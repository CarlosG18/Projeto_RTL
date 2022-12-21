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
        tc : IN std_logic;
        Data_time : IN unsigned(12 downto 0);
        Show_time: OUT unsigned (12 downto 0)
    );
end main;

architecture comportamento of main is
    type tipoestado is (START, SETS, ESPERA, ONMICRO_, ONALARM_);

    signal estado : tipoestado;
    signal reg_showtime : unsigned (12 downto 0);
    signal reg_decre : unsigned (12 downto 0);
    --signal tc : std_logic;

    constant u_zero : unsigned (12 downto 0) := "0000000000000";
    constant u_um : unsigned (0 downto 0) := "1";
begin

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
                    onMicro <= '0';
                    onAlarm <= '0';
                    if (BtnTime='1') then
                        estado <= SETS;
                    else
                        estado <= START;
                    end if;
                when SETS => 
                    reg_showtime <= Data_time;
                    estado <= ESPERA;
                when ESPERA =>
                    if (BtnOn='1' and CDoor='1') then 
                        estado <= ONMICRO1;
                    else
                        estado <= ESPERA;
                    end if;
                when ONMICRO1 =>
                    reg_showtime <= reg_showtime - 1;
                    show_time <= reg_showtime;
                    onMicro <= '1';
                    if (tc='0') then 
                        estado <= ONMICRO1;
                    elsif (tc='1') then 
                        estado <= ONALARM1;
                    end if;
                when ONALARM1 =>
                    onAlarm <= '1';
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
