library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity_generator is
    Port ( 
        x : in  STD_LOGIC;
        y : in  STD_LOGIC;
        z : in  STD_LOGIC;
        p_even : out  STD_LOGIC -- Output for Even Parity scheme
    );
end parity_generator;

architecture Behavioral of parity_generator is
begin

    -- Even Parity Logic: P = x XOR y XOR z
    -- If the number of 1s in input is odd, P becomes 1 (making total 1s even).
    p_even <= x XOR y XOR z;

end Behavioral;
