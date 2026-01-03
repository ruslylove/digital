library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spi_packet_detector is
    Port ( MOSI     : in  STD_LOGIC;
           SCLK     : in  STD_LOGIC;
           CS       : in  STD_LOGIC;
           CLK      : in  STD_LOGIC; -- System 50MHz Clock
           Detected : out STD_LOGIC;
           State    : out STD_LOGIC_VECTOR(2 downto 0)); -- For LED Panel
end spi_packet_detector;

architecture Structural of spi_packet_detector is

    component sclk_edge_detector
        Port ( SCLK  : in  STD_LOGIC;
               CLK   : in  STD_LOGIC;
               Pulse : out STD_LOGIC);
    end component;
    
    component main_fsm
        Port ( MOSI   : in  STD_LOGIC;
               Enable : in  STD_LOGIC;
               CLK    : in  STD_LOGIC;
               CS     : in  STD_LOGIC;
               Match  : out STD_LOGIC;
               State  : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component output_modulator
        Port ( CLK      : in  STD_LOGIC;
               Match    : in  STD_LOGIC;
               Detected : out STD_LOGIC);
    end component;

    -- Internal Signals
    signal sclk_pulse_sig : STD_LOGIC;
    signal match_sig      : STD_LOGIC;

begin

    -- 1. Edge Detector Instance
    u_edge_detector: sclk_edge_detector
    port map (
        SCLK  => SCLK,
        CLK   => CLK,
        Pulse => sclk_pulse_sig
    );
    
    -- 2. Main FSM Instance
    u_main_fsm: main_fsm
    port map (
        MOSI   => MOSI,
        Enable => sclk_pulse_sig,
        CLK    => CLK,
        CS     => CS,
        Match  => match_sig,
        State  => State
    );
    
    -- 3. Output Modulator Instance
    u_modulator: output_modulator
    port map (
        CLK      => CLK,
        Match    => match_sig,
        Detected => Detected
    );

end Structural;
