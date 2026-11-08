library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector is
  port (clk, reset : in  std_logic;
        x          : in  std_logic;
        y          : out std_logic);
end sequence_detector;

architecture fsm of sequence_detector is
  type state_type is (S0, S1, S2);
  signal current_state, next_state : state_type;
begin
  -- state register (sequential part)
  process (clk, reset)
  begin
    if reset = '1' then
      current_state <= S0;
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;

  -- next-state and output logic (combinational part)
  process (current_state, x)
  begin
    y <= '0';                                   -- default output
    case current_state is
      when S0 => if x = '1' then next_state <= S1; else next_state <= S0; end if;
      when S1 => if x = '0' then next_state <= S2; else next_state <= S1; end if;
      when S2 => if x = '1' then y <= '1'; next_state <= S1;
                 else next_state <= S0; end if;
    end case;
  end process;
end fsm;
