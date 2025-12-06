LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: 4x4 Multiplier Interface (A * B = P)
---------------------------------------------------------------------
ENTITY multiplier_4x4 IS
    PORT (
        A, B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Two 4-bit multiplicands
        P    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- 8-bit product (P7 to P0)
    );
END ENTITY multiplier_4x4;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation (Array Multiplier)
---------------------------------------------------------------------
ARCHITECTURE structural OF multiplier_4x4 IS

    COMPONENT half_adder
        PORT ( X, Y : IN STD_LOGIC; S, C : OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT full_adder
        PORT ( A, B, Cin : IN STD_LOGIC; S, Cout : OUT STD_LOGIC );
    END COMPONENT;

    -- Internal Signals
    TYPE pp_matrix IS ARRAY (3 DOWNTO 0, 3 DOWNTO 0) OF STD_LOGIC;
    SIGNAL PP : pp_matrix;

    -- Row 1 Signals (Sum of A*B0 and A*B1)
    SIGNAL S1 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S1(0) is P(1), others pass to Row 2
    SIGNAL C1 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Row 2 Signals (Sum of Row 1 and A*B2)
    SIGNAL S2 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S2(0) is P(2), others pass to Row 3
    SIGNAL C2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Row 3 Signals (Sum of Row 2 and A*B3)
    SIGNAL S3 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S3(0) is P(3), S3(1) is P(4)...
    SIGNAL C3 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Carry out

BEGIN
    -- --- Stage 1: Partial Product Generation ---
    PP_GEN: FOR i IN 0 TO 3 GENERATE
        PP_ROW: FOR j IN 0 TO 3 GENERATE
            PP(i, j) <= A(i) AND B(j);
        END GENERATE PP_ROW;
    END GENERATE PP_GEN;

    -- --- Stage 2: Adder Array ---

    -- P(0)
    P(0) <= PP(0, 0);

    -- Row 1: Add (A*B0 PPs shifted) and (A*B1 PPs)
    -- Operands:
    -- B0: PP(1,0), PP(2,0), PP(3,0), '0'
    -- B1: PP(0,1), PP(1,1), PP(2,1), PP(3,1)

    -- Adder 1.0 (Bit 1)
    HA10: half_adder PORT MAP (X => PP(1, 0), Y => PP(0, 1), S => S1(0), C => C1(0));
    P(1) <= S1(0);

    -- Adder 1.1 (Bit 2)
    FA11: full_adder PORT MAP (A => PP(2, 0), B => PP(1, 1), Cin => C1(0), S => S1(1), Cout => C1(1));

    -- Adder 1.2 (Bit 3)
    FA12: full_adder PORT MAP (A => PP(3, 0), B => PP(2, 1), Cin => C1(1), S => S1(2), Cout => C1(2));

    -- Adder 1.3 (Bit 4)
    FA13: full_adder PORT MAP (A => '0',      B => PP(3, 1), Cin => C1(2), S => S1(3), Cout => C1(3));


    -- Row 2: Add Result 1 and (A*B2 PPs)
    -- Operands:
    -- Res1: S1(1),   S1(2),   S1(3),   C1(3)
    -- B2:   PP(0,2), PP(1,2), PP(2,2), PP(3,2)

    -- Adder 2.0 (Bit 2)
    HA20: half_adder PORT MAP (X => S1(1), Y => PP(0, 2), S => S2(0), C => C2(0));
    P(2) <= S2(0);

    -- Adder 2.1 (Bit 3)
    FA21: full_adder PORT MAP (A => S1(2), B => PP(1, 2), Cin => C2(0), S => S2(1), Cout => C2(1));

    -- Adder 2.2 (Bit 4)
    FA22: full_adder PORT MAP (A => S1(3), B => PP(2, 2), Cin => C2(1), S => S2(2), Cout => C2(2));

    -- Adder 2.3 (Bit 5)
    FA23: full_adder PORT MAP (A => C1(3), B => PP(3, 2), Cin => C2(2), S => S2(3), Cout => C2(3));


    -- Row 3: Add Result 2 and (A*B3 PPs)
    -- Operands:
    -- Res2: S2(1),   S2(2),   S2(3),   C2(3)
    -- B3:   PP(0,3), PP(1,3), PP(2,3), PP(3,3)

    -- Adder 3.0 (Bit 3)
    HA30: half_adder PORT MAP (X => S2(1), Y => PP(0, 3), S => S3(0), C => C3(0));
    P(3) <= S3(0);

    -- Adder 3.1 (Bit 4)
    FA31: full_adder PORT MAP (A => S2(2), B => PP(1, 3), Cin => C3(0), S => S3(1), Cout => C3(1));
    P(4) <= S3(1);

    -- Adder 3.2 (Bit 5)
    FA32: full_adder PORT MAP (A => S2(3), B => PP(2, 3), Cin => C3(1), S => S3(2), Cout => C3(2));
    P(5) <= S3(2);

    -- Adder 3.3 (Bit 6)
    FA33: full_adder PORT MAP (A => C2(3), B => PP(3, 3), Cin => C3(2), S => S3(3), Cout => C3(3));
    P(6) <= S3(3);
    
    -- P(7) is the final carry out
    P(7) <= C3(3);

END ARCHITECTURE structural;
