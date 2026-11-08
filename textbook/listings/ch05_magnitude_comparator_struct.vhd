library ieee;
use ieee.std_logic_1164.all;

entity magnitude_comparator is
    port ( A : in  std_logic_vector(3 downto 0);
           B : in  std_logic_vector(3 downto 0);
           A_Greater_B : out std_logic;
           A_Equal_B : out std_logic;
           A_Less_B : out std_logic );
end magnitude_comparator;

architecture structural of magnitude_comparator is
    signal x : std_logic_vector(3 downto 0);
    signal term0, term1, term2, term3 : std_logic;
    signal A_Greater_B_int, A_Equal_B_int : std_logic;
begin
    -- Equivalence (x_i = A_i XNOR B_i)
    x <= not (A xor B);

    -- Terms for A > B (AND Gates)
    term3 <= A(3) and not B(3);
    term2 <= x(3) and A(2) and not B(2);
    term1 <= x(3) and x(2) and A(1) and not B(1);
    term0 <= x(3) and x(2) and x(1) and A(0) and not B(0);

    -- Output Logic
    A_Greater_B_int <= term3 or term2 or term1 or term0; -- OR Gate
    A_Equal_B_int   <= x(3) and x(2) and x(1) and x(0);  -- AND Gate
    
    -- Final Outputs
    A_Greater_B <= A_Greater_B_int;
    A_Equal_B   <= A_Equal_B_int;
    A_Less_B    <= not (A_Greater_B_int or A_Equal_B_int); -- NOR Gate logic
end structural;
