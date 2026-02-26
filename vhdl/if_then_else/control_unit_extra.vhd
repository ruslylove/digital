library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_extra is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        A_eq_5  : in  std_logic; -- Status from Datapath
        sel_A5  : out std_logic; -- Control to MUX
        load_B  : out std_logic; -- Control to Reg B
        en_tri  : out std_logic; -- Control to Tri-state
        done    : out std_logic
    );
end control_unit_extra;

architecture Behavioral of control_unit_extra is
    -- Adding the STABILIZE state to the type definition
    type state_type is ( INPUT_A, STABILIZE, B_8, B_13, OUTPUT_B);
    signal state : state_type;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= INPUT_A;
        elsif rising_edge(clk) then
            case state is
                when INPUT_A =>
                    -- In this state, we are sampling A. 
                    -- We move to STABILIZE to let the comparator logic settle.
                    state <= STABILIZE;

                when STABILIZE =>
                    -- Now we make the decision based on A_eq_5
                    if A_eq_5 = '1' then
                        state <= B_8;
                    else
                        state <= B_13;
                    end if;
                
                when B_8 | B_13 =>
                    state <= OUTPUT_B;
                
                when OUTPUT_B =>
                    state <= INPUT_A;
            end case;
        end if;
    end process;

    -- Output Logic (Combinational based on current state)
    process(state)
    begin
        -- Default values (Inactive)
        sel_A5 <= '0';
        load_B <= '0';
        en_tri <= '0';
        done   <= '0';

        case state is
            when B_8 =>
                sel_A5 <= '1'; -- Tell MUX to pick 8
                load_B <= '1'; -- Pulse the register load
            when B_13 =>
                sel_A5 <= '0'; -- Tell MUX to pick 13
                load_B <= '1'; -- Pulse the register load
            when OUTPUT_B =>
                en_tri <= '1'; -- Turn on the tri-state buffer
                done   <= '1';
            when others =>
                null;
        end case;
    end process;
end Behavioral;