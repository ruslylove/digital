library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gcd_fsmd is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           InputX   : in  UNSIGNED(7 downto 0);
           InputY   : in  UNSIGNED(7 downto 0);
           Output   : out UNSIGNED(7 downto 0));
end gcd_fsmd;

architecture Behavioral of gcd_fsmd is
    type StateType is (S0, S1, S2, S3, S4);
    signal State : StateType;
    signal X, Y  : UNSIGNED(7 downto 0);
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                State <= S0;
                Output <= (others => '0');
            else
                case State is
                    when S0 =>  -- Init
                        X <= InputX; Y <= InputY;
                        State <= S1;
                    when S1 =>  -- Check
                        if (X = Y) then State <= S4;
                        elsif (X > Y) then State <= S2;
                        else State <= S3;
                        end if;
                    when S2 =>  -- X = X - Y
                        X <= X - Y;
                        State <= S1;
                    when S3 =>  -- Y = Y - X
                        Y <= Y - X;
                        State <= S1;
                    when S4 =>  -- Done
                        Output <= X;
                end case;
            end if; 
        end if; 
    end process; 

end Behavioral;
