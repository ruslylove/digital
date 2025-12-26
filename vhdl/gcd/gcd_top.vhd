library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gcd_top is
    Port ( Clk    : in  STD_LOGIC;
           Reset  : in  STD_LOGIC;
           InputX : in  STD_LOGIC_VECTOR (7 downto 0);
           InputY : in  STD_LOGIC_VECTOR (7 downto 0);
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end gcd_top;

architecture Structural of gcd_top is

    component gcd_datapath
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               InputX   : in  STD_LOGIC_VECTOR (7 downto 0);
               InputY   : in  STD_LOGIC_VECTOR (7 downto 0);
               In_X     : in  STD_LOGIC;
               In_Y     : in  STD_LOGIC;
               XLoad    : in  STD_LOGIC;
               YLoad    : in  STD_LOGIC;
               XY       : in  STD_LOGIC;
               Out_En   : in  STD_LOGIC;
               XeqY     : out STD_LOGIC;
               XgtY     : out STD_LOGIC;
               OutputData : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component gcd_control
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               XeqY     : in  STD_LOGIC;
               XgtY     : in  STD_LOGIC;
               In_X     : out STD_LOGIC;
               In_Y     : out STD_LOGIC;
               XLoad    : out STD_LOGIC;
               YLoad    : out STD_LOGIC;
               XY       : out STD_LOGIC;
               Out_En   : out STD_LOGIC);
    end component;

    -- Internal Signals
    signal In_X, In_Y, XLoad, YLoad, XY, Out_En : STD_LOGIC;
    signal XeqY, XgtY : STD_LOGIC;

begin

    -- Instantiate Datapath
    Datapath: gcd_datapath port map (
        Clk        => Clk,
        Reset      => Reset,
        InputX     => InputX,
        InputY     => InputY,
        In_X       => In_X,
        In_Y       => In_Y,
        XLoad      => XLoad,
        YLoad      => YLoad,
        XY         => XY,
        Out_En     => Out_En,
        XeqY       => XeqY,
        XgtY       => XgtY,
        OutputData => Output
    );

    -- Instantiate Control Unit
    Control: gcd_control port map (
        Clk => Clk,
        Reset => Reset,
        XeqY => XeqY,
        XgtY => XgtY,
        In_X => In_X,
        In_Y => In_Y,
        XLoad => XLoad,
        YLoad => YLoad,
        XY => XY,
        Out_En => Out_En
    );

end Structural;
