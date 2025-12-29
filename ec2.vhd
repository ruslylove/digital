library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC2_Components.ALL;

entity ec2 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input_bus : in STD_LOGIC_VECTOR (7 downto 0);
           output_bus : out STD_LOGIC_VECTOR (7 downto 0);
           halt : out STD_LOGIC;
           dbg_opcode : out STD_LOGIC_VECTOR(2 downto 0);
           dbg_PC : out STD_LOGIC_VECTOR(4 downto 0);
           dbg_IR : out STD_LOGIC_VECTOR(7 downto 0);
           dbg_state : out STD_LOGIC_VECTOR(3 downto 0));
end ec2;

architecture Structural of ec2 is
    component EC2_Control_Unit
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
    end component;

    component EC2_Datapath
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
    end component;

    signal opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal Zero_Flag, Pos_Flag : STD_LOGIC;
    signal IRload, PCload, MemInst, MemWr, Aload, Sub, JMPmux, Halt_Sig : STD_LOGIC;
    signal Asel : STD_LOGIC_VECTOR(1 downto 0);
    signal dbg_state_sig : STD_LOGIC_VECTOR(3 downto 0);

begin

    CU_Inst: EC2_Control_Unit port map(
        clk => clk,
        reset => reset,
        opcode => opcode,
        Zero_Flag => Zero_Flag,
        Pos_Flag => Pos_Flag,
        IRload => IRload,
        PCload => PCload,
        MemInst => MemInst,
        MemWr => MemWr,
        Asel => Asel,
        Aload => Aload,
        Sub => Sub,
        JMPmux => JMPmux,
        Halt => Halt_Sig,
        dbg_state => dbg_state_sig
    );

    DP_Inst: EC2_Datapath port map(
        clk => clk,
        reset => reset,
        input_bus => input_bus,
        IRload => IRload,
        PCload => PCload,
        MemInst => MemInst,
        MemWr => MemWr,
        Asel => Asel,
        Aload => Aload,
        Sub => Sub,
        JMPmux => JMPmux,
        opcode => opcode,
        Zero_Flag => Zero_Flag,
        Pos_Flag => Pos_Flag,
        A_out_bus => output_bus,
        dbg_PC => dbg_PC,
        dbg_IR => dbg_IR
    );

    dbg_opcode <= opcode;
    dbg_state <= dbg_state_sig;
    halt <= Halt_Sig;

end Structural;
