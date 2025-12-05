LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY half_adder IS
    PORT ( 
        X, Y : IN  STD_LOGIC;
        S, C : OUT STD_LOGIC 
    );
END ENTITY half_adder;

ARCHITECTURE dataflow OF half_adder IS
BEGIN
    S <= X XOR Y;
    C <= X AND Y;
END ARCHITECTURE dataflow;
