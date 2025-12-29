library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity EC1_Datapath is
    Port ( clk, reset : in STD_LOGIC;
           input_bus : in STD_LOGIC_VECTOR(7 downto 0);
           IRload, PCload, INmux, Aload, JNZmux, OutE : in STD_LOGIC;
           opcode : out STD_LOGIC_VECTOR(2 downto 0);
           A_out_bus : out STD_LOGIC_VECTOR(7 downto 0);
           A_neq_0 : out STD_LOGIC;
           dbg_PC : out STD_LOGIC_VECTOR(3 downto 0);
           dbg_IR : out STD_LOGIC_VECTOR(7 downto 0));
end EC1_Datapath;

architecture Structural of EC1_Datapath is
    signal IR_out, A_out, A_in, Dec_out : std_logic_vector(7 downto 0);
    signal PC_out, PC_in, PC_inc : std_logic_vector(3 downto 0);
    signal ROM_data : std_logic_vector(7 downto 0); 

begin
    -- ROM (Program Memory)
    ROM_Unit: rom32x8 port map(
        address(4) => '0',
        address(3 downto 0) => PC_out,
        clock => clk,
        q => ROM_data
    );

    -- Instruction Register
    IR_Reg: Reg8 port map(clk, reset, IRload, ROM_data, IR_out);
    opcode <= IR_out(7 downto 5);

    -- Program Counter Logic
    PC_Inc_Unit: Inc4 port map(PC_out, PC_inc);
    PC_Mux: Mux2_4 port map(JNZmux, PC_inc, IR_out(3 downto 0), PC_in);
    PC_Reg: Reg4 port map(clk, reset, PCload, PC_in, PC_out);

    -- Accumulator Logic
    Dec_Unit: Dec8 port map(A_out, Dec_out);
    A_Mux: Mux2_8 port map(INmux, Dec_out, input_bus, A_in); 
    
    A_Reg: Reg8 port map(clk, reset, Aload, A_in, A_out);
    
    -- Zero Check
    ZC: ZeroCheck8 port map(A_out, A_neq_0);
    
    -- Output Buffer
    OutBuf: TriBuf8 port map(OutE, A_out, A_out_bus);

    dbg_PC <= PC_out;
    dbg_IR <= IR_out;

end Structural;
