library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC2_Components.ALL;

entity EC2_Datapath is
    Port ( clk, reset : in STD_LOGIC;
           input_bus : in STD_LOGIC_VECTOR(7 downto 0);
           IRload, PCload, MemInst, MemWr : in STD_LOGIC;
           Asel : in STD_LOGIC_VECTOR(1 downto 0);
           Aload, Sub, JMPmux : in STD_LOGIC;
           opcode : out STD_LOGIC_VECTOR(2 downto 0);
           Zero_Flag : out STD_LOGIC;
           Pos_Flag : out STD_LOGIC;
           A_out_bus : out STD_LOGIC_VECTOR(7 downto 0);
           dbg_PC : out STD_LOGIC_VECTOR(4 downto 0);
           dbg_IR : out STD_LOGIC_VECTOR(7 downto 0));
end EC2_Datapath;

architecture Structural of EC2_Datapath is
    signal IR_out, A_out, A_in : std_logic_vector(7 downto 0);
    signal RAM_out, ALU_out : std_logic_vector(7 downto 0);
    signal PC_out, PC_in, PC_inc : std_logic_vector(4 downto 0);
    signal Mem_Addr : std_logic_vector(4 downto 0);

begin
    -- Program Counter Logic
    PC_Inc_Unit: Inc5 port map(PC_out, PC_inc);
    PC_Mux: Mux2_5 port map(JMPmux, PC_inc, IR_out(4 downto 0), PC_in);
    PC_Reg: Reg5 port map(clk, reset, PCload, PC_in, PC_out);

    -- Memory Address Mux (PC vs IR address)
    Mem_Addr_Mux: Mux2_5 port map(MemInst, PC_out, IR_out(4 downto 0), Mem_Addr);

    -- RAM
    RAM_Unit: ram32x8 port map(
        clk => clk,
        we => MemWr,
        addr => Mem_Addr,
        din => A_out,
        dout => RAM_out
    );

    -- Instruction Register
    -- Loads from RAM output (which is Instruction during Fetch)
    IR_Reg: Reg8 port map(clk, reset, IRload, RAM_out, IR_out);
    opcode <= IR_out(7 downto 5);

    -- ALU
    ALU_Unit: Alu8 port map(A_out, RAM_out, Sub, ALU_out);

    -- Accumulator Logic
    -- Mux4_8: 00=RAM, 01=ALU, 10=Input, 11=X
    Acc_Mux: Mux4_8 port map(Asel, RAM_out, ALU_out, input_bus, "00000000", A_in);
    Acc_Reg: Reg8 port map(clk, reset, Aload, A_in, A_out);

    -- Flags
    ZC: ZeroCheck8 port map(A_out, Zero_Flag);
    PC_Check: PosCheck8 port map(A_out, Pos_Flag);

    -- Outputs
    A_out_bus <= A_out;
    dbg_PC <= PC_out;
    dbg_IR <= IR_out;

end Structural;
