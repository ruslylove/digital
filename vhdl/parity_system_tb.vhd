library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY parity_system_tb IS
END ENTITY parity_system_tb;

ARCHITECTURE behavior OF parity_system_tb IS

    -- Component Declarations
    COMPONENT parity_generator
        PORT(
            x : IN  std_logic;
            y : IN  std_logic;
            z : IN  std_logic;
            p_even : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT parity_checker
        PORT(
            x : IN  std_logic;
            y : IN  std_logic;
            z : IN  std_logic;
            p_in : IN  std_logic;
            err : OUT  std_logic
        );
    END COMPONENT;

    -- Inputs
    signal x : std_logic := '0';
    signal y : std_logic := '0';
    signal z : std_logic := '0';

    -- Internal Signals
    signal p_generated : std_logic; -- Output from Generator
    signal p_received  : std_logic; -- Input to Checker (possibly corrupted)
    
    -- Error Injection Control
    signal inject_error : std_logic := '0'; -- '1' to flip the parity bit

    -- Outputs
    signal err_detected : std_logic;

BEGIN

    -- Instantiate the Parity Generator
    gen_inst: parity_generator PORT MAP (
        x => x,
        y => y,
        z => z,
        p_even => p_generated
    );

    -- Error Injection Logic
    -- If inject_error is '1', flip the parity bit. Otherwise pass it through.
    p_received <= p_generated XOR inject_error;

    -- Instantiate the Parity Checker
    check_inst: parity_checker PORT MAP (
        x => x,
        y => y,
        z => z,
        p_in => p_received,
        err => err_detected
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;

        -- Test Case 1: Normal Operation (Even number of 1s)
        -- Data: 101 (Two 1s) -> Parity should be 0. Total 1s = 2 (Even).
        x <= '1'; y <= '0'; z <= '1'; inject_error <= '0';
        wait for 10 ns;
        assert (p_generated = '0') report "Gen Error Case 1" severity error;
        assert (err_detected = '0') report "Check Error Case 1" severity error;

        -- Test Case 2: Normal Operation (Odd number of 1s)
        -- Data: 111 (Three 1s) -> Parity should be 1. Total 1s = 4 (Even).
        x <= '1'; y <= '1'; z <= '1'; inject_error <= '0';
        wait for 10 ns;
        assert (p_generated = '1') report "Gen Error Case 2" severity error;
        assert (err_detected = '0') report "Check Error Case 2" severity error;

        -- Test Case 3: Error Injection (Transmission Error)
        -- Data: 010 (One 1) -> Parity Gen = 1.
        -- We inject error, so Checker receives Parity = 0.
        -- Checker sees: 0, 1, 0 and P=0. Total 1s = 1 (Odd!). Error!
        x <= '0'; y <= '1'; z <= '0'; inject_error <= '1';
        wait for 10 ns;
        assert (err_detected = '1') report "Check Error Case 3: Error not detected!" severity error;

        -- Test Case 4: Error Injection (Another case)
        -- Data: 000 (Zero 1s) -> Parity Gen = 0.
        -- Inject error -> Checker receives P=1.
        -- Checker sees: 0, 0, 0 and P=1. Total 1s = 1 (Odd!). Error!
        x <= '0'; y <= '0'; z <= '0'; inject_error <= '1';
        wait for 10 ns;
        assert (err_detected = '1') report "Check Error Case 4: Error not detected!" severity error;

        report "Simulation Finished" severity note;
        wait;
    end process;

END;
