library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gcd_tb is
-- Testbench has no ports
end gcd_tb;

architecture Behavioral of gcd_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component gcd_top
        Port ( Clk    : in  STD_LOGIC;
               Reset  : in  STD_LOGIC;
               InputX : in  STD_LOGIC_VECTOR (7 downto 0);
               InputY : in  STD_LOGIC_VECTOR (7 downto 0);
               Output : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Inputs
    signal Clk    : STD_LOGIC := '0';
    signal Reset  : STD_LOGIC := '0';
    signal InputX : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal InputY : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    -- Outputs
    signal Output : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period definitions
    constant Clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: gcd_top PORT MAP (
        Clk    => Clk,
        Reset  => Reset,
        InputX => InputX,
        InputY => InputY,
        Output => Output
    );

    -- Clock process definitions
    Clk_process :process
    begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        Reset <= '1';
        wait for 20 ns;	
        Reset <= '0';
        wait for 20 ns;

        -- Test Case 1: GCD(15, 10) = 5
        -- 15 = 00001111
        -- 10 = 00001010
        InputX <= std_logic_vector(to_unsigned(15, 8));
        InputY <= std_logic_vector(to_unsigned(10, 8));
        
        wait for 500 ns; -- Wait for computation to finish

        -- Expect Output = 5
        report "Test Case 1: GCD(15, 10)";
        
        -- Test Case 2: GCD(50, 20) = 10
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        InputX <= std_logic_vector(to_unsigned(50, 8));
        InputY <= std_logic_vector(to_unsigned(20, 8));
        
        wait for 500 ns;
        report "Test Case 2: GCD(50, 20)";

        wait;
    end process;

end Behavioral;
