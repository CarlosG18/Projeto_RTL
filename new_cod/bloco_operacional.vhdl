library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity BlocoOperacional is
    port(
        clk : in std_logic;
        data_time : IN unsigned(12 downto 0);
        reg_showtime_clr, reg_showtime_ld : in std_logic;
        decre_load : in std_logic;
        reg_showtime_END : out std_logic;
        Show_time: OUT unsigned (12 downto 0)
    );
end main;

architecture comportamento of BlocoOperacional is
    component comparador12 is 
  port(
    data_comp : IN INTEGER RANGE 3599 DOWNTO 0;
    Reg_showtime_END_comp : OUT std_logic
  );
end component;

component Reg_showtime is
  port(
    data_Reg_showtime : IN INTEGER RANGE 3599 DOWNTO 0;
    reg_showtime_clr, Clock_RegTemp: IN std_logic;  
    Q_Reg_showtime : OUT INTEGER RANGE 3599 DOWNTO 0;
    reg_showtime_ld : IN std
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

begin

    decrementador : decrementador12 port map ();
    reg_showT : Reg_showtime port map ();
    comparar : comparador port map ();

end comportamento;