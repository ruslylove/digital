library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is
    port ( J, K, CLK : in  std_logic;
           Q         : out std_logic );
end jk_ff;

architecture behavioral of jk_ff is
    signal q_int : std_logic := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if (J='0' and K='0') then
                null; -- No change
            elsif (J='0' and K='1') then
                q_int <= '0'; -- Reset
            elsif (J='1' and K='0') then
                q_int <= '1'; -- Set
            elsif (J='1' and K='1') then
                q_int <= not q_int; -- Toggle
            end if;
        end if;
    end process;
    Q <= q_int;
end behavioral;
