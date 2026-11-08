library ieee;
use ieee.std_logic_1164.all;

entity Elevator_Mealy is
    Port ( clk, reset : in std_logic;
           f1, f2, at1, at2 : in std_logic;
           go1, go0, led1, led2 : out std_logic);
end Elevator_Mealy;

architecture Behavioral of Elevator_Mealy is
    type state_type is (Floor1, Floor2);
    signal current_state, next_state : state_type;
begin
    -- State Register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= Floor1;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State and Output Logic
    process(current_state, f1, f2, at1, at2)
    begin
        -- Defaults
        next_state <= current_state;
        go1 <= '0'; go0 <= '0'; -- Motor Off
        led1 <= '0'; led2 <= '0';
        
        case current_state is
            when Floor1 =>
                led1 <= '1';
                if f2 = '1' then
                    go1 <= '1'; go0 <= '1'; -- Move Up
                    if at2 = '1' then
                        next_state <= Floor2;
                    end if;
                end if;
                
            when Floor2 =>
                led2 <= '1';
                if f1 = '1' then
                    go1 <= '1'; go0 <= '0'; -- Move Down
                    if at1 = '1' then
                        next_state <= Floor1;
                    end if;
                end if;
        end case;
    end process;
end Behavioral;
