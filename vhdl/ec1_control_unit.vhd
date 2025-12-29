library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity EC1_Control_Unit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           opcode : in STD_LOGIC_VECTOR (2 downto 0);
           A_neq_0 : in STD_LOGIC;
           IRload : out STD_LOGIC;
           PCload : out STD_LOGIC;
           INmux : out STD_LOGIC;
           Aload : out STD_LOGIC;
           JNZmux : out STD_LOGIC;
           OutE : out STD_LOGIC;
           Halt : out STD_LOGIC;
           dbg_state : out STD_LOGIC_VECTOR(2 downto 0));
end EC1_Control_Unit;

architecture Structural of EC1_Control_Unit is
    signal Q, D : std_logic_vector(2 downto 0);
    signal Q2_n, Q1_n, Q0_n : std_logic;
    signal state_Fetch, state_Decode, state_Halt : std_logic;
    signal state_Input, state_Output, state_Dec, state_JNZ, state_Wait : std_logic;
    
begin
    -- State Registers
    FF2: d_ff port map(clk, reset, D(2), Q(2));
    FF1: d_ff port map(clk, reset, D(1), Q(1));
    FF0: d_ff port map(clk, reset, D(0), Q(0));
    
    Q2_n <= not Q(2); Q1_n <= not Q(1); Q0_n <= not Q(0);

    -- State Decoders
    state_Fetch <= Q2_n and Q1_n and Q0_n;   -- 000
    state_Decode <= Q2_n and Q1_n and Q(0);  -- 001
    state_Wait <= Q2_n and Q(1) and Q0_n;    -- 010 (New)
    state_Input <= Q2_n and Q(1) and Q(0);   -- 011
    state_Output <= Q(2) and Q1_n and Q0_n;  -- 100
    state_Dec <= Q(2) and Q1_n and Q(0);     -- 101
    state_JNZ <= Q(2) and Q(1) and Q0_n;     -- 110
    state_Halt <= Q(2) and Q(1) and Q(0);    -- 111

    -- Next State Logic
    -- D2 = Decode * O2 + Halt
    D(2) <= (state_Decode and opcode(2)) or state_Halt;
    
    -- D1 = Decode * O1 * (O2 + O0) + Halt + JNZ (Go to Wait logic: 110 -> 010)
    -- If in JNZ (110), we want next state to be Wait (010).
    -- Wait (010) next state is Fetch (000), which happens naturally as D=000.
    D(1) <= (state_Decode and opcode(1) and (opcode(2) or opcode(0))) or state_Halt or state_JNZ;
    
    -- D0 = Fetch + Decode * O0 * (O2 + O1) + Halt
    D(0) <= state_Fetch or (state_Decode and opcode(0) and (opcode(2) or opcode(1))) or state_Halt;

    -- Output Logic
    IRload <= state_Fetch;
    PCload <= state_Fetch or (state_JNZ and A_neq_0);
    INmux <= state_Input;
    Aload <= state_Input or state_Dec;
    JNZmux <= state_JNZ;
    OutE <= state_Output;
    Halt <= state_Halt;

    dbg_state <= Q;

end Structural;
