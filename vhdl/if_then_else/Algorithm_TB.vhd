library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Algorithm_TB is
-- Testbench has no ports
end Algorithm_TB;

architecture Behavioral of Algorithm_TB is
    -- Constants
    constant CLK_PERIOD : time := 10 ns;

    -- Signals to connect to the Top Level
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal A_in     : unsigned(3 downto 0) := (others => '0');
    signal Bus_Out  : std_logic_vector(3 downto 0);
    signal done     : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.top
        port map (
            clk     => clk,
            rst     => rst,
            A_in    => A_in,
            Bus_Out => Bus_Out,
            done    => done
        );

    -- Clock Generation Process
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin		
        -- 1. Global Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for CLK_PERIOD;

        -- 2. Test Case 1: A = 5 (Expected B = 8)
        -- State: INPUT_A
        A_in <= to_unsigned(5, 4);
        wait for CLK_PERIOD; -- Move to B_8 state
        
        -- State: B_8 (Register is loading)
        wait for CLK_PERIOD; -- Move to OUTPUT_B state
        
        -- State: OUTPUT_B (Bus should show "1000")
        assert (Bus_Out = "1000") report "Error: A=5 should result in B=8" severity error;
        wait for CLK_PERIOD;

        -- 3. Test Case 2: A = 3 (Expected B = 13)
        -- State: INPUT_A (Bus should be 'Z' here)
        A_in <= to_unsigned(3, 4);
        wait for CLK_PERIOD; -- Move to B_13 state
        
        -- State: B_13
        wait for CLK_PERIOD; -- Move to OUTPUT_B state
        
        -- State: OUTPUT_B (Bus should show "1101")
        assert (Bus_Out = "1101") report "Error: A=3 should result in B=13" severity error;
        wait for CLK_PERIOD;

        -- 4. Check Tri-state (Return to INPUT_A)
        -- Bus should return to High-Impedance
        wait for 5 ns;
        assert (Bus_Out = "ZZZZ") report "Error: Bus not in high-impedance" severity error;

        report "Simulation Finished Successfully!";
        wait;
    end process;

end Behavioral;