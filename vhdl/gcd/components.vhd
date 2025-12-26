library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package gcd_components is
    
    component mux_2to1_8bit
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (7 downto 0);
               B   : in  STD_LOGIC_VECTOR (7 downto 0);
               Y   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component reg_8bit
        Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Reset : in  STD_LOGIC;
               Clk   : in  STD_LOGIC;
               Load  : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component subtractor_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               Diff : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component comparator_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               AeqB : out STD_LOGIC;
               AgtB : out STD_LOGIC);
    end component;

    component tristate_buffer_8bit
        Port ( Input  : in  STD_LOGIC_VECTOR (7 downto 0);
               Enable : in  STD_LOGIC;
               Output : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

end gcd_components;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- MUX 2:1 Implementation
entity mux_2to1_8bit is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (7 downto 0);
           Y   : out STD_LOGIC_VECTOR (7 downto 0));
end mux_2to1_8bit;

architecture Behavioral of mux_2to1_8bit is
begin
    Y <= A when SEL = '0' else B;
end Behavioral;

-- Register Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_8bit is
    Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Reset : in  STD_LOGIC;
               Clk   : in  STD_LOGIC;
               Load  : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
end reg_8bit;

architecture Behavioral of reg_8bit is
signal storage : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                storage <= (others => '0');
            elsif Load = '1' then
                storage <= D;
            end if;
        end if;
    end process;
    Q <= storage;
end Behavioral;

-- Subtractor Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor_8bit is
    Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
           B    : in  STD_LOGIC_VECTOR (7 downto 0);
           Diff : out STD_LOGIC_VECTOR (7 downto 0));
end subtractor_8bit;

architecture Behavioral of subtractor_8bit is
begin
    Diff <= std_logic_vector(unsigned(A) - unsigned(B));
end Behavioral;

-- Comparator Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator_8bit is
    Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
           B    : in  STD_LOGIC_VECTOR (7 downto 0);
           AeqB : out STD_LOGIC;
           AgtB : out STD_LOGIC);
end comparator_8bit;

architecture Behavioral of comparator_8bit is
begin
    AeqB <= '1' when unsigned(A) = unsigned(B) else '0';
    AgtB <= '1' when unsigned(A) > unsigned(B) else '0';
end Behavioral;

-- Tristate Buffer Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tristate_buffer_8bit is
    Port ( Input  : in  STD_LOGIC_VECTOR (7 downto 0);
           Enable : in  STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end tristate_buffer_8bit;

architecture Behavioral of tristate_buffer_8bit is
begin
    Output <= Input when Enable = '1' else (others => 'Z');
end Behavioral;
