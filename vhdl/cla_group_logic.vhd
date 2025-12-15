LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_group_logic IS
    PORT (
        Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G and G^G from 4 groups
        C0           : IN  STD_LOGIC;                    -- Global Cin (C0)
        C_out        : OUT STD_LOGIC_VECTOR(3 DOWNTO 1)  -- Group Carries C4, C8, C12
    );
END ENTITY cla_group_logic;

ARCHITECTURE two_level_carry OF cla_group_logic IS
    -- Carries C_out(1) = C4, C_out(2) = C8, C_out(3) = C12
BEGIN
    -- C4 = G^G0 + P^G0 * C0
    C_out(1) <= Gg_in(0) OR (Pg_in(0) AND C0);

    -- C8 = G^G1 + P^G1 * C4
    C_out(2) <= Gg_in(1) OR 
                (Pg_in(1) AND Gg_in(0)) OR 
                (Pg_in(1) AND Pg_in(0) AND C0);

    -- C12 = G^G2 + P^G2 * C8
    C_out(3) <= Gg_in(2) OR 
                (Pg_in(2) AND Gg_in(1)) OR 
                (Pg_in(2) AND Pg_in(1) AND Gg_in(0)) OR 
                (Pg_in(2) AND Pg_in(1) AND Pg_in(0) AND C0);

END ARCHITECTURE two_level_carry;
