process(clk)
begin
  if rising_edge(clk) then
    if reset = '1' then -- Sync Reset
        Q <= '0';
    else
        Q <= D;
    end if;
  end if;
end process;
