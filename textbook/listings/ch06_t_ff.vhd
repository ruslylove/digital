library ieee;
use ieee.std_logic_1164.all;

entity t_ff is
    port ( T, CLK : in  std_logic;
           Q      : out std_logic );
end t_ff;

architecture behavioral of t_ff is
    signal q_int : std_logic := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if T='1' then
                 q_int <= not q_int;
            end if;
        end if;
    end process;
    Q <= q_int;
end behavioral;
