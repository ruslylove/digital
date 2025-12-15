LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_4bit_adder IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in (C0)
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (C4)
    );
END ENTITY cla_4bit_adder;

ARCHITECTURE structural OF cla_4bit_adder IS

    -- Declare all necessary components
    COMPONENT pg_unit
        PORT ( A, B : IN STD_LOGIC; P_out, G_out : OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT cla_logic
        PORT ( P_in, G_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); C0 : IN STD_LOGIC; C_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 1) );
    END COMPONENT;

    COMPONENT sum_logic
        PORT ( P_in, C_in : IN STD_LOGIC; S_out : OUT STD_LOGIC );
    END COMPONENT;

    -- Internal Signals for P and G vectors
    SIGNAL P_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL G_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Internal Signals for the Carries (C1, C2, C3, C4)
    SIGNAL C_vec : STD_LOGIC_VECTOR(4 DOWNTO 1); 

    -- Internal Signals for correct Carry-in for each bit i=0 to 3 (C0, C1, C2, C3)
    SIGNAL C_in_sum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    -- Map C0 (Cin) and C1-C3 (from C_vec) to the correct carry-in signals for the Sum Logic
    -- C_in_sum(0) must be C0, and C_in_sum(1 to 3) must be C_vec(1 to 3)
    C_in_sum(0) <= Cin;
    C_in_sum(3 DOWNTO 1) <= C_vec(3 DOWNTO 1); 

    -- 1. Generate P and G Signals (4 instances of PG_Unit)
    PG_GEN: FOR i IN 0 TO 3 GENERATE
        PG_I: pg_unit
            PORT MAP (
                A => A(i),
                B => B(i),
                P_out => P_vec(i),
                G_out => G_vec(i)
            );
    END GENERATE;

    -- 2. CLA Logic Block (1 instance)
    CLA_BLOCK: cla_logic
        PORT MAP (
            P_in => P_vec,
            G_in => G_vec,
            C0   => Cin,
            C_out => C_vec
        );

    -- Map the final calculated carry C4 to the entity's Cout
    Cout <= C_vec(4);

    -- 3. Sum Logic (4 instances of Sum_Logic)
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in => P_vec(i),
                -- Use the pre-calculated C_in_sum(i)
                C_in => C_in_sum(i),
                S_out => S(i)
            );
    END GENERATE;

END ARCHITECTURE structural;
