LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- For converting STD_LOGIC_VECTOR to integers for verification

ENTITY tb_cla_16bit_adder IS
END ENTITY tb_cla_16bit_adder;

ARCHITECTURE behavioral OF tb_cla_16bit_adder IS

    -- 1. Component Declaration for the Unit Under Test (UUT)
    COMPONENT cla_16bit_adder
        PORT (
            A, B    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cin     : IN  STD_LOGIC;
            S       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cout    : OUT STD_LOGIC
        );
    END COMPONENT;

    -- 2. Signals for UUT Ports
    SIGNAL A_in, B_in : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Cin_in     : STD_LOGIC := '0';
    SIGNAL S_out      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Cout_out   : STD_LOGIC;

    -- 3. Constants and Helpers
    CONSTANT c_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    UUT: cla_16bit_adder
        PORT MAP (
            A    => A_in,
            B    => B_in,
            Cin  => Cin_in,
            S    => S_out,
            Cout => Cout_out
        );

    -- Test Process
    PROCESS
        -- Function to convert standard logic vectors to unsigned integers for easy calculation
        FUNCTION to_uint(V : STD_LOGIC_VECTOR) RETURN NATURAL IS
            VARIABLE result : NATURAL := 0;
        BEGIN
            FOR i IN V'RANGE LOOP
                IF V(i) = '1' THEN
                    result := result + 2**(i);
                END IF;
            END LOOP;
            RETURN result;
        END FUNCTION to_uint;

        -- Procedure to perform a test and report results
        PROCEDURE run_test (
            A_val    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            B_val    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cin_val  : IN STD_LOGIC
        ) IS
            VARIABLE expected_sum    : NATURAL;
            VARIABLE expected_cout   : STD_LOGIC;
            VARIABLE actual_sum      : NATURAL;
            VARIABLE actual_cout     : STD_LOGIC;
            VARIABLE total_sum       : NATURAL;
            VARIABLE test_passed     : BOOLEAN;
				VARIABLE Cin_int         : NATURAL;
        BEGIN
            -- Apply inputs
            A_in <= A_val;
            B_in <= B_val;
            Cin_in <= Cin_val;

            WAIT FOR c_period; -- Wait for combinational delay

            -- Convert single-bit Cin_val to an integer (0 or 1)
            IF Cin_val = '1' THEN
                Cin_int := 1;
            ELSE
                Cin_int := 0;
            END IF;

            -- Calculate expected values (A + B + Cin)
            -- Use Cin_int (NATURAL) instead of Cin_val (STD_LOGIC)
            total_sum := to_uint(A_val) + to_uint(B_val) + Cin_int;
				
            -- Expected Sum is the lower 16 bits of total_sum
            expected_sum := total_sum MOD 65536; 
            
            -- Expected Cout is '1' if the sum exceeds 16 bits (65535)
            IF total_sum > 65535 THEN
                expected_cout := '1';
            ELSE
                expected_cout := '0';
            END IF;

            -- Read actual outputs
            actual_sum := to_uint(S_out);
            actual_cout := Cout_out;

           
            -- Verification
            test_passed := (actual_sum = expected_sum) AND (actual_cout = expected_cout);
            
            IF test_passed THEN
                REPORT "Result: PASSED" SEVERITY NOTE;
            ELSE
                REPORT "Result: FAILED" SEVERITY ERROR;
            END IF;
            
            WAIT FOR c_period;

        END PROCEDURE run_test;

    BEGIN
        REPORT "Starting 16-bit CLA Testbench..." SEVERITY NOTE;

        -- === Test Cases ===

        -- 1. Simple Addition: 10 + 20 + 0 = 30
        run_test(
            A_val   => X"000A", 
            B_val   => X"0014",
            Cin_val => '0'
        );

        -- 2. Basic Carry-in: FFFF + 0 + 1 = 10000 (S=0, Cout=1)
        run_test(
            A_val   => X"FFFF", 
            B_val   => X"0000",
            Cin_val => '1'
        );

        -- 3. Half Max Value: 7FFF + 7FFF + 0 = FFFE (65534)
        run_test(
            A_val   => X"7FFF", 
            B_val   => X"7FFF",
            Cin_val => '0'
        );
        
        -- 4. Maximum Carry-out: FFFF + FFFF + 1 = 1FFFD (S=FFFD, Cout=1)
        run_test(
            A_val   => X"FFFF", 
            B_val   => X"FFFF",
            Cin_val => '1'
        );
        
        -- 5. Carry Propagation Test (Across a group boundary, e.g., 000F + 0001)
        run_test(
            A_val   => X"000F", 
            B_val   => X"0001",
            Cin_val => '0'
        );

        -- 6. Carry Propagation across all 4 groups (0000 + 0001 propagates)
        run_test(
            A_val   => X"0000",
            B_val   => X"0001",
            Cin_val => '0'
        );
        
        -- 7. Carry Propagation across all 16 bits (FF00 + 0100 = 0000, Cout=1)
        run_test(
            A_val   => X"FF00",
            B_val   => X"0100",
            Cin_val => '0'
        );

        REPORT "All tests complete. Simulation halting." SEVERITY NOTE;
        WAIT; 

    END PROCESS;

END ARCHITECTURE behavioral;
