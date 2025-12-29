library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ec2_tb is
end ec2_tb;

architecture Behavioral of ec2_tb is
    component ec2
        Port ( clk, reset : in STD_LOGIC;
               input_bus : in STD_LOGIC_VECTOR (7 downto 0);
               output_bus : out STD_LOGIC_VECTOR (7 downto 0);
               halt : out STD_LOGIC;
               dbg_opcode : out STD_LOGIC_VECTOR(2 downto 0);
               dbg_PC : out STD_LOGIC_VECTOR(4 downto 0);
               dbg_IR : out STD_LOGIC_VECTOR(7 downto 0);
               dbg_state : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal input_bus : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal output_bus : STD_LOGIC_VECTOR(7 downto 0);
    signal halt : STD_LOGIC;
    signal dbg_opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal dbg_PC : STD_LOGIC_VECTOR(4 downto 0);
    signal dbg_IR : STD_LOGIC_VECTOR(7 downto 0);
    signal dbg_state : STD_LOGIC_VECTOR(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: ec2 port map (
        clk => clk,
        reset => reset,
        input_bus => input_bus,
        output_bus => output_bus,
        halt => halt,
        dbg_opcode => dbg_opcode,
        dbg_PC => dbg_PC,
        dbg_IR => dbg_IR,
        dbg_state => dbg_state
    );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Inputs are pre-loaded in RAM (30=15, 31=25)
        -- Program will run until Halt
        
        wait until halt = '1';
        
        -- GCD of 15 and 25 is 5.
        -- Result should be in Accumulator (output_bus)
        -- Check output_bus (assuming it reflects A)
        
        wait for 20 ns;
        assert output_bus = "00000101" report "GCD Test Failed" severity warning;
        
        wait;
    end process;

end Behavioral;
