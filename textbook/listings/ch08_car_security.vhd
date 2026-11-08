library ieee;
use ieee.std_logic_1164.all;

entity Car_Security is
    Port ( clk, reset : in std_logic;
           M, D, V : in std_logic;
           A : out std_logic);
end Car_Security;

architecture Behavioral of Car_Security is
    type state_type is (No_Siren, Siren);
    signal current_state, next_state : state_type;
begin
    -- State Register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= No_Siren;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State and Output Logic
    process(current_state, M, D, V)
    begin
        -- Default assignments
        next_state <= current_state; 
        A <= '0';
        
        case current_state is
            when No_Siren =>
                if M='1' and (D='1' or V='1') then 
                    next_state <= Siren; 
                end if;
            when Siren =>
                A <= '1';
                if M='0' then 
                    next_state <= No_Siren; 
                end if;
        end case;
    end process;
end Behavioral;
