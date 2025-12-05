library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

-- Top-Level Entity
entity adder_subtractor_4bit is
    port (
        A       : in  std_logic_vector(3 downto 0); -- Input operand A
        B       : in  std_logic_vector(3 downto 0); -- Input operand B
        add_sub : in  std_logic;                    -- Mode control: '0' = Add, '1' = Subtract
        S       : out std_logic_vector(3 downto 0); -- Sum / Difference output
        Cout    : out std_logic                     -- Carry out / Borrow out
    );
end entity adder_subtractor_4bit;

architecture structural of adder_subtractor_4bit is

    -- 1. Component Declaration (Matches ripple_adder_4bit port list)
    component ripple_adder_4bit
        port (
            A       : in  std_logic_vector(3 downto 0);
            B       : in  std_logic_vector(3 downto 0);
            Cin     : in  std_logic;
            S       : out std_logic_vector(3 downto 0);
            Cout    : out std_logic
        );
    end component;

    -- 2. Internal Signals
    -- Signal to hold the modified B input (B XOR add_sub)
    signal B_comp : std_logic_vector(3 downto 0);

begin
    -- ** Logic for Subtraction (2's Complement) **
    
    -- 1. Bitwise XOR Operation (Equivalent to 4 XOR gates)
    -- add_sub='0' -> B_comp = B (Addition)
    -- add_sub='1' -> B_comp = not B (1's Complement)
    B_comp <= B xor (add_sub & add_sub & add_sub & add_sub); 

    -- ** Component Instantiation **
    
    -- 2. Instantiate the 4-bit Ripple Adder
    Adder_Instance : ripple_adder_4bit
        port map (
            A    => A,
            B    => B_comp,        -- Connect the (possibly inverted) B
            Cin  => add_sub,       -- Connect 'add_sub' to Carry_in (for the +1 in 2's complement)
            S    => S,             -- Connect the adder's sum output to the main output
            Cout => Cout           -- Connect the adder's carry-out to the main output
        );

end architecture structural;
