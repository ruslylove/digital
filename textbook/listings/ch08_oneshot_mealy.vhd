library ieee;
use ieee.std_logic_1164.all;

entity One_Shot is
    Port ( clk, reset : in std_logic;
           B : in std_logic;
           S : out std_logic);
end One_Shot;

architecture Behavioral of One_Shot is
    signal Q : std_logic_vector(1 downto 0);
begin
    process(clk, reset)
    begin
        if reset='1' then
            Q <= "00";
        elsif rising_edge(clk) then
            case Q is
                when "00" => -- S0
                    if B='1' then Q <= "01"; end if;
                when "01" => -- S1
                    Q <= "10";
                when "10" => -- S2
                    if B='0' then Q <= "00"; end if;
                when others =>
                    Q <= "00";
            end case;
        end if;
    end process;

    -- Output Logic (Mealy: S=1 if State=00 and B=1)
    S <= '1' when (Q="00" and B='1') else '0';
end Behavioral;
