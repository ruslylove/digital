library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Structural implementation of Edge Detector FSM
-- States: Zero (00), Pulse (01), One (10)
-- State encoding: S1, S0
-- Zero: 00
-- Pulse: 01
-- One: 10

entity sclk_edge_detector is
    Port ( SCLK     : in  STD_LOGIC;
           CLK      : in  STD_LOGIC; -- System CLK
           Pulse    : out STD_LOGIC);
end sclk_edge_detector;

architecture Structural of sclk_edge_detector is

    component d_ff
        Port ( D, CLK, CLR : in STD_LOGIC;
               Q, Q_bar : out STD_LOGIC);
    end component;

    signal q0, q1 : STD_LOGIC;
    signal q0_bar, q1_bar : STD_LOGIC;
    signal d0, d1 : STD_LOGIC;
    -- Logic signals for Next State Logic
    
begin

    -- State Memory
    ff0: d_ff port map (D => d0, CLK => CLK, CLR => '0', Q => q0, Q_bar => q0_bar);
    ff1: d_ff port map (D => d1, CLK => CLK, CLR => '0', Q => q1, Q_bar => q1_bar);

    -- Next State Logic (Derived from State Diagram)
    -- State Encoding:
    -- Zero (S0): q1=0, q0=0
    -- Pulse (S1): q1=0, q0=1
    -- One (S2): q1=1, q0=0
    
    -- Transitions:
    -- Zero (00) -> Pulse (01) if SCLK=1
    -- Pulse (01) -> One (10) if SCLK=1
    -- Pulse (01) -> Zero (00) if SCLK=0
    -- One (10) -> One (10) if SCLK=1
    -- One (10) -> Zero (00) if SCLK=0
    
    -- Equations:
    -- D0 (Next q0): High only for transition to Pulse (01) from Zero (00)
    -- D0 = (not q1) and (not q0) and SCLK
    d0 <= (not q1) and (not q0) and SCLK;
    
    -- D1 (Next q1): High for transition to One (10) from Pulse (01) OR Hold One (10)
    -- D1 = (not q1 and q0 and SCLK) OR (q1 and not q0 and SCLK)
    -- Simplified: D1 = (q0 or q1) and SCLK
    -- Actually, check logic:
    -- From Pulse (01) & SCLK=1 -> One (10) => D1=1, D0=0
    -- From One (10) & SCLK=1 -> One (10) => D1=1, D0=0
    d1 <= ((not q1) and q0 and SCLK) or (q1 and (not q0) and SCLK);

    -- Output Logic
    -- Pulse output is high ONLY in Pulse state (01)
    Pulse <= (not q1) and q0;

end Structural;
