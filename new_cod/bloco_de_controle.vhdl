library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity BlocoDeControle is
    port(
        clk, rst : in std_logic;
        BtnTime : IN std_logic;
        BtnOn : IN std_logic;
        CDoor : IN std_logic;
        onAlarm : OUT std_logic;
        onMicro : OUT std_logic;
        reg_showtime_clr, reg_showtime_ld : out std_logic;
        decre_load : out std_logic;
        reg_showtime_END : in std_logic
    );
end BlocoDeControle;

architecture comportamento of BlocoDeControle is
    type tipoestado is (START, SETS, ESPERA, ONMICRO1, ONALARM1);
    signal estadoatual, proximoestado: tipoestado;
begin
    regestado: process(clk, rst)
    begin
        if (rst='1') then 
            estadoatual <= START;
        elsif (clk='1' and clk'event) then 
            estadoatual <= proximoestado;
        end if;
    end process;
    
    logicacomb: process(estadoatual, BtnTime, BtnOn, CDoor, reg_showtime_END)
    begin
        
        case estadoatual is
            when START =>
                    onMicro <= '0';
                    onAlarm <= '0';
                    if (BtnTime='1') then
                        proximoestado <= SETS;
                    else
                        proximoestado <= START;
                    end if;
                when SETS => 
                    reg_showtime_ld <= '1'; 
                    proximoestado <= ESPERA;
                when ESPERA =>
                    if (BtnOn='1' and CDoor='1') then 
                        proximoestado <= ONMICRO1;
                    else
                        proximoestado <= ESPERA;
                    end if;
                when ONMICRO1 =>
                    decre_load <= '1';
                    --show_time <= reg_showtime;
                    onMicro <= '1';
                    if (reg_showtime_END='0') then 
                        proximoestado <= ONMICRO1;
                    elsif (reg_showtime_END='1') then 
                        proximoestado <= ONALARM1;
                    end if;
                when ONALARM1 =>
                    onAlarm <= '1';
                    reg_showtime_clr <= '1';
                    if (CDoor='1') then 
                        proximoestado <= ONALARM1;
                    else
                        proximoestado <= START;
                    end if;
            end case;

end comportamento;