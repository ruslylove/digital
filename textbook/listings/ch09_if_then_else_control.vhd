library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IfThenElseControl is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           A_eq_5   : in  STD_LOGIC;
           ALoad    : out STD_LOGIC;
           BLoad    : out STD_LOGIC;
           Muxsel   : out STD_LOGIC;
           Out_sig  : out STD_LOGIC);
end IfThenElseControl;

architecture Structural of IfThenElseControl is

    component d_ff_r
        Port ( D     : in  STD_LOGIC;
               clk   : in  STD_LOGIC;
               rst   : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

    signal D, Q : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate D Flip-Flops for State Register
    DFF2: d_ff_r port map (D(2), Clk, Reset, Q(2));
    DFF1: d_ff_r port map (D(1), Clk, Reset, Q(1));
    DFF0: d_ff_r port map (D(0), Clk, Reset, Q(0));

    -- Next State Logic
    D(2) <= Q(2) or Q(1);
    D(1) <= (not Q(1)) and Q(0);
    D(0) <= (not Q(2)) and (not Q(1)) and ((not Q(0)) or A_eq_5);

    -- Output Logic
    ALoad   <= (not Q(2)) and (not Q(1)) and (not Q(0));
    BLoad   <= (not Q(2)) and Q(1);
    Muxsel  <= Q(0);
    Out_sig <= Q(2);

end Structural;
