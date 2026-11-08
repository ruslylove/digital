library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_adder is
    port ( A, B : in  std_logic_vector(3 downto 0); -- Input BCD digits
           Cin  : in  std_logic;                    -- Carry Input
           S    : out std_logic_vector(3 downto 0); -- Sum BCD digit
           Cout : out std_logic );                  -- Carry Output
end bcd_adder;

architecture behavioral of bcd_adder is
    signal sum_temp : unsigned(4 downto 0); -- 5 bits to hold sum up to 19
    signal sum_corr : unsigned(4 downto 0);
begin
    -- 1. Binary Addition
    sum_temp <= resize(unsigned(A), 5) + resize(unsigned(B), 5) + ("0000" & Cin);

    -- 2. Correction Logic (Check if > 9)
    process(sum_temp)
    begin
        if (sum_temp > 9) then
            sum_corr <= sum_temp + 6; -- Add 6 to correct
            Cout <= '1';
        else
            sum_corr <= sum_temp;
            Cout <= '0';
        end if;
    end process;

    -- 3. Output Sum
    S <= std_logic_vector(sum_corr(3 downto 0));
end behavioral;
