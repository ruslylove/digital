library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer is
    port ( Input   : in  std_logic;
           Control : in  std_logic;
           Output  : out std_logic );
end tri_state_buffer;

architecture behavioral of tri_state_buffer is
begin
    Output <= Input when (Control = '1') else 'Z';
end behavioral;
