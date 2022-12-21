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
end BlocoOperacional;

architecture comportamento of BlocoOperacional is
    component comparador12 is 
  port(
    data_comp : IN unsigned(12 downto 0);
    Reg_showtime_END_comp : OUT std_logic
  );
end component;

component Reg_showtime is
  port(
    data_Reg_showtime : IN unsigned(12 downto 0);
    reg_showtime_clear, Clock_reg_showtime: IN std_logic;  
    Q_Reg_showtime : unsigned(12 downto 0);
    reg_showtime_load : IN std_logic
  );
end component;

component decrementador12 is
  port(
    data_decre : IN unsigned(12 downto 0);
    Clock_decre : IN std_logic;
    load : IN std_logic;
    Q_decre : OUT unsigned(12 downto 0)
  );
end component;

signal saida_decre : unsigned(12 downto 0);

begin

    decrementador : decrementador12 port map (data_time, clk, decre_load, saida_decre);
    comparar : comparador port map (saida_decre, reg_showtime_END);
    reg_showT : Reg_showtime port map (saida_decre, reg_showtime_clr, clk, Show_time, reg_showtime_ld);

end comportamento;