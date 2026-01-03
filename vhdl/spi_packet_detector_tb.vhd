library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity spi_packet_detector_tb is
end spi_packet_detector_tb;

architecture Behavioral of spi_packet_detector_tb is

    -- Component Declaration
    component spi_packet_detector
        Port ( MOSI     : in  STD_LOGIC;
               SCLK     : in  STD_LOGIC;
               CS       : in  STD_LOGIC;
               CLK      : in  STD_LOGIC;
               Detected : out STD_LOGIC;
               State    : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    -- Signals
    signal MOSI     : STD_LOGIC := '0';
    signal SCLK     : STD_LOGIC := '0';
    signal CS       : STD_LOGIC := '1'; -- Active Low, start in Reset (High)
    signal CLK      : STD_LOGIC := '0';
    signal Detected : STD_LOGIC;
    signal State    : STD_LOGIC_VECTOR(2 downto 0);

    -- Clock period definitions
    constant CLK_period : time := 20 ns; -- 50 MHz
    constant SCLK_period : time := 200 ns; -- 5 MHz

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: spi_packet_detector
        port map (
            MOSI     => MOSI,
            SCLK     => SCLK,
            CS       => CS,
            CLK      => CLK,
            Detected => Detected,
            State    => State
        );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
        
        -- Helper procedure to send one bit via SPI
        procedure send_bit(
            data_bit : in std_logic
        ) is
        begin
            MOSI <= data_bit;
            wait for SCLK_period/4; -- Setup
            SCLK <= '1'; -- Rising edge (sampling happens here in detector)
            wait for SCLK_period/2;
            SCLK <= '0';
            wait for SCLK_period/4; -- Hold
        end procedure;

        -- Helper procedure to send full byte/sequence
        procedure send_sequence(
            seq_data : in std_logic_vector(5 downto 0) -- 6 bits for 101011
        ) is
        begin
            for i in 5 downto 0 loop
                send_bit(seq_data(i));
            end loop;
        end procedure;

    begin
        -- Hold Reset for 100 ns
        CS <= '1';
        wait for 100 ns;
        
        CS <= '0'; -- Release Reset (Active Low)
        wait for CLK_period*10;

        ------------------------------------------------------------
        -- Test Case 1: Valid Sequence (101011)
        ------------------------------------------------------------
        report "Test Case 1: Sending Valid Sequence 101011";
        
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('1');
        
        wait for CLK_period*4; -- Wait for detection logic
        
        assert Detected = '1' 
            report "Error: Sequence 101011 failed to trigger Detected signal." 
            severity error;
            
        if Detected = '1' then
            report "Pass: Sequence 101011 detected successfully.";
        end if;
        
        wait for SCLK_period; 

        ------------------------------------------------------------
        -- Reset between tests
        ------------------------------------------------------------
        CS <= '1';
        wait for SCLK_period;
        CS <= '0';
        wait for SCLK_period;

        ------------------------------------------------------------
        -- Test Case 2: Invalid Sequence (101010) - Last bit wrong
        ------------------------------------------------------------
        report "Test Case 2: Sending Invalid Sequence 101010";
        
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('0'); -- Wrong bit
        
        wait for CLK_period*4;
        
        assert Detected = '0' 
            report "Error: Sequence 101010 incorrectly triggered Detected signal." 
            severity error;
            
        wait for SCLK_period; 

        ------------------------------------------------------------
        -- Reset between tests
        ------------------------------------------------------------
        CS <= '1';
        wait for SCLK_period;
        CS <= '0';
        wait for SCLK_period;

        ------------------------------------------------------------
        -- Test Case 3: Overlapping/Embedded Sequence (000 101011)
        ------------------------------------------------------------
        report "Test Case 3: Sending Valid Sequence with preamble 000101011";
        
        send_bit('0');
        send_bit('0');
        send_bit('0'); -- Noise
        
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('0');
        send_bit('1');
        send_bit('1');
        
        wait for CLK_period*4;
        
        assert Detected = '1' 
            report "Error: Embedded Sequence 101011 failed." 
            severity error;

        ------------------------------------------------------------
        -- End of Test
        ------------------------------------------------------------
        report "Simulation Completed Successfully";
        wait;
        
    end process;

end Behavioral;
