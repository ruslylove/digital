library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity ec1 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input_bus : in STD_LOGIC_VECTOR (7 downto 0);
           output_bus : out STD_LOGIC_VECTOR (7 downto 0);
           halt : out STD_LOGIC;
           dbg_opcode : out STD_LOGIC_VECTOR(2 downto 0);
           dbg_A_neq_0 : out STD_LOGIC;
           dbg_PC : out STD_LOGIC_VECTOR(3 downto 0);
           dbg_IR : out STD_LOGIC_VECTOR(7 downto 0);
           dbg_state : out STD_LOGIC_VECTOR(2 downto 0));
end ec1;

architecture Structural of ec1 is
    component EC1_Control_Unit
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
    end component;

    component EC1_Datapath
        Port ( clk, reset : in STD_LOGIC;
               input_bus : in STD_LOGIC_VECTOR(7 downto 0);
               IRload, PCload, INmux, Aload, JNZmux, OutE : in STD_LOGIC;
               opcode : out STD_LOGIC_VECTOR(2 downto 0);
               A_out_bus : out STD_LOGIC_VECTOR(7 downto 0);
               A_neq_0 : out STD_LOGIC;
               dbg_PC : out STD_LOGIC_VECTOR(3 downto 0);
               dbg_IR : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    signal opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal A_neq_0 : STD_LOGIC;
    signal IRload, PCload, INmux, Aload, JNZmux, OutE : STD_LOGIC;

begin

    CU_Inst: EC1_Control_Unit port map(
        clk => clk,
        reset => reset,
        opcode => opcode,
        A_neq_0 => A_neq_0,
        IRload => IRload,
        PCload => PCload,
        INmux => INmux,
        Aload => Aload,
        JNZmux => JNZmux,
        OutE => OutE,
        Halt => halt,
        dbg_state => dbg_state
    );

    DP_Inst: EC1_Datapath port map(
        clk => clk,
        reset => reset,
        input_bus => input_bus,
        IRload => IRload,
        PCload => PCload,
        INmux => INmux,
        Aload => Aload,
        JNZmux => JNZmux,
        OutE => OutE,
        opcode => opcode,
        A_out_bus => output_bus,
        A_neq_0 => A_neq_0,
        dbg_PC => dbg_PC,
        dbg_IR => dbg_IR
    );

    dbg_opcode <= opcode;
    dbg_A_neq_0 <= A_neq_0;

end Structural;
