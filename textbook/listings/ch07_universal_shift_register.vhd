library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity universal_shift_register is
    port ( CLK, CLR      : in  std_logic;
           S            : in  std_logic_vector(1 downto 0); -- Mode select
           P_IN         : in  std_logic_vector(3 downto 0); -- Parallel input
           SL_IN, SR_IN : in  std_logic;                     -- Serial inputs
           Q_OUT        : out std_logic_vector(3 downto 0) );
end universal_shift_register;

architecture behavioral of universal_shift_register is
    signal reg_val : std_logic_vector(3 downto 0);
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            reg_val <= (others => '0');
        elsif rising_edge(CLK) then
            case S is
                when "00" => reg_val <= reg_val; -- No change
                when "01" => reg_val <= SR_IN & reg_val(3 downto 1); -- Shift Right
                when "10" => reg_val <= reg_val(2 downto 0) & SL_IN; -- Shift Left
                when "11" => reg_val <= P_IN; -- Parallel Load
                when others => reg_val <= reg_val;
            end case;
        end if;
    end process;
    Q_OUT <= reg_val;
end behavioral;
