library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Elevator_Moore is
    Port ( clk, reset : in std_logic;
           f1, f2, at1, at2 : in std_logic;
           go1, go0, led1, led2 : out std_logic);
end Elevator_Moore;

architecture Behavioral of Elevator_Moore is
    type state_type is (Floor1, MovingUp, Floor2, MovingDown);
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
                    next_state <= MovingUp;
                end if;
                
            when MovingUp =>
                go1 <= '1'; go0 <= '1'; -- Move Up
                if at2 = '1' then
                    next_state <= Floor2;
                end if;
                
            when Floor2 =>
                led2 <= '1';
                if f1 = '1' then
                    next_state <= MovingDown;
                end if;
                
            when MovingDown =>
                go1 <= '1'; go0 <= '0'; -- Move Down
                if at1 = '1' then
                    next_state <= Floor1;
                end if;
        end case;
    end process;
end Behavioral;
