LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sum_logic IS
    PORT (
        P_in, C_in : IN  STD_LOGIC;
        S_out      : OUT STD_LOGIC
    );
END ENTITY sum_logic;

ARCHITECTURE dataflow OF sum_logic IS
BEGIN
    -- S_out: Sum bit (S = P XOR C)
    S_out <= P_in XOR C_in;
END ARCHITECTURE dataflow;
