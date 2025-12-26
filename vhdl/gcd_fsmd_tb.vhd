library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gcd_fsmd_tb is
end gcd_fsmd_tb;

architecture Behavioral of gcd_fsmd_tb is
    -- Component Declaration
    component gcd_fsmd
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               InputX   : in  UNSIGNED(7 downto 0);
               InputY   : in  UNSIGNED(7 downto 0);
               Output   : out UNSIGNED(7 downto 0));
    end component;

    -- Inputs
    signal Clk : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal InputX : UNSIGNED(7 downto 0) := (others => '0');
    signal InputY : UNSIGNED(7 downto 0) := (others => '0');

    -- Outputs
    signal Output : UNSIGNED(7 downto 0);

    -- Clock period definitions
    constant Clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: gcd_fsmd port map (
        Clk => Clk,
        Reset => Reset,
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
        -- Test Case 1: 15 and 5 -> GCD should be 5
        InputX <= to_unsigned(15, 8);
        InputY <= to_unsigned(5, 8);

        -- hold reset state for 100 ns.
        Reset <= '1';
        wait for 100 ns;	
        Reset <= '0';
        
        wait for Clk_period*2;
        
        wait for 500 ns; -- Wait for processing
        
        -- Test Case 2: 24 and 36 -> GCD should be 12
        Reset <= '1'; wait for Clk_period; Reset <= '0';
        InputX <= to_unsigned(24, 8);
        InputY <= to_unsigned(36, 8);
        
        wait for 500 ns;

        -- Test Case 3: 17 and 13 (Co-prime) -> GCD should be 1
        Reset <= '1'; wait for Clk_period; Reset <= '0';
        InputX <= to_unsigned(17, 8);
        InputY <= to_unsigned(13, 8);
        
        wait for 500 ns;
        
        -- Test Case 4: 100 and 20 -> GCD should be 20
        Reset <= '1'; wait for Clk_period; Reset <= '0';
        InputX <= to_unsigned(100, 8);
        InputY <= to_unsigned(20, 8);
        
        wait;
    end process;

end Behavioral;
