library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Modulo6_Behav is
    Port ( clk, reset, C : in std_logic;
           Y : out std_logic);
end Modulo6_Behav;

architecture Behav of Modulo6_Behav is
    signal count : std_logic_vector(2 downto 0);
begin
    process(clk, reset)
    begin
        if reset='1' then
            count <= "000";
        elsif rising_edge(clk) then
            if C = '1' then
                if count = "101" then
                    count <= "000";
                else
                    count <= std_logic_vector(unsigned(count) + 1);
                end if;
            end if;
        end if;
    end process;

    -- Output Logic
    Y <= '1' when count = "101" else '0';
end Behav;
