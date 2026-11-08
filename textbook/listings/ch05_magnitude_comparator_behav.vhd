library ieee;
use ieee.std_logic_1164.all;

entity magnitude_comparator is
    port ( A : in  std_logic_vector(3 downto 0);
           B : in  std_logic_vector(3 downto 0);
           A_Greater_B : out std_logic;
           A_Equal_B : out std_logic;
           A_Less_B : out std_logic );
end magnitude_comparator;

architecture behavioral of magnitude_comparator is
begin
    A_Greater_B <= '1' when A > B else '0';
    A_Equal_B <= '1' when A = B else '0';
    A_Less_B <= '1' when A < B else '0';
end behavioral;
