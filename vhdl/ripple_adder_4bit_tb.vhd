LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ripple_adder_4bit_tb IS
END ENTITY ripple_adder_4bit_tb;

ARCHITECTURE behavior OF ripple_adder_4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ripple_adder_4bit
        PORT(
            A : IN  std_logic_vector(3 downto 0);
            B : IN  std_logic_vector(3 downto 0);
            Cin : IN  std_logic;
            S : OUT  std_logic_vector(3 downto 0);
            Cout : OUT  std_logic
        );
    END COMPONENT;

    -- Inputs
    signal A : std_logic_vector(3 downto 0) := (others => '0');
    signal B : std_logic_vector(3 downto 0) := (others => '0');
    signal Cin : std_logic := '0';

    -- Outputs
    signal S : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ripple_adder_4bit PORT MAP (
        A => A,
        B => B,
        Cin => Cin,
        S => S,
        Cout => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;

        -- Test Case 1: 0 + 0 + 0
        A <= "0000"; B <= "0000"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0000" and Cout = '0') report "Error Case 1" severity error;

        -- Test Case 2: 1 + 1 + 0
        A <= "0001"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0010" and Cout = '0') report "Error Case 2" severity error;

        -- Test Case 3: 15 + 1 + 0 (Overflow)
        A <= "1111"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0000" and Cout = '1') report "Error Case 3" severity error;

        -- Test Case 4: 15 + 15 + 1
        A <= "1111"; B <= "1111"; Cin <= '1';
        wait for 10 ns;
        assert (S = "1111" and Cout = '1') report "Error Case 4" severity error;

        -- Test Case 5: 5 + 3 + 0
        A <= "0101"; B <= "0011"; Cin <= '0';
        wait for 10 ns;
        assert (S = "1000" and Cout = '0') report "Error Case 5" severity error;

        report "Simulation Finished" severity note;
        wait;
    end process;

END;
