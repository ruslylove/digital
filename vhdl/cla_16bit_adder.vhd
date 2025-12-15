LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_16bit_adder IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- 16-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in (C0)
        S       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);-- 16-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (C16)
    );
END ENTITY cla_16bit_adder;

ARCHITECTURE hierarchical OF cla_16bit_adder IS

    -- Component Declarations
    COMPONENT cla_4bit_block
        PORT (
            A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin     : IN  STD_LOGIC;
            S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Pg_out  : OUT STD_LOGIC; -- Group Propagate (P^G)
            Gg_out  : OUT STD_LOGIC; -- Group Generate (G^G)
            Cout    : OUT STD_LOGIC  -- Local Cout (C4, C8, C12, C16)
        );
    END COMPONENT;

    COMPONENT cla_group_logic
        PORT (
            Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            C0           : IN  STD_LOGIC;
            C_out        : OUT STD_LOGIC_VECTOR(3 DOWNTO 1) -- Group Carries C4, C8, C12
        );
    END COMPONENT;


    -- Internal Signals
    SIGNAL Pg_vec, Gg_vec : STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G and G^G from 4 blocks
    SIGNAL C_group : STD_LOGIC_VECTOR(3 DOWNTO 1);        -- Group Carry outputs (C4, C8, C12)
    SIGNAL C_in_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);       -- Carry-in signals for 4 blocks (C0, C4, C8, C12)
    SIGNAL C_block_out : STD_LOGIC_VECTOR(3 DOWNTO 0);    -- Carry-out from each 4-bit block

BEGIN

    -- 1. Route the Carry-in signals to the 4-bit blocks
    C_in_vec(0) <= Cin;
    C_in_vec(3 DOWNTO 1) <= C_group(3 DOWNTO 1); -- C_in_vec(1)=C4, C_in_vec(2)=C8, C_in_vec(3)=C12

    -- 2. Instantiate the 4-bit CLA Blocks (4 instances)
    BLOCK_GEN: FOR i IN 0 TO 3 GENERATE
        BLOCK_I: cla_4bit_block
            PORT MAP (
                A       => A(i*4+3 DOWNTO i*4),
                B       => B(i*4+3 DOWNTO i*4),
                Cin     => C_in_vec(i),       -- C0 or group carry
                S       => S(i*4+3 DOWNTO i*4),
                Pg_out  => Pg_vec(i),         -- Capture P^G
                Gg_out  => Gg_vec(i),         -- Capture G^G
                Cout    => C_block_out(i)     -- Capture C4, C8, C12, C16
            );
    END GENERATE;


    -- 3. Instantiate the Group Carry-Lookahead Unit (CLU)
    CLU_BLOCK: cla_group_logic
        PORT MAP (
            Pg_in  => Pg_vec,
            Gg_in  => Gg_vec,
            C0     => Cin,
            C_out  => C_group
        );


    -- 4. Map the Final Cout
    Cout <= C_block_out(3); -- Final Cout is C16

END ARCHITECTURE hierarchical;
