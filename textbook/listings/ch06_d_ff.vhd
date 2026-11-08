library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port ( D, CLK : in  std_logic;
           Q      : out std_logic );
end d_ff;

architecture behavioral of d_ff is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;
        end if;
    end process;
end behavioral;
