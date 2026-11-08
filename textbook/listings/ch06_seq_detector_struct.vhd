library ieee;
use ieee.std_logic_1164.all;

-- D flip-flop with asynchronous reset (used as a component)
entity d_ff_r is
  port (D, clk, rst : in  std_logic;
        Q           : out std_logic);
end d_ff_r;

architecture behavioral of d_ff_r is
begin
  process (clk, rst)
  begin
    if rst = '1' then
      Q <= '0';
    elsif rising_edge(clk) then
      Q <= D;
    end if;
  end process;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_s is
  port (clk, reset : in  std_logic;
        x          : in  std_logic;
        y          : out std_logic);
end sequence_detector_s;

architecture structural of sequence_detector_s is
  component d_ff_r
    port (D, clk, rst : in  std_logic;
          Q           : out std_logic);
  end component;
  signal A, B     : std_logic;                  -- state variables
  signal D_A, D_B : std_logic;                  -- next-state logic
begin
  FF_A : d_ff_r port map (D => D_A, clk => clk, rst => reset, Q => A);
  FF_B : d_ff_r port map (D => D_B, clk => clk, rst => reset, Q => B);

  D_A <= B and (not x);                         -- D_A = B x'
  D_B <= x;                                     -- D_B = x
  y   <= A and x;                               -- y   = A x   (Mealy output)
end structural;
