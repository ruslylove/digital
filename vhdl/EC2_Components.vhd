library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package EC2_Components is
    component d_ff
        port(clk, reset, d : in std_logic; q : out std_logic);
    end component;
    component Reg8
        port(clk, reset, load: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
    end component;
    component Reg5
        port(clk, reset, load: in std_logic; D: in std_logic_vector(4 downto 0); Q: out std_logic_vector(4 downto 0));
    end component;
    component Mux2_5
        port(sel: in std_logic; I0, I1: in std_logic_vector(4 downto 0); Y: out std_logic_vector(4 downto 0));
    end component;
    component Mux2_8
        port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component Mux4_8
        port(sel: in std_logic_vector(1 downto 0); I0, I1, I2, I3: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component Inc5
        port(A: in std_logic_vector(4 downto 0); Y: out std_logic_vector(4 downto 0));
    end component;
    component Alu8
        port(A, B: in std_logic_vector(7 downto 0); Sub: in std_logic; Y: out std_logic_vector(7 downto 0));
    end component;
    component ZeroCheck8
        port(A: in std_logic_vector(7 downto 0); is_zero: out std_logic);
    end component;
    component PosCheck8
        port(A: in std_logic_vector(7 downto 0); is_pos: out std_logic);
    end component;
    component ram32x8
        port(
            clk : in std_logic;
            we  : in std_logic;
            addr: in std_logic_vector(4 downto 0);
            din : in std_logic_vector(7 downto 0);
            dout: out std_logic_vector(7 downto 0)
        );
    end component;
end EC2_Components;

package body EC2_Components is
end EC2_Components;

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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 5-bit Register
entity Reg5 is
    port(clk, reset, load: in std_logic; D: in std_logic_vector(4 downto 0); Q: out std_logic_vector(4 downto 0));
end Reg5;
architecture Behavioral of Reg5 is begin
    process(clk, reset) begin
        if reset='1' then Q <= (others=>'0');
        elsif rising_edge(clk) then if load='1' then Q <= D; end if; end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 2-to-1 Mux (5-bit)
entity Mux2_5 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(4 downto 0); Y: out std_logic_vector(4 downto 0));
end Mux2_5;
architecture Behavioral of Mux2_5 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 2-to-1 Mux (8-bit)
entity Mux2_8 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Mux2_8;
architecture Behavioral of Mux2_8 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 4-to-1 Mux (8-bit)
entity Mux4_8 is
    port(sel: in std_logic_vector(1 downto 0); I0, I1, I2, I3: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Mux4_8;
architecture Behavioral of Mux4_8 is begin
    with sel select
        Y <= I0 when "00",
             I1 when "01",
             I2 when "10",
             I3 when "11",
             (others => 'X') when others;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 5-bit Incrementer
entity Inc5 is
    port(A: in std_logic_vector(4 downto 0); Y: out std_logic_vector(4 downto 0));
end Inc5;
architecture Behavioral of Inc5 is begin
    Y <= A + 1;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- ALU 8-bit (Add/Sub)
entity Alu8 is
    port(A, B: in std_logic_vector(7 downto 0); Sub: in std_logic; Y: out std_logic_vector(7 downto 0));
end Alu8;
architecture Behavioral of Alu8 is begin
    process(A, B, Sub)
    begin
        if Sub = '1' then
            Y <= A - B;
        else
            Y <= A + B;
        end if;
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Zero Check
entity ZeroCheck8 is
    port(A: in std_logic_vector(7 downto 0); is_zero: out std_logic);
end ZeroCheck8;
architecture Behavioral of ZeroCheck8 is begin
    is_zero <= '1' when A = "00000000" else '0';
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Positive Check (MSB = 0)
entity PosCheck8 is
    port(A: in std_logic_vector(7 downto 0); is_pos: out std_logic);
end PosCheck8;
architecture Behavioral of PosCheck8 is begin
    is_pos <= not A(7); -- Positive if MSB is 0 (includes 0)
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- RAM 32x8
entity ram32x8 is
    port(
        clk : in std_logic;
        we  : in std_logic;
        addr: in std_logic_vector(4 downto 0);
        din : in std_logic_vector(7 downto 0);
        dout: out std_logic_vector(7 downto 0)
    );
end ram32x8;

architecture Behavioral of ram32x8 is
    type ram_type is array (0 to 31) of std_logic_vector(7 downto 0);
    signal RAM : ram_type := (
        0 => x"1E", 1 => x"7F", 2 => x"AA", 3 => x"C8", -- Input inputs at 30,31.
        4 => x"1F", 5 => x"7E", 6 => x"3F", 7 => x"C0",
        8 => x"3E", 9 => x"C0", 10 => x"E0",
        30 => x"0F", 31 => x"19", -- Inputs: 15 and 25
        others => x"00"
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                RAM(conv_integer(addr)) <= din;
            end if;
        end if;
    end process;
    dout <= RAM(conv_integer(addr));
end Behavioral;
