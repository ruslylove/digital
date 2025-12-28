---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: "Lecture 10 - General-Purpose Microprocessors"
---

# Lecture 10: General-Purpose Microprocessors
{{ $slidev.configs.subject }}


{{ $slidev.configs.author }}

---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---


## General-Purpose Microprocessors

Unlike **dedicated microprocessors** (ASICs) designed for a single specific task, **general-purpose microprocessors** can perform many different functions.

*   **Programmable:** Their function is determined by the **software instructions** they execute.
*   **Versatile:** Changing the program changes the function without modifying the hardware.
*   **Examples:** Intel Core i7, ARM Cortex, etc.


<br>

> [NOTE:]
> A general-purpose microprocessor can be viewed as a **dedicated** microprocessor whose single dedicated function is to **fetch and execute instructions**.

<div class="mt-8">

**Design Perspective:**
We can design a general-purpose CPU using the same methods as dedicated datapaths, but the "data" we process includes user instructions.

</div>

---
layout: two-cols-header
---

## Overview of CPU Design

Designing a Central Processing Unit (CPU) involves three main steps.

:: left ::

### 1. Define Instruction Set
*   **Instructions:** What operations can the CPU perform? (Add, Load, Jump, etc.)
*   **Encoding:** How are these instructions represented in binary? (Opcode, Operands)

### 2. Design Datapath
*   Create a custom datapath capable of executing *every* instruction in the set.
*   Includes **PC** (Program Counter), **IR** (Instruction Register), **ALU**, **Registers**, and **Memory**.

:: right ::

### 3. Design Control Unit
*   Design an FSM to orchestrate the **Instruction Cycle**:
    1.  **Fetch:** Get instruction from memory.
    2.  **Decode:** Figure out what to do.
    3.  **Execute:** Perform the operation.

---

## The EC-1 Microprocessor

To understand the design process, we will build a simple 8-bit general-purpose microprocessor called the **EC-1**.

*   **Goal:** Keep it simple to allow manual design.
*   **Architecture:**
    *   **Data Width:** 8 bits
    *   **Address Width:** 4 bits (16 memory locations)
    *   **Memory:** Read-Only Memory (ROM) for program storage.

---

## EC-1 Instruction Set

The EC-1 has a very small instruction set with only 5 instructions. We use **3 bits** for the Opcode.

$$
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Instruction} & \textbf{Mnemonic} & \textbf{Encoding} & \textbf{Operation} & \textbf{Description} \\
\hline
\textbf{Input} & \text{IN A} & 011 \text{ xxxxx} & A \leftarrow \text{Input} & \text{Input data to A} \\
\hline
\textbf{Output} & \text{OUT A} & 100 \text{ xxxxx} & \text{Output} \leftarrow A & \text{Output data from A} \\
\hline
\textbf{Decrement} & \text{DEC A} & 101 \text{ xxxxx} & A \leftarrow A - 1 & \text{Decrement A} \\
\hline
\textbf{JumpNotZero} & \text{JNZ addr} & 110 \text{ xaaaa} & \text{If } A \neq 0, PC \leftarrow aaaa & \text{Conditional Jump} \\
\hline
\textbf{Halt} & \text{HALT} & 111 \text{ xxxxx} & \text{Halt} & \text{Stop execution} \\
\hline
\end{array}
$$

*   **nop:** Opcodes `000`, `001`, `010` are unused (No Operation).
*   **aaaa:** Represents a 4-bit memory address.
*   **xxxxx:** Don't care bits (unused).

---

## EC-1 Datapath Design

The datapath must support fetching instructions and executing data operations.

**Key Components:**
*   **Program Counter (PC):** 4-bit register. Points to the next instruction.
*   **Instruction Register (IR):** 8-bit register. Stores the current instruction.
*   **Accumulator (A):** 8-bit register. Stores data for processing.
*   **Memory (ROM):** 16 x 8-bit. Stores the program.
*   **Functional Units:**
    *   **Incrementer:** $PC = PC + 1$
    *   **Decrementer:** $A = A - 1$
    *   **Comparator:** Check if $A = 0$ (for JNZ)

---

## EC-1 Datapath Diagram

<div class="grid grid-cols-2 gap-4">
<div class="text-base">

**Instruction Cycle Logic:**
*   **PC Logic:**
    *   Usually `PC = PC + 1` (Next instruction).
    *   For `JNZ`, if taken: `PC = IR[3:0]` (Jump address).
    *   Uses a `JNZmux` to select between incremented PC and Jump address.

**Execution Logic:**
*   **Accumulator (A) Logic:**
    *   Input from generic `Input` port or Input from `Decrement Unit`.
    *   Selected by `INmux`.
*   **Output:** Tri-state buffer controlled by `OutE`.

</div>
<div>

<!-- Placeholder for Datapath Image - Ideally this would be an SVG -->

<img src="/ec1_datapath.png" class="rounded-lg bg-white p-2 w-full object-contain mx-auto" alt="EC-1 Datapath">
<p class="text-center text-sm">Figure 10-1. EC-1 Datapath Diagram</p>


</div>
</div>

---
layout: two-cols-header
---

## EC-1 Control Unit (FSM)

The Control Unit orchestrates the datapath. It transitions through generic states for fetching and decoding, then specific states for execution.

:: left ::

### FSM States:
1.  **FETCH (000):**
    *   Read instruction from Memory at address PC.
    *   Load into IR (`IRload`).
    *   Increment PC (`PCload`).
2.  **DECODE (001):**
    *   Look at Opcode `IR[7:5]`.
    *   Transition to the specific execution state.
3.  **EXECUTE (Various):**
    *   `INPUT` state, `OUTPUT` state, `DEC` state, `JNZ` state, `HALT` state.

:: right ::

<img src="/ec1_fsm.svg" class="rounded-lg bg-white p-2 w-full object-contain mx-auto" alt="EC-1 Control Unit FSM">
<p class="text-center text-sm">Figure 10-2. EC-1 Control Unit FSM</p>

---
layout: two-cols-header
---

## Instruction Cycle Details

:: left ::

<div class="text-base pr-5">

### Step 1: Fetch
*   **Operation:** $IR \leftarrow Memory[PC]$, $PC \leftarrow PC + 1$
*   **Control Signals:** `IRload = 1`, `PCload = 1`, `JNZmux = 0` (select increment).
### Step 2: Decode
*   **Operation:** Determine Next State based on `IR[7:5]`.
*   **Control Signals:** None (internal FSM transition).

<br>

$$
\tiny
\def\arraystretch{1.5}
\begin{array}{|l|c|c|c|c|c|c|c|}
\hline
\textbf{State} & \textbf{IRload} & \textbf{PCload} & \textbf{INmux} & \textbf{Aload} & \textbf{JNZmux} & \textbf{OutE} & \textbf{Halt} \\
\hline
\text{Fetch (000)} & 1 & 1 & - & 0 & 0 & 0 & 0 \\
\hline
\text{Decode (001)} & 0 & 0 & - & 0 & 0 & 0 & 0 \\
\hline
\text{Input (011)} & 0 & 0 & 1 & 1 & 0 & 0 & 0 \\
\hline
\text{Output (100)} & 0 & 0 & - & 0 & 0 & 1 & 0 \\
\hline
\text{Decrement (101)} & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\
\hline
\text{JumpNotZero (110)} & 0 & (A \neq 0) & - & 0 & 1 & 0 & 0 \\
\hline
\text{Halt (111)} & 0 & 0 & - & 0 & 0 & 0 & 1 \\
\hline
\end{array}
$$

</div>


:: right ::

<div class="text-base pl-3">

### Step 3: Execute (Examples)
* **IN A:**
    *   Load A with data from Input port.
    *   Signals: `INmux = 1` (Input), `Aload = 1`.
    *   Return to **FETCH**.
* **DEC A:**
    *   Load A with (A - 1).
    *   Signals: `INmux = 0` (Dec unit), `Aload = 1`.
    *   Return to **FETCH**.
* **JNZ address:**
    *   If $A \neq 0$, load PC with address from IR.
    *   Signals: If $A \neq 0$ then `PCload = 1`, `JNZmux = 1`.
    *   Return to **FETCH**.

</div>

---
layout: two-cols-header
---

## EC-1 Control Unit: State Table

:: left ::



$$
\scriptsize
\def\arraystretch{1.5}
\begin{array}{|ccc||ccc||ccc|l|}
\hline
Q_2 & Q_1 & Q_0 & O_2 & O_1 & O_0 & D_2 & D_1 & D_0 & \textbf{Description} \\
\hline
0 & 0 & 0 & x & x & x & 0 & 0 & 1 & \text{Fetch} \to \text{Decode} \\
\hline
0 & 0 & 1 & 0 & 0 & x & 0 & 0 & 0 & \text{Decode} \to \text{Fetch (NOP)} \\
0 & 0 & 1 & 0 & 1 & 0 & 0 & 0 & 0 & \text{Decode} \to \text{Fetch (NOP)} \\
0 & 0 & 1 & 0 & 1 & 1 & 0 & 1 & 1 & \text{Decode} \to \text{Input} \\
0 & 0 & 1 & 1 & x & x & 1 & O_1 & O_0 & \text{Decode} \to \text{Execute} \\
\hline
0 & 1 & 1 & x & x & x & 0 & 0 & 0 & \text{Input} \to \text{Fetch} \\
\hline
1 & 0 & 0 & x & x & x & 0 & 0 & 0 & \text{Output} \to \text{Fetch} \\
\hline
1 & 0 & 1 & x & x & x & 0 & 0 & 0 & \text{Decrement} \to \text{Fetch} \\
\hline
1 & 1 & 0 & x & x & x & 0 & 0 & 0 & \text{JNZ} \to \text{Fetch} \\
\hline
1 & 1 & 1 & x & x & x & 1 & 1 & 1 & \text{Halt} \to \text{Halt} \\
\hline
\end{array}
$$

**Legend:** $Q$: Active State, $O$: Opcode, $D$: Next State

:: right ::

<img src="/ec1_fsm.svg" class="rounded-lg bg-white pl-10 w-full h-80 object-contain mx-auto" alt="EC-1 Control Unit FSM">

---
layout: two-cols-header
---

## EC-1 Control Unit: State Equations and Output Logic

:: left ::

### State Equations

$$
\small
\begin{aligned}
D_2 &= \text{Decode} \cdot O_2 + \text{Halt} \\
D_1 &= \text{Decode} \cdot O_1 \cdot (O_2 + O_0) + \text{Halt} \\
D_0 &= \text{Fetch} + \text{Decode} \cdot O_0 \cdot (O_2 + O_1) + \text{Halt}
\end{aligned}
$$

**Where:**
*   $\text{Fetch} = \bar{Q_2} \bar{Q_1} \bar{Q_0}$
*   $\text{Decode} = \bar{Q_2} \bar{Q_1} Q_0$
*   $\text{Halt} = Q_2 Q_1 Q_0$
*   $\text{Input} = \bar{Q_2} Q_1 Q_0$
*   $\text{Output} = Q_2 \bar{Q_1} \bar{Q_0}$
*   $\text{Dec} = Q_2 \bar{Q_1} Q_0$
*   $\text{JNZ} = Q_2 Q_1 \bar{Q_0}$

:: right ::

### Output Logic

$$
\small
\begin{aligned}
\text{IRload} &= \text{Fetch} \\
\text{PCload} &= \text{Fetch} + \text{JNZ} \cdot (A \neq 0) \\
\text{INmux} &= \text{Input} \\
\text{Aload} &= \text{Input} + \text{Dec} \\
\text{JNZmux} &= \text{JNZ} \\
\text{OutE} &= \text{Output} \\
\text{Halt} &= \text{Halt}
\end{aligned}
$$


---


### VHDL Code for Control Unit and Datapath

<div class="grid grid-cols-2 gap-4">
<div>

**EC1_Control_Unit.vhd**

```vhdl{*}{maxHeight:'350px',lines:true}
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
           Halt : out STD_LOGIC);
end EC1_Control_Unit;

architecture Structural of EC1_Control_Unit is
    signal Q, D : std_logic_vector(2 downto 0);
    signal Q2_n, Q1_n, Q0_n : std_logic;
    signal state_Fetch, state_Decode, state_Halt : std_logic;
    signal state_Input, state_Output, state_Dec, state_JNZ : std_logic;
    
begin
    -- State Registers
    FF2: d_ff port map(clk, reset, D(2), Q(2));
    FF1: d_ff port map(clk, reset, D(1), Q(1));
    FF0: d_ff port map(clk, reset, D(0), Q(0));
    
    Q2_n <= not Q(2); Q1_n <= not Q(1); Q0_n <= not Q(0);

    -- State Decoders
    state_Fetch <= Q2_n and Q1_n and Q0_n;
    state_Decode <= Q2_n and Q1_n and Q(0);
    state_Input <= Q2_n and Q(1) and Q(0);
    state_Output <= Q(2) and Q1_n and Q0_n;
    state_Dec <= Q(2) and Q1_n and Q(0);
    state_JNZ <= Q(2) and Q(1) and Q0_n;
    state_Halt <= Q(2) and Q(1) and Q(0);

    -- Next State Logic
    -- D2 = Decode * O2 + Halt
    D(2) <= (state_Decode and opcode(2)) or state_Halt;
    
    -- D1 = Decode * O1 * (O2 + O0) + Halt
    D(1) <= (state_Decode and opcode(1) and (opcode(2) or opcode(0))) or state_Halt;
    
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

end Structural;
```
</div>
<div>

**EC1_Datapath.vhd**

```vhdl{*}{maxHeight:'350px',lines:true}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity EC1_Datapath is
    Port ( clk, reset : in STD_LOGIC;
           input_bus : in STD_LOGIC_VECTOR(7 downto 0);
           IRload, PCload, INmux, Aload, JNZmux, OutE : in STD_LOGIC;
           opcode : out STD_LOGIC_VECTOR(2 downto 0);
           A_out_bus : out STD_LOGIC_VECTOR(7 downto 0);
           A_neq_0 : out STD_LOGIC);
end EC1_Datapath;

architecture Structural of EC1_Datapath is
    signal IR_out, A_out, A_in, Dec_out : std_logic_vector(7 downto 0);
    signal PC_out, PC_in, PC_inc : std_logic_vector(3 downto 0);
    signal ROM_data : std_logic_vector(7 downto 0); -- Assume external or component

begin
    -- Components would be defined in a package or separate files
    
    -- ROM (Program Memory)
    ROM_Unit: ROM16x8 port map(clk, PC_out, ROM_data);

    -- Instruction Register
    IR_Reg: Reg8 port map(clk, reset, IRload, ROM_data, IR_out);
    opcode <= IR_out(7 downto 5);

    -- Program Counter Logic
    PC_Inc_Unit: Inc4 port map(PC_out, PC_inc);
    PC_Mux: Mux2_4 port map(JNZmux, PC_inc, IR_out(3 downto 0), PC_in);
    PC_Reg: Reg4 port map(clk, reset, PCload, PC_in, PC_out);

    -- Accumulator Logic
    Dec_Unit: Dec8 port map(A_out, Dec_out);
    A_Mux: Mux2_8 port map(INmux, Dec_out, input_bus, A_in); -- INmux=0 logic? Check table.
    -- Table: INmux=1 -> Input. INmux=0 -> Dec. 
    -- So I1 (sel=1) should be Input. I0 (sel=0) should be Dec_out.
    -- Mux2_8(sel, I0, I1, Y) => (INmux, Dec_out, input_bus, A_in) Correct.
    
    A_Reg: Reg8 port map(clk, reset, Aload, A_in, A_out);
    
    -- Zero Check
    ZC: ZeroCheck8 port map(A_out, A_neq_0);
    
    -- Output Buffer
    OutBuf: TriBuf8 port map(OutE, A_out, A_out_bus);

end Structural;
```

</div>
</div>

---

### VHDL Components

**components.vhd**

```vhdl{*}{maxHeight:'380px',lines:true}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package EC1_Components is
    component d_ff
        port(clk, reset, d : in std_logic; q : out std_logic);
    end component;
    component Reg8
        port(clk, reset, load: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
    end component;
    component Reg4
        port(clk, reset, load: in std_logic; D: in std_logic_vector(3 downto 0); Q: out std_logic_vector(3 downto 0));
    end component;
    component Mux2_8
        port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component Mux2_4
        port(sel: in std_logic; I0, I1: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
    end component;
    component Inc4
        port(A: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
    end component;
    component Dec8
        port(A: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
    end component;
    component ZeroCheck8
        port(A: in std_logic_vector(7 downto 0); is_not_zero: out std_logic);
    end component;
    component TriBuf8
        port(en: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
    end component;
    component ROM16x8
        port(clk: in std_logic; addr: in std_logic_vector(3 downto 0); data: out std_logic_vector(7 downto 0));
    end component;
end EC1_Components;

package body EC1_Components is
end EC1_Components;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- D Flip-Flop
entity d_ff is
    port(clk, reset, d : in std_logic; q : out std_logic);
end d_ff;
architecture Behavioral of d_ff is begin
    process(clk, reset) begin
        if reset='1' then q <= '0';
        elsif rising_edge(clk) then q <= d; end if;
    end process;
end Behavioral;

-- 8-bit Register
entity Reg8 is
    port(clk, reset, load: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
end Reg8;
architecture Behavioral of Reg8 is begin
    process(clk, reset) begin
        if reset='1' then Q <= (others=>'0');
        elsif rising_edge(clk) then if load='1' then Q <= D; end if; end if;
    end process;
end Behavioral;

-- 4-bit Register
entity Reg4 is
    port(clk, reset, load: in std_logic; D: in std_logic_vector(3 downto 0); Q: out std_logic_vector(3 downto 0));
end Reg4;
architecture Behavioral of Reg4 is begin
    process(clk, reset) begin
        if reset='1' then Q <= (others=>'0');
        elsif rising_edge(clk) then if load='1' then Q <= D; end if; end if;
    end process;
end Behavioral;

-- 2-to-1 Mux (8-bit)
entity Mux2_8 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Mux2_8;
architecture Behavioral of Mux2_8 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

-- 2-to-1 Mux (4-bit)
entity Mux2_4 is
    port(sel: in std_logic; I0, I1: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
end Mux2_4;
architecture Behavioral of Mux2_4 is begin
    Y <= I1 when sel='1' else I0;
end Behavioral;

-- 4-bit Incrementer
entity Inc4 is
    port(A: in std_logic_vector(3 downto 0); Y: out std_logic_vector(3 downto 0));
end Inc4;
architecture Behavioral of Inc4 is begin
    Y <= A + 1;
end Behavioral;

-- 8-bit Decrementer
entity Dec8 is
    port(A: in std_logic_vector(7 downto 0); Y: out std_logic_vector(7 downto 0));
end Dec8;
architecture Behavioral of Dec8 is begin
    Y <= A - 1;
end Behavioral;

-- Zero Check
entity ZeroCheck8 is
    port(A: in std_logic_vector(7 downto 0); is_not_zero: out std_logic);
end ZeroCheck8;
architecture Behavioral of ZeroCheck8 is begin
    is_not_zero <= '1' when A /= "00000000" else '0';
end Behavioral;

-- Tri-state Buffer
entity TriBuf8 is
    port(en: in std_logic; D: in std_logic_vector(7 downto 0); Q: out std_logic_vector(7 downto 0));
end TriBuf8;
architecture Behavioral of TriBuf8 is begin
    Q <= D when en='1' else (others=>'Z');
end Behavioral;

-- 16x8 ROM (Program Memory)
entity ROM16x8 is
    port(clk: in std_logic; addr: in std_logic_vector(3 downto 0); data: out std_logic_vector(7 downto 0));
end ROM16x8;
architecture Behavioral of ROM16x8 is
    type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);
    constant ROM : rom_type := (
        0 => "01100000", -- IN A
        1 => "10100000", -- DEC A
        2 => "11100000", -- HALT
        others => "00000000"
    );
begin
    process(clk) begin
        if rising_edge(clk) then
            data <= ROM(conv_integer(addr));
        end if;
    end process;
end Behavioral;
```




---
layout: section
---

## The EC-2 Microprocessor

A more advanced general-purpose microprocessor.

---

## EC-2 Overview

The **EC-2** improves upon the EC-1 by adding more instructions and capabilities.

*   **Expanded Instruction Set:** 8 Instructions (utilizing all 3 opcode bits).
*   **Memory:** 32 x 8-bit **RAM** (Read/Write capabilities).
*   **Addressing:** 5-bit address bus.
*   **ALU:** Adder/Subtractor unit.

---

## EC-2 Instruction Set

$$

\def\arraystretch{1.5}
\begin{array}{|l|c|l|l|}
\hline
\textbf{Instruction} & \textbf{Encoding} & \textbf{Operation} & \textbf{Description} \\
\hline
\textbf{LOAD A, addr} & 000 \text{ aaaaa} & A \leftarrow \text{Memory}[aaaaa] & \text{Load A from Memory} \\
\hline
\textbf{STORE A, addr} & 001 \text{ aaaaa} & \text{Memory}[aaaaa] \leftarrow A & \text{Store A to Memory} \\
\hline
\textbf{ADD A, addr} & 010 \text{ aaaaa} & A \leftarrow A + \text{Memory}[aaaaa] & \text{Add Memory to A} \\
\hline
\textbf{SUB A, addr} & 011 \text{ aaaaa} & A \leftarrow A - \text{Memory}[aaaaa] & \text{Sub Memory from A} \\
\hline
\textbf{IN A} & 100 \text{ xxxxx} & A \leftarrow \text{Input} & \text{Input to A} \\
\hline
\textbf{JZ addr} & 101 \text{ aaaaa} & \text{If } A = 0, PC \leftarrow aaaaa & \text{Jump if Zero} \\
\hline
\textbf{JPOS addr} & 110 \text{ aaaaa} & \text{If } A \ge 0, PC \leftarrow aaaaa & \text{Jump if Pos/Zero} \\
\hline
\textbf{HALT} & 111 \text{ xxxxx} & \text{Halt} & \text{Halt execution} \\
\hline
\end{array}
$$

---

## EC-2 Datapath Enhancements

To support the new instructions, the datapath is upgraded:

1.  **5-bit Address Bus:** To address 32 memory locations.
2.  **RAM vs ROM:** Allows `STORE` operations.
3.  **Memory Address MUX:**
    *   **Fetch:** Address comes from **PC**.
    *   **Execute (Load/Store/Add/Sub):** Address comes from **IR[4:0]**.
4.  **ALU:** Performs both Addition and Subtraction.
5.  **Accumulator MUX (4-to-1):** Selects input from:
    *   Memory Output (LOAD)
    *   ALU Output (ADD/SUB)
    *   Input Port (IN)

---

## EC-2 Datapath Diagram

<div class="grid grid-cols-2 gap-4">
<div>

**Key Control Signals:**
*   `MemInst`: Selects address source (0=PC, 1=IR).
*   `MemWr`: Enables writing to RAM.
*   `Asel`: Selects Accumulator input source.
*   `Sub`: Selects ALU operation (0=Add, 1=Sub).
*   `JMPmux`: Controls PC update for Jumps.

</div>
<div>

<div class="border-2 border-gray-400 p-4 rounded-lg bg-white text-center text-xs">
    <strong>EC-2 Datapath Flow</strong>
    <div class="mt-2 flex flex-col gap-2">
        <div class="border p-2 bg-blue-50">
            <strong>Memory Interface</strong><br>
            Addr MUX(PC, IR) -> RAM -> Data Out
        </div>
        <div class="border p-2 bg-green-50">
            <strong>ALU Section</strong><br>
            A +/- RAM Data -> Result
        </div>
        <div class="border p-2 bg-yellow-50">
            <strong>Accumulator Logic</strong><br>
            MUX(RAM, ALU, Input) -> A Register
        </div>
    </div>
</div>

</div>
</div>

---

## EC-2 Control Unit

The FSM is slightly more complex to handle the memory operands.

### Instruction Cycle with Memory Access:
1.  **Fetch:** `MemInst=0` (Use PC). Fetch instruction.
2.  **Decode:** Check Opcode.
3.  **Execute:**
    *   **LOAD:** `MemInst=1` (Use IR addr). Read RAM. Load A.
    *   **STORE:** `MemInst=1`. Write A to RAM (`MemWr=1`).
    *   **ADD:** `MemInst=1`. Read RAM. ALU adds A + RAM. Load A.

---

## Summary

*   **General-purpose microprocessors** execute a sequence of instructions stored in memory.
*   The **Instruction Cycle** consists of **Fetch**, **Decode**, and **Execute** phases.
*   The **Datapath** supports specific structural requirements (PC, IR) and functional units.
*   **EC-1** demonstrates a minimal 5-instruction set and 8-bit architecture.
*   **EC-2** extends this with memory-reference instructions (Load/Store), RAM, and more complex addressing.