library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
    port ( D, C : in  std_logic;
           Q    : out std_logic );
end d_latch;

architecture behavioral of d_latch is
begin
    process(D, C)
    begin
        if C = '1' then
            Q <= D;
        end if;
    end process;
end behavioral;
