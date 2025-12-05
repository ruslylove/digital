library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity_checker is
    Port ( 
        x : in  STD_LOGIC;
        y : in  STD_LOGIC;
        z : in  STD_LOGIC;
        p_in : in  STD_LOGIC; -- The received parity bit
        err : out  STD_LOGIC -- 0 = No Error, 1 = Error Detected
    );
end parity_checker;

architecture Behavioral of parity_checker is
begin

    -- Checker Logic: C = x XOR y XOR z XOR P
    -- Checks if the total number of 1s (data + parity) is Even.
    err <= x XOR y XOR z XOR p_in;

end Behavioral;
