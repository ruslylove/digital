LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: 4-bit Ripple Adder Interface
---------------------------------------------------------------------
ENTITY ripple_adder_4bit IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Two 4-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (MSB)
    );
END ENTITY ripple_adder_4bit;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation
---------------------------------------------------------------------
ARCHITECTURE structural OF ripple_adder_4bit IS

    -- 1. Declare the Full Adder Component
    COMPONENT full_adder
        PORT (
            A, B, Cin : IN  STD_LOGIC;
            S, Cout   : OUT STD_LOGIC
        );
    END COMPONENT;

    -- 2. Define Internal Signals for the Carry Chain
    -- We need 3 internal carry signals (C1, C2, C3) to link the 4 FAs.
    -- Cin from the entity is C0. Cout from the last FA is Cout of the entity.
    SIGNAL C_internal : STD_LOGIC_VECTOR(3 DOWNTO 1); 

BEGIN

    -- FA0: LSB (Bit 0)
    -- Inputs: A(0), B(0), Entity Cin
    -- Outputs: S(0), Internal Carry C_internal(1)
    FA_0: full_adder
        PORT MAP (
            A   => A(0),
            B   => B(0),
            Cin => Cin,
            S   => S(0),
            Cout => C_internal(1) -- C1
        );

    -- FA1: Bit 1
    -- Inputs: A(1), B(1), Carry from FA0 (C_internal(1))
    -- Outputs: S(1), Internal Carry C_internal(2)
    FA_1: full_adder
        PORT MAP (
            A   => A(1),
            B   => B(1),
            Cin => C_internal(1),
            S   => S(1),
            Cout => C_internal(2) -- C2
        );

    -- FA2: Bit 2
    -- Inputs: A(2), B(2), Carry from FA1 (C_internal(2))
    -- Outputs: S(2), Internal Carry C_internal(3)
    FA_2: full_adder
        PORT MAP (
            A   => A(2),
            B   => B(2),
            Cin => C_internal(2),
            S   => S(2),
            Cout => C_internal(3) -- C3
        );

    -- FA3: MSB (Bit 3)
    -- Inputs: A(3), B(3), Carry from FA2 (C_internal(3))
    -- Outputs: S(3), Entity Cout
    FA_3: full_adder
        PORT MAP (
            A   => A(3),
            B   => B(3),
            Cin => C_internal(3),
            S   => S(3),
            Cout => Cout -- Final Cout of the 4-bit adder
        );

END ARCHITECTURE structural;
