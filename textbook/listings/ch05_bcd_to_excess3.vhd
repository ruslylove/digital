library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_excess3 is
    port ( A, B, C, D : in  std_logic;
           w, x, y, z : out std_logic );
end bcd_to_excess3;

architecture dataflow of bcd_to_excess3 is
begin
    z <= not D;
    y <= C xnor D;
    x <= B xor (C or D);
    w <= A or (B and (C or D));
end dataflow;
