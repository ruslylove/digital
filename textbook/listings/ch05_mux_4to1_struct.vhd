library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
    port ( I : in  std_logic_vector(3 downto 0);
           S : in  std_logic_vector(1 downto 0);
           Y : out std_logic );
end mux_4to1;

architecture structural of mux_4to1 is
begin
    Y <= (I(0) and not S(1) and not S(0)) or
         (I(1) and not S(1) and     S(0)) or
         (I(2) and     S(1) and not S(0)) or
         (I(3) and     S(1) and     S(0));
end structural;
