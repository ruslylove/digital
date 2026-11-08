process(clk, reset)
begin
  if reset = '1' then -- Async Reset
    Q <= '0';
  elsif rising_edge(clk) then
    Q <= D;
  end if;
end process;
