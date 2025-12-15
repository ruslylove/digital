LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pg_unit IS
    PORT (
        A, B : IN  STD_LOGIC;
        P_out, G_out : OUT STD_LOGIC
    );
END ENTITY pg_unit;

ARCHITECTURE dataflow OF pg_unit IS
BEGIN
    -- G_out: Generate signal (G = A AND B)
    G_out <= A AND B;
    
    -- P_out: Propagate signal (P = A XOR B)
    P_out <= A XOR B;
END ARCHITECTURE dataflow;
