library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        A_eq_5  : in  std_logic; -- From Datapath
        sel_A5  : out std_logic;
        load_B  : out std_logic;
        en_tri  : out std_logic;
        done    : out std_logic
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
    type state_type is (INPUT_A, B_8, B_13, OUTPUT_B);
    signal state : state_type;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= INPUT_A;
        elsif rising_edge(clk) then
            case state is
                when INPUT_A =>
                    if A_eq_5 = '1' then
                        state <= B_8;
                    else
                        state <= B_13;
                    end if;
                
                when B_8 | B_13 =>
                    state <= OUTPUT_B;
                
                when OUTPUT_B =>
                    state <= INPUT_A; -- Loop back or IDLE
            end case;
        end if;
    end process;

    -- Control Signal Assignments
    sel_A5 <= '1' when state = B_8 else '0';
    load_B <= '1' when (state = B_8 or state = B_13) else '0';
    en_tri <= '1' when state = OUTPUT_B else '0';
    done   <= '1' when state = OUTPUT_B else '0';
end Behavioral;