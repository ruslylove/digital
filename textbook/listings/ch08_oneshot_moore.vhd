library ieee;
use ieee.std_logic_1164.all;

entity One_Shot_Moore is
    Port ( clk, reset : in std_logic;
           B : in std_logic;
           S : out std_logic);
end One_Shot_Moore;

architecture Behavioral of One_Shot_Moore is
    type state_type is (S0, S1, S2);
    signal current_state, next_state : state_type;
begin
    -- State Register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State and Output Logic
    process(current_state, B)
    begin
        -- Default assignments
        next_state <= current_state; 
        S <= '0';
        
        case current_state is
            when S0 => -- Idle
                if B='1' then 
                    next_state <= S1; 
                end if;
            when S1 => -- Pulse
                S <= '1'; -- Moore Output
                next_state <= S2; 
            when S2 => -- Wait
                if B='0' then 
                    next_state <= S0; 
                end if;
        end case;
    end process;
end Behavioral;
