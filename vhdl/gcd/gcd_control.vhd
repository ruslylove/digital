library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gcd_control is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           
           -- Status Signals
           XeqY     : in  STD_LOGIC;
           XgtY     : in  STD_LOGIC;
           
           -- Control Signals
           In_X     : out STD_LOGIC;
           In_Y     : out STD_LOGIC;
           XLoad    : out STD_LOGIC;
           YLoad    : out STD_LOGIC;
           XY       : out STD_LOGIC;
           Out_En   : out STD_LOGIC);
end gcd_control;

architecture Behavioral of gcd_control is
    type StateType is (S0, S1, S2, S3, S4);
    signal CurrentState, NextState : StateType;
begin

    -- State Register
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                CurrentState <= S0;
            else
                CurrentState <= NextState;
            end if;
        end if;
    end process;

    -- Next State Logic
    process(CurrentState, XeqY, XgtY)
    begin
        case CurrentState is
            when S0 => -- Init: Load X and Y
                NextState <= S1;
            
            when S1 => -- Check
                if XeqY = '1' then
                    NextState <= S4; -- Done
                elsif XgtY = '1' then
                    NextState <= S2; -- X > Y
                else
                    NextState <= S3; -- Y > X
                end if;
                
            when S2 => -- X = X - Y
                NextState <= S1;
                
            when S3 => -- Y = Y - X
                NextState <= S1;
                
            when S4 => -- Done
                NextState <= S4; -- Stay here until Reset
                
            when others =>
                NextState <= S0;
        end case;
    end process;

    -- Output Logic
    process(CurrentState)
    begin
        -- Default values
        In_X   <= '0';
        In_Y   <= '0';
        XLoad  <= '0';
        YLoad  <= '0';
        XY     <= '0';
        Out_En <= '0';
        
        case CurrentState is
            when S0 => -- Load Inputs
                In_X  <= '1'; -- Select Input
                In_Y  <= '1'; -- Select Input
                XLoad <= '1';
                YLoad <= '1';
            
            when S1 => -- Check (No operation)
                NULL;
                
            when S2 => -- X = X - Y
                XY    <= '0'; -- X-Y
                In_X  <= '0'; -- Select Result
                XLoad <= '1';
                
            when S3 => -- Y = Y - X
                XY    <= '1'; -- Y-X (Swap)
                In_Y  <= '0'; -- Select Result
                YLoad <= '1';
                
            when S4 => -- Output
                Out_En <= '1';
                
            when others =>
                NULL;
        end case;
    end process;

end Behavioral;
