LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_logic IS
    PORT (
        P_in, G_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P and G vectors (P0-P3, G0-G3)
        C0         : IN  STD_LOGIC;                    -- Global Carry-in
        C_out      : OUT STD_LOGIC_VECTOR(4 DOWNTO 1)  -- Calculated Carries (C1-C4)
    );
END ENTITY cla_logic;

ARCHITECTURE dataflow OF cla_logic IS
BEGIN
    -- C1 = G0 + P0 * C0
    C_out(1) <= G_in(0) OR (P_in(0) AND C0);
    
    -- C2 = G1 + P1*G0 + P1*P0*C0
    C_out(2) <= G_in(1) OR (P_in(1) AND G_in(0)) OR (P_in(1) AND P_in(0) AND C0);

    -- C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*C0
    C_out(3) <= G_in(2) OR (P_in(2) AND G_in(1)) OR (P_in(2) AND P_in(1) AND G_in(0)) OR 
                (P_in(2) AND P_in(1) AND P_in(0) AND C0);

    -- C4 = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*C0 (Final Carry-out of the 4-bit block)
    C_out(4) <= G_in(3) OR (P_in(3) AND G_in(2)) OR (P_in(3) AND P_in(2) AND G_in(1)) OR 
                (P_in(3) AND P_in(2) AND P_in(1) AND G_in(0)) OR 
                (P_in(3) AND P_in(2) AND P_in(1) AND P_in(0) AND C0);

END ARCHITECTURE dataflow;
