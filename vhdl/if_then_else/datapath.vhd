library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath_Structural is
    Port (
        clk      : in  std_logic;
        A        : in  unsigned(3 downto 0);
        sel_A5   : in  std_logic; -- Selects MUX path
        load_B   : in  std_logic; -- Enables Register B
        en_tri   : in  std_logic; -- Enables Tri-state output
        A_eq_5   : out std_logic; -- Feedback to CU
        Bus_Out  : out std_logic_vector(3 downto 0)
    );
end Datapath_Structural;

architecture Structural of Datapath_Structural is
    signal mux_out : unsigned(3 downto 0);
    signal reg_b   : unsigned(3 downto 0);
begin
    -- Comparator logic
    A_eq_5 <= '1' when A = 5 else '0';

    -- MUX: 4-bit selection between 8 (1000) and 13 (1101)
    mux_out <= "1000" when sel_A5 = '1' else "1101";

    -- Register B
    process(clk)
    begin
        if rising_edge(clk) then
            if load_B = '1' then
                reg_b <= mux_out;
            end if;
        end if;
    end process;

    -- Tri-state Buffer (Output B)
    Bus_Out <= std_logic_vector(reg_b) when en_tri = '1' else (others => 'Z');

end Structural;