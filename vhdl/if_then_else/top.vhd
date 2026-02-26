 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        A_in     : in  unsigned(3 downto 0);
        Bus_Out  : out std_logic_vector(3 downto 0);
        done     : out std_logic
    );
end top;

architecture Structural of top is
    -- Internal Signal Declarations
    signal s_A_eq_5  : std_logic;
    signal s_sel_A5  : std_logic;
    signal s_load_B  : std_logic;
    signal s_en_tri  : std_logic;

begin

    -- Instance 1: The Control Unit (FSM)
    -- States: INPUT_A -> B_8/B_13 -> OUTPUT_B
    U_Control : entity work.control_unit_extra
        port map (
            clk     => clk,
            rst     => rst,
            A_eq_5  => s_A_eq_5, -- Feedback from Datapath
            sel_A5  => s_sel_A5, -- Signal to MUX
            load_B  => s_load_B, -- Signal to Register B
            en_tri  => s_en_tri, -- Signal to Tri-state
            done    => done
        );

    -- Instance 2: The Datapath
    -- Components: MUX, Reg B, Tri-state Buffer
    U_Datapath : entity work.Datapath_Structural
        port map (
            clk      => clk,
            A        => A_in,
            sel_A5   => s_sel_A5,
            load_B   => s_load_B,
            en_tri   => s_en_tri,
            A_eq_5   => s_A_eq_5, -- Feedback to Control Unit
            Bus_Out  => Bus_Out
        );

end Structural;