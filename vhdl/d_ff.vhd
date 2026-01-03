library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff is
    Port ( D     : in  STD_LOGIC;
           CLK   : in  STD_LOGIC;
           CLR   : in  STD_LOGIC;
           Q     : out STD_LOGIC;
           Q_bar : out STD_LOGIC);
end d_ff;

architecture Behavioral of d_ff is
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            Q <= '0';
            Q_bar <= '1';
        elsif rising_edge(CLK) then
            Q <= D;
            Q_bar <= not D;
        end if;
    end process;
end Behavioral;
