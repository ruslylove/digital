LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Full Adder Interface
---------------------------------------------------------------------
ENTITY full_adder IS
    PORT (
        A, B, Cin : IN  STD_LOGIC;  -- Three inputs
        S, Cout   : OUT STD_LOGIC   -- Two outputs
    );
END ENTITY full_adder;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation
---------------------------------------------------------------------
ARCHITECTURE structural OF full_adder IS

    -- 1. Declare the component used (Half Adder)
    COMPONENT half_adder
        PORT ( 
            X, Y : IN  STD_LOGIC;
            S, C : OUT STD_LOGIC 
        );
    END COMPONENT;

    -- 2. Define internal signals to connect the components
    SIGNAL S1, C1, C2 : STD_LOGIC; 
    -- S1: Sum from HA1 (A XOR B)
    -- C1: Carry from HA1 (A AND B)
    -- C2: Carry from HA2 ((A XOR B) AND Cin)

BEGIN

    -- 3. Component Instantiation 1 (HA1)
    HA_1: half_adder
        PORT MAP (
            X => A,
            Y => B,
            S => S1, -- Output S1 feeds into HA2
            C => C1  -- Output C1 feeds into the final OR gate
        );

    -- 4. Component Instantiation 2 (HA2)
    HA_2: half_adder
        PORT MAP (
            X => S1,  -- Input X is the sum from HA1
            Y => Cin, -- Input Y is the Carry-in
            S => S,   -- Output S is the final Sum of the Full Adder
            C => C2   -- Output C2 feeds into the final OR gate
        );

    -- 5. Final OR Gate (The Sum of the carries C1 and C2)
    -- Cout = C1 OR C2
    Cout <= C1 OR C2;

END ARCHITECTURE structural;
