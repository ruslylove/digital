library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_modulator is
    Port ( CLK      : in  STD_LOGIC;
           Match    : in  STD_LOGIC;
           Detected : out STD_LOGIC);
end output_modulator;

architecture Structural of output_modulator is
    
    component d_ff
        Port ( D, CLK, CLR : in STD_LOGIC;
               Q, Q_bar : out STD_LOGIC);
    end component;
    
    -- Frequency Divider signals
    -- Simple ripple counter or a few flip flops to divide clock
    -- Let's define a 4-bit counter to divide by 16 for visible modulation
    signal q0, q1, q2, q3 : STD_LOGIC;
    signal q0_bar, q1_bar, q2_bar, q3_bar : STD_LOGIC;
    
    signal mod_clk : STD_LOGIC;

begin

    -- T-Flip Flop equivalent using D-FF (D = not Q) for divider
    -- Stage 0: Div by 2
    ff0: d_ff port map (D => q0_bar, CLK => CLK, CLR => '0', Q => q0, Q_bar => q0_bar);
    
    -- Stage 1: Div by 4 (Clocked by Q0_bar = falling edge of Q0)
    ff1: d_ff port map (D => q1_bar, CLK => q0_bar, CLR => '0', Q => q1, Q_bar => q1_bar);
    
    -- Stage 2: Div by 8
    ff2: d_ff port map (D => q2_bar, CLK => q1_bar, CLR => '0', Q => q2, Q_bar => q2_bar);

    -- Stage 3: Div by 16
    ff3: d_ff port map (D => q3_bar, CLK => q2_bar, CLR => '0', Q => q3, Q_bar => q3_bar);
    
    -- Use Q3 as the modulation clock
    mod_clk <= q3;

    -- Final Output Logic
    Detected <= Match and mod_clk;

end Structural;
