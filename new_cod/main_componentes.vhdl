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
        Data_time : IN unsigned(11 downto 0);
        Show_time: OUT unsigned (11 downto 0)
    );
end main;

architecture comportamento of main is
    component BlocoDeControle
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
    end component;

    component BlocoOperacional
        port(
            clk : in std_logic;
            data_time : IN unsigned(11 downto 0);
            reg_showtime_clr, reg_showtime_ld : in std_logic;
            decre_load : in std_logic;
            reg_showtime_END : out std_logic;
            Show_time: OUT unsigned (11 downto 0)
        );
    end component;

    signal reg_showtime_clr, reg_showtime_ld : std_logic;
    signal decre_load : std_logic;
    signal reg_showtime_END : std_logic;
    
begin

    u1 : BlocoDeControle port map (clk, rst, BtnTime, BtnTime, BtnOn, CDoor, onAlarm, onMicro, reg_showtime_clr, reg_showtime_ld, decre_load,
    reg_showtime_END);
    u2 : BlocoOperacional port map (clk, Data_time, reg_showtime_clr, reg_showtime_ld, decre_load, reg_showtime_END, Show_time);

end comportamento ;