library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package EC1_Components is
    component d_ff
        port(clk, reset, d : in std_logic; q : out std_logic);
    end component;
    component Reg8
        port(clk, reset, load: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
    end component;
    component Reg4
        port(clk, reset, load: in std_logic; D: in std_logic_vector(3 downto 0); Q: out std_logic_vector(3 downto 0));
    end component;
    component Mux2_8
        port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component Mux2_4
        port(sel: in std_logic; I0, I1: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
    end component;
    component Inc4
        port(A: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
    end component;
    component Dec8
        port(A: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component ZeroCheck8
        port(A: in std_logic_vector(7 downto 0); is_not_zero: out std_logic);
    end component;
    component TriBuf8
        port(en: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
    end component;
    component rom32x8
        port(
            address : in std_logic_vector(4 downto 0);
            clock : in std_logic;
            q : out std_logic_vector(7 downto 0)
        );
    end component;
end EC1_Components;

package body EC1_Components is
end EC1_Components;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- D Flip-Flop
entity d_ff is
    port(clk, reset, d : in std_logic; q : out std_logic);
end d_ff;
architecture Behavioral of d_ff is begin
    process(clk, reset) begin
        if reset='1' then q <= '0';
        elsif rising_edge(clk) then q <= d; end if;
    end process;
end Behavioral;

-- 8-bit Register
entity Reg8 is
    port(clk, reset, load: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
end Reg8;
architecture Behavioral of Reg8 is begin
    process(clk, reset) begin
        if reset='1' then Q <= (others=>'0');
        elsif rising_edge(clk) then if load='1' then Q <= D; end if; end if;
    end process;
end Behavioral;

-- 4-bit Register
entity Reg4 is
    port(clk, reset, load: in std_logic; D: in std_logic_vector(3 downto 0); Q: out std_logic_vector(3 downto 0));
end Reg4;
architecture Behavioral of Reg4 is begin
    process(clk, reset) begin
        if reset='1' then Q <= (others=>'0');
        elsif rising_edge(clk) then if load='1' then Q <= D; end if; end if;
    end process;
end Behavioral;

-- 2-to-1 Mux (8-bit)
entity Mux2_8 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Mux2_8;
architecture Behavioral of Mux2_8 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

-- 2-to-1 Mux (4-bit)
entity Mux2_4 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
end Mux2_4;
architecture Behavioral of Mux2_4 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

-- 4-bit Incrementer
entity Inc4 is
    port(A: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
end Inc4;
architecture Behavioral of Inc4 is begin
    Y <= A + 1;
end Behavioral;

-- 8-bit Decrementer
entity Dec8 is
    port(A: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Dec8;
architecture Behavioral of Dec8 is begin
    Y <= A - 1;
end Behavioral;

-- Zero Check
entity ZeroCheck8 is
    port(A: in std_logic_vector(7 downto 0); is_not_zero: out std_logic);
end ZeroCheck8;
architecture Behavioral of ZeroCheck8 is begin
    is_not_zero <= '1' when A /= "00000000" else '0';
end Behavioral;

-- Tri-state Buffer
entity TriBuf8 is
    port(en: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
end TriBuf8;
architecture Behavioral of TriBuf8 is begin
    Q <= D when en='1' else (others=>'Z');
end Behavioral;
