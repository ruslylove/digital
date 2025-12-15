LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_4bit_block IS
PORT (
    A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    Cin     : IN  STD_LOGIC;      -- C0
    S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Pg_out  : OUT STD_LOGIC;      -- Group Propagate (P^G)
    Gg_out  : OUT STD_LOGIC;      -- Group Generate (G^G)
    Cout    : OUT STD_LOGIC       -- Local Cout (C4)
);
END ENTITY cla_4bit_block;

ARCHITECTURE structural OF cla_4bit_block IS

    -- Component Declarations
    COMPONENT pg_unit PORT ( A, B : IN STD_LOGIC; P_out, G_out : OUT STD_LOGIC ); END COMPONENT;
    COMPONENT sum_logic PORT ( P_in, C_in : IN STD_LOGIC; S_out : OUT STD_LOGIC ); END COMPONENT;

    -- Internal Signals
    SIGNAL P_vec, G_vec : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Individual P and G
    SIGNAL C_vec : STD_LOGIC_VECTOR(4 DOWNTO 1);        -- C1, C2, C3, C4 (The calculated carries)
    SIGNAL C_in_sum : STD_LOGIC_VECTOR(3 DOWNTO 0);     -- C0, C1, C2, C3 (Carry inputs for Sum Logic)

BEGIN

    -- 1. Instantiate 4x P/G Units (Calculates Pi and Gi)
    PG_GEN: FOR i IN 0 TO 3 GENERATE
        PG_I: pg_unit PORT MAP (A => A(i), B => B(i), P_out => P_vec(i), G_out => G_vec(i));
    END GENERATE;

    -- 2. Two-Level Carry Lookahead Logic (Calculates C1, C2, C3, C4 concurrently)
    -- C1 = G0 + P0*C0
    C_vec(1) <= G_vec(0) OR (P_vec(0) AND Cin); 

    -- C2 = G1 + P1*G0 + P1*P0*C0
    C_vec(2) <= G_vec(1) OR (P_vec(1) AND G_vec(0)) OR (P_vec(1) AND P_vec(0) AND Cin);

    -- C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*C0
    C_vec(3) <= G_vec(2) OR 
                (P_vec(2) AND G_vec(1)) OR 
                (P_vec(2) AND P_vec(1) AND G_vec(0)) OR 
                (P_vec(2) AND P_vec(1) AND P_vec(0) AND Cin);

    -- C4 (Group Carry-out) = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*C0
    C_vec(4) <= G_vec(3) OR 
                (P_vec(3) AND G_vec(2)) OR 
                (P_vec(3) AND P_vec(2) AND G_vec(1)) OR 
                (P_vec(3) AND P_vec(2) AND P_vec(1) AND G_vec(0)) OR
                (P_vec(3) AND P_vec(2) AND P_vec(1) AND P_vec(0) AND Cin);

    -- 3. Group Signals (P^G and G^G)
    -- Group Propagate (P^G)
    Pg_out <= P_vec(3) AND P_vec(2) AND P_vec(1) AND P_vec(0); 

    -- Group Generate (G^G) (This is the C4 term without the Cin component)
    Gg_out <= G_vec(3) OR 
              (P_vec(3) AND G_vec(2)) OR 
              (P_vec(3) AND P_vec(2) AND G_vec(1)) OR 
              (P_vec(3) AND P_vec(2) AND P_vec(1) AND G_vec(0));

    -- 4. Map the final C4 to the external Cout
    Cout <= C_vec(4);

    -- 5. Route Carry Signals for Sum Logic
    C_in_sum(0) <= Cin;
    C_in_sum(3 DOWNTO 1) <= C_vec(3 DOWNTO 1); 

    -- 6. Instantiate 4x Sum Logic Units (Calculates Si)
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in  => P_vec(i),
                C_in  => C_in_sum(i),
                S_out => S(i)
            );
    END GENERATE;

END ARCHITECTURE structural;
