LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY multiplier_4x4_tb IS
END ENTITY multiplier_4x4_tb;

ARCHITECTURE behavior OF multiplier_4x4_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT multiplier_4x4
        PORT (
            A, B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            P    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Inputs
    SIGNAL A_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    -- Outputs
    SIGNAL P_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: multiplier_4x4 PORT MAP (
        A => A_tb,
        B => B_tb,
        P => P_tb
    );

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Test Case 1: 0 * 0
        A_tb <= "0000"; B_tb <= "0000";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000000") REPORT "Error: 0*0 failed" SEVERITY ERROR;

        -- Test Case 2: 1 * 1
        A_tb <= "0001"; B_tb <= "0001";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000001") REPORT "Error: 1*1 failed" SEVERITY ERROR;

        -- Test Case 3: 15 * 1 (Max 4-bit unsigned * identity)
        A_tb <= "1111"; B_tb <= "0001";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00001111") REPORT "Error: 15*1 failed" SEVERITY ERROR;

        -- Test Case 4: 15 * 15 (Max * Max)
        A_tb <= "1111"; B_tb <= "1111";
        WAIT FOR 10 ns;
        -- 15 * 15 = 225 = 0xE1 = 11100001
        ASSERT (P_tb = "11100001") REPORT "Error: 15*15 failed" SEVERITY ERROR;

        -- Test Case 5: 3 * 2
        A_tb <= "0011"; B_tb <= "0010";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000110") REPORT "Error: 3*2 failed" SEVERITY ERROR;
        
        -- Test Case 6: 7 * 9 (Arbitrary)
        A_tb <= "0111"; B_tb <= "1001";
        WAIT FOR 10 ns;
        -- 7 * 9 = 63 = 00111111
        ASSERT (P_tb = "00111111") REPORT "Error: 7*9 failed" SEVERITY ERROR;

        REPORT "Simulation Finished Successfully" SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
