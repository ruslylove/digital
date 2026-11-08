library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_parallel_load is
    port ( CLK, CLR, LOAD, COUNT : in  std_logic;
           P_IN                  : in  std_logic_vector(3 downto 0);
           Q_OUT                 : out std_logic_vector(3 downto 0) );
end counter_parallel_load;

architecture behavioral of counter_parallel_load is
    signal count_val : unsigned(3 downto 0);
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            count_val <= (others => '0');
        elsif rising_edge(CLK) then
            if LOAD = '1' then
                count_val <= unsigned(P_IN);
            elsif COUNT = '1' then
                count_val <= count_val + 1;
            end if;
        end if;
    end process;
    Q_OUT <= std_logic_vector(count_val);
end behavioral;
