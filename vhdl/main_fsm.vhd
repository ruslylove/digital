library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Sequence Detector: 101011
-- Structural Implementation using D Flip-Flops and Logic Gates
-- States: S0-S6 encoded in binary (3 bits: q2, q1, q0)
-- S0: 000
-- S1: 001
-- S2: 010
-- S3: 011
-- S4: 100
-- S5: 101
-- S6: 110

entity main_fsm is
    Port ( MOSI   : in  STD_LOGIC;
           Enable : in  STD_LOGIC; -- SCLK_pulse
           CLK    : in  STD_LOGIC; -- System CLK
           CS     : in  STD_LOGIC; -- Active Low CS (Logic 1 = Reset)
           Match  : out STD_LOGIC;
           State  : out STD_LOGIC_VECTOR(2 downto 0)); -- Debug output
end main_fsm;

architecture Structural of main_fsm is

    component d_ff
        Port ( D, CLK, CLR : in STD_LOGIC;
               Q, Q_bar : out STD_LOGIC);
    end component;

    -- State signals
    signal q, q_bar : STD_LOGIC_VECTOR(2 downto 0);
    signal d : STD_LOGIC_VECTOR(2 downto 0); -- Next state input
    
    -- Minterm signals (State Decoders)
    signal s0, s1, s2, s3, s4, s5, s6 : STD_LOGIC;
    
    -- Logic signals helper
    -- Note: Enable signal acts as a global enable for state transitions.
    -- If Enable=0, D <= Q (Hold state)
    -- We will implement D_in first based on transitions, then mux with Enable
    signal d_next : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- State Memory (3 Bits)
    -- CS is Active Low, but our logic handles CS=1 as Reset to S0.
    -- In System Block Diagram, CS is an input. If CS=1, we reset.
    -- The d_ff CLR is active high. So connect CS directly to CLR.
    
    ff0: d_ff port map (D => d(0), CLK => CLK, CLR => CS, Q => q(0), Q_bar => q_bar(0));
    ff1: d_ff port map (D => d(1), CLK => CLK, CLR => CS, Q => q(1), Q_bar => q_bar(1));
    ff2: d_ff port map (D => d(2), CLK => CLK, CLR => CS, Q => q(2), Q_bar => q_bar(2));
    
    -- State Decoders (Minterms)
    s0 <= q_bar(2) and q_bar(1) and q_bar(0); -- 000
    s1 <= q_bar(2) and q_bar(1) and q(0);     -- 001
    s2 <= q_bar(2) and q(1) and q_bar(0);     -- 010
    s3 <= q_bar(2) and q(1) and q(0);         -- 011
    s4 <= q(2) and q_bar(1) and q_bar(0);     -- 100
    s5 <= q(2) and q_bar(1) and q(0);         -- 101
    s6 <= q(2) and q(1) and q_bar(0);         -- 110


    -- Next State Logic (d_next represents the state we WANT to go to if Enabled)
    -- Logic derived from state diagram transitions for "101011"
    
    -- D0_next (LSB)
    -- Set high if next state is S1(001), S3(011), S5(101)
    -- To S1: From S0(1), S3(1), S6(1)
    -- To S3: From S2(1)
    -- To S5: From S4(1)
    d_next(0) <= (s0 and MOSI) or (s3 and MOSI) or (s6 and MOSI) or (s2 and MOSI) or (s4 and MOSI);
    -- Simplified: Go to odd state if MOSI=1 AND (S0, S2, S3, S4, S6)
    
    -- D1_next (Middle Bit)
    -- Set high if next state is S2(010), S3(011), S6(110)
    -- To S2: From S1(0), S5(0), S6(0)
    -- To S3: From S2(1)
    -- To S6: From S5(1)
    d_next(1) <= (s1 and (not MOSI)) or (s5 and (not MOSI)) or (s6 and (not MOSI)) or (s2 and MOSI) or (s5 and MOSI);
    
    -- D2_next (MSB)
    -- Set high if next state is S4(100), S5(101), S6(110)
    -- To S4: From S3(0)
    -- To S5: From S4(1)
    -- To S6: From S5(1)
    d_next(2) <= (s3 and (not MOSI)) or (s4 and MOSI) or (s5 and MOSI);


    -- Enable Logic (Hold State if Enable=0)
    -- D = d_next when Enable=1, else Q
    d(0) <= (d_next(0) and Enable) or (q(0) and (not Enable));
    d(1) <= (d_next(1) and Enable) or (q(1) and (not Enable));
    d(2) <= (d_next(2) and Enable) or (q(2) and (not Enable));

    -- Output Logic
    Match <= s6;
    State <= q;

end Structural;
