library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
    port ( I : in  std_logic_vector(2 downto 0);
           D : out std_logic_vector(7 downto 0) );
end decoder_3to8;

architecture dataflow of decoder_3to8 is
begin
    D(0) <= not I(2) and not I(1) and not I(0);
    D(1) <= not I(2) and not I(1) and     I(0);
    D(2) <= not I(2) and     I(1) and not I(0);
    D(3) <= not I(2) and     I(1) and     I(0);
    D(4) <=     I(2) and not I(1) and not I(0);
    D(5) <=     I(2) and not I(1) and     I(0);
    D(6) <=     I(2) and     I(1) and not I(0);
    D(7) <=     I(2) and     I(1) and     I(0);
end dataflow;
