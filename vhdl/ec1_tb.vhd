library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity ec1_tb is
end ec1_tb;

architecture Behavioral of ec1_tb is
    component ec1
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               input_bus : in STD_LOGIC_VECTOR (7 downto 0);
               output_bus : out STD_LOGIC_VECTOR (7 downto 0);
               halt : out STD_LOGIC;
               dbg_opcode : out STD_LOGIC_VECTOR(2 downto 0);
               dbg_A_neq_0 : out STD_LOGIC;
               dbg_PC : out STD_LOGIC_VECTOR(3 downto 0);
               dbg_IR : out STD_LOGIC_VECTOR(7 downto 0);
               dbg_state : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal input_bus : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal output_bus : STD_LOGIC_VECTOR(7 downto 0);
    signal halt : STD_LOGIC;
    signal dbg_opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal dbg_A_neq_0 : STD_LOGIC;
    signal dbg_PC : STD_LOGIC_VECTOR(3 downto 0);
    signal dbg_IR : STD_LOGIC_VECTOR(7 downto 0);
    signal dbg_state : STD_LOGIC_VECTOR(2 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: ec1 port map (
        clk => clk,
        reset => reset,
        input_bus => input_bus,
        output_bus => output_bus,
        halt => halt,
        dbg_opcode => dbg_opcode,
        dbg_A_neq_0 => dbg_A_neq_0,
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
        -- Hold reset for 20 ns
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Input data: 10 (0x0A)
        input_bus <= "00001010"; 
        
        -- Wait until halt
        wait until halt = '1';
        
        wait for 20 ns;
        assert false report "Simulation Finished" severity failure;
    end process;

end Behavioral;
