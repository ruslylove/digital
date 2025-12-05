LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_subtractor_4bit_tb IS
END ENTITY adder_subtractor_4bit_tb;

ARCHITECTURE behavior OF adder_subtractor_4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT adder_subtractor_4bit
        PORT(
            A       : IN  std_logic_vector(3 downto 0);
            B       : IN  std_logic_vector(3 downto 0);
            add_sub : IN  std_logic;
            S       : OUT std_logic_vector(3 downto 0);
            Cout    : OUT std_logic
        );
    END COMPONENT;

    -- Inputs
    signal A       : std_logic_vector(3 downto 0) := (others => '0');
    signal B       : std_logic_vector(3 downto 0) := (others => '0');
    signal add_sub : std_logic := '0';

    -- Outputs
    signal S    : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: adder_subtractor_4bit PORT MAP (
        A       => A,
        B       => B,
        add_sub => add_sub,
        S       => S,
        Cout    => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;

        -- Test Case 1: Addition 5 + 3 = 8
        -- 0101 + 0011 = 1000 (-8 in signed, 8 in unsigned)
        A <= "0101"; B <= "0011"; add_sub <= '0';
        wait for 10 ns;
        assert (S = "1000") report "Error Case 1: 5+3" severity error;

        -- Test Case 2: Subtraction 5 - 3 = 2
        -- 0101 - 0011 = 0010
        A <= "0101"; B <= "0011"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "0010") report "Error Case 2: 5-3" severity error;

        -- Test Case 3: Subtraction 3 - 5 = -2
        -- 0011 - 0101 = 1110 (-2 in 2's complement)
        A <= "0011"; B <= "0101"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "1110") report "Error Case 3: 3-5" severity error;

        -- Test Case 4: Addition 7 + 2 = 9 (Overflow)
        -- 0111 + 0010 = 1001 (-7 in signed, overflow occurred)
        A <= "0111"; B <= "0010"; add_sub <= '0';
        wait for 10 ns;
        assert (S = "1001") report "Error Case 4: 7+2" severity error;

        -- Test Case 5: Subtraction -8 - 1 = -9 (Underflow/Overflow)
        -- 1000 - 0001 = 0111 (+7 in signed, overflow occurred)
        A <= "1000"; B <= "0001"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "0111") report "Error Case 5: -8-1" severity error;

        report "Simulation Finished" severity note;
        wait;
    end process;

END;
