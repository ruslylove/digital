library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.gcd_components.all; -- Use the package we defined

entity gcd_datapath is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           InputX   : in  STD_LOGIC_VECTOR (7 downto 0);
           InputY   : in  STD_LOGIC_VECTOR (7 downto 0);
           
           -- Control Signals
           In_X     : in  STD_LOGIC; -- 1 = Load External X, 0 = Load Result
           In_Y     : in  STD_LOGIC; -- 1 = Load External Y, 0 = Load Result
           XLoad    : in  STD_LOGIC;
           YLoad    : in  STD_LOGIC;
           XY       : in  STD_LOGIC; -- 0 = X-Y, 1 = Y-X
           Out_En   : in  STD_LOGIC;
           
           -- Status Signals
           XeqY     : out STD_LOGIC;
           XgtY     : out STD_LOGIC;
           
           -- Data Output
           OutputData : out STD_LOGIC_VECTOR (7 downto 0));
end gcd_datapath;

architecture Structural of gcd_datapath is

    signal X_Reg_Q, Y_Reg_Q : STD_LOGIC_VECTOR(7 downto 0);
    signal X_Mux_Out, Y_Mux_Out : STD_LOGIC_VECTOR(7 downto 0);
    signal Sub_A, Sub_B, Sub_Diff : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Register X
    -- Input MUX for X: Selects between Subtractor Result (0) and InputX (1)
    Mux_In_X: mux_2to1_8bit port map (
        SEL => In_X,
        A   => Sub_Diff,
        B   => InputX,
        Y   => X_Mux_Out
    );

    Reg_X: reg_8bit port map (
        D     => X_Mux_Out,
        Reset => Reset,
        Clk   => Clk,
        Load  => XLoad,
        Q     => X_Reg_Q
    );

    -- Register Y
    -- Input MUX for Y: Selects between Subtractor Result (0) and InputY (1)
    Mux_In_Y: mux_2to1_8bit port map (
        SEL => In_Y,
        A   => Sub_Diff,
        B   => InputY,
        Y   => Y_Mux_Out
    );

    Reg_Y: reg_8bit port map (
        D     => Y_Mux_Out,
        Reset => Reset,
        Clk   => Clk,
        Load  => YLoad,
        Q     => Y_Reg_Q
    );

    -- Comparator
    Comp: comparator_8bit port map (
        A    => X_Reg_Q,
        B    => Y_Reg_Q,
        AeqB => XeqY,
        AgtB => XgtY
    );

    -- Subtractor Operand Selection (Swap Logic)
    -- If XY=0 (X-Y): SubA=X, SubB=Y
    -- If XY=1 (Y-X): SubA=Y, SubB=X
    
    Mux_Sub_A: mux_2to1_8bit port map (
        SEL => XY,
        A   => X_Reg_Q,
        B   => Y_Reg_Q,
        Y   => Sub_A
    );

    Mux_Sub_B: mux_2to1_8bit port map (
        SEL => XY,
        A   => Y_Reg_Q,
        B   => X_Reg_Q,
        Y   => Sub_B
    );

    -- Subtractor
    Sub: subtractor_8bit port map (
        A    => Sub_A,
        B    => Sub_B,
        Diff => Sub_Diff
    );

    -- Output Tristate Buffer (Outputs X)
    Out_Buf: tristate_buffer_8bit port map (
        Input  => X_Reg_Q,
        Enable => Out_En,
        Output => OutputData
    );

end Structural;
