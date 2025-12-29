library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC2_Components.ALL;

entity EC2_Control_Unit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           opcode : in STD_LOGIC_VECTOR (2 downto 0);
           Zero_Flag : in STD_LOGIC;
           Pos_Flag : in STD_LOGIC;
           IRload : out STD_LOGIC;
           PCload : out STD_LOGIC;
           MemInst : out STD_LOGIC;
           MemWr : out STD_LOGIC;
           Asel : out STD_LOGIC_VECTOR(1 downto 0);
           Aload : out STD_LOGIC;
           Sub : out STD_LOGIC;
           JMPmux : out STD_LOGIC;
           Halt : out STD_LOGIC;
           dbg_state : out STD_LOGIC_VECTOR(3 downto 0));
end EC2_Control_Unit;

architecture Structural of EC2_Control_Unit is
    signal Q, D : std_logic_vector(3 downto 0);
    signal Q3_n, Q2_n, Q1_n, Q0_n : std_logic;
    
    -- States
    signal state_Fetch, state_Decode : std_logic;
    signal state_Load, state_Store, state_Add, state_Sub : std_logic;
    signal state_In, state_Jz, state_Jpos, state_Halt : std_logic;
    
begin
    -- State Registers
    FF3: d_ff port map(clk, reset, D(3), Q(3));
    FF2: d_ff port map(clk, reset, D(2), Q(2));
    FF1: d_ff port map(clk, reset, D(1), Q(1));
    FF0: d_ff port map(clk, reset, D(0), Q(0));
    
    Q3_n <= not Q(3); Q2_n <= not Q(2); Q1_n <= not Q(1); Q0_n <= not Q(0);

    -- State Decoders (Binary Encoding)
    -- 0000 Fetch
    -- 0001 Decode
    -- 0010 Load
    -- 0011 Store
    -- 0100 Add
    -- 0101 Sub
    -- 0110 In
    -- 0111 Jz
    -- 1000 Jpos
    -- 1001 Halt
    
    state_Fetch  <= Q3_n and Q2_n and Q1_n and Q0_n; -- 0000
    state_Decode <= Q3_n and Q2_n and Q1_n and Q(0); -- 0001
    state_Load   <= Q3_n and Q2_n and Q(1) and Q0_n; -- 0010
    state_Store  <= Q3_n and Q2_n and Q(1) and Q(0); -- 0011
    state_Add    <= Q3_n and Q(2) and Q1_n and Q0_n; -- 0100
    state_Sub    <= Q3_n and Q(2) and Q1_n and Q(0); -- 0101
    state_In     <= Q3_n and Q(2) and Q(1) and Q0_n; -- 0110
    state_Jz     <= Q3_n and Q(2) and Q(1) and Q(0); -- 0111
    state_Jpos   <= Q(3) and Q2_n and Q1_n and Q0_n; -- 1000
    state_Halt   <= Q(3) and Q2_n and Q1_n and Q(0); -- 1001
    
    -- Next State Logic
    -- From Fetch (0000) -> Decode (0001)
    
    -- From Decode (0001) -> Specific State based on Opcode
    -- Op 000 (Load) -> 0010
    -- Op 001 (Store) -> 0011
    -- Op 010 (Add) -> 0100
    -- Op 011 (Sub) -> 0101
    -- Op 100 (In) -> 0110
    -- Op 101 (Jz) -> 0111
    -- Op 110 (Jpos) -> 1000
    -- Op 111 (Halt) -> 1001

    -- D3: 1 if (Decode & Op=JPOS) OR (Decode & Op=HALT) OR Halt (Loop)
    -- Op codes: JPOS(110), HALT(111). Common: Op(2) & Op(1)
    D(3) <= (state_Decode and opcode(2) and opcode(1)) or state_Halt;

    -- D2: 1 if (Decode & Op=Add/Sub/In/Jz) OR (Exec states returning to Fetch?? No, return is 0000)
    -- Wait, Exec states just go to 0000. So ONLY Decode sets D to high values.
    -- Ops: 010, 011, 100, 101. Common: Op(2)^Op(1)?
    -- Let's just sum the cases for D(2) logic from Decode
    -- Load(0010), Store(0011) -> D2=0
    -- Add(0100), Sub(0101), In(0110), Jz(0111) -> D2=1
    D(2) <= state_Decode and ( (not opcode(2) and opcode(1)) or (opcode(2) and not opcode(1)) );

    -- D1: 1 if (Decode & Op=Load/Store/In/Jz)
    -- Ops: 000, 001 (No), 010, 011 (No) -> Wait.
    -- Load(0010) - D1=1
    -- Store(0011) - D1=1
    -- Add(0100) - D1=0
    -- Sub(0101) - D1=0
    -- In(0110) - D1=1
    -- Jz(0111) - D1=1
    -- Jpos(1000) - D1=0
    D(1) <= state_Decode and ( (not opcode(2) and not opcode(1)) or (opcode(2) and not opcode(1) and opcode(0)) or (opcode(2) and opcode(1) and not opcode(0) and opcode(0)) ); 
    -- Simplification:
    -- D1 is high for 0010, 0011, 0110, 0111.
    -- Binary x010, x011, x110, x111 -> D1=1
    -- No, State is D3 D2 D1 D0.
    -- 0010 Load -> Op 000. Op(2)=0, Op(1)=0.
    -- 0011 Store -> Op 001. Op(2)=0, Op(1)=0.
    -- 0110 In -> Op 100. Op(2)=1, Op(1)=0.
    -- 0111 Jz -> Op 101. Op(2)=1, Op(1)=0.
    -- So logic: Decode and (Op(1)=0) ? No, store is 001. 
    -- Let's stick to basics:
    -- D1 targets states: 0010, 0011, 0110, 0111.
    -- Corresponds to Opcodes: 000, 001, 100, 101.
    -- Common feature: Op(1)=0.
    D(1) <= state_Decode and (not opcode(1));

    -- D0: 1 if Fetch (to go to Decode 0001) OR (Decode & Op=Store/Sub/Jz/Halt)
    -- States with D0=1: Decode(0001), Store(0011), Sub(0101), Jz(0111), Halt(1001)
    -- Opcodes: 001, 011, 101, 111.
    -- Common feature: Op(0)=1.
    D(0) <= state_Fetch or (state_Decode and opcode(0)) or state_Halt;


    -- Output Logic
    
    IRload <= state_Fetch;
    
    -- PCload: Fetch OR (Jz AND Zero) OR (Jpos AND Pos)
    PCload <= state_Fetch or (state_Jz and Zero_Flag) or (state_Jpos and Pos_Flag);
    
    -- JMPmux: 1 for Jz/Jpos, 0 for Fetch (Inc)
    JMPmux <= state_Jz or state_Jpos;
    
    -- MemInst: 1 for Load/Store/Add/Sub
    MemInst <= state_Load or state_Store or state_Add or state_Sub;
    
    -- MemWr: 1 for Store
    MemWr <= state_Store;
    
    -- Asel: 00=Mem(Load), 01=ALU(Add/Sub), 10=In, 11=X
    -- Bit 1: In(0110)? No.
    -- Asel(1) = State_In
    -- Asel(0) = State_Add or State_Sub
    Asel(1) <= state_In;
    Asel(0) <= state_Add or state_Sub;
    
    -- Aload: Load, Add, Sub, In
    Aload <= state_Load or state_Add or state_Sub or state_In;
    
    -- Sub: 1 for Sub
    Sub <= state_Sub;
    
    -- Halt
    Halt <= state_Halt;
    
    dbg_state <= Q;

end Structural;
