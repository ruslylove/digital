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
0 & 1 & 0 & x & x & x & 0 & 0 & 0 & \text{Wait} \to \text{Fetch} \\
\hline
0 & 1 & 1 & x & x & x & 0 & 0 & 0 & \text{Input} \to \text{Fetch} \\
\hline
1 & 0 & 0 & x & x & x & 0 & 0 & 0 & \text{Output} \to \text{Fetch} \\
\hline
1 & 0 & 1 & x & x & x & 0 & 0 & 0 & \text{Decrement} \to \text{Fetch} \\
\hline
1 & 1 & 0 & x & x & x & 0 & 1 & 0 & \text{JNZ} \to \text{Wait} \\
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
D_1 &= \text{Decode} \cdot O_1 \cdot (O_2 + O_0) + \text{Halt} + \text{JNZ} \\
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
    state_Fetch <= Q2_n and Q1_n and Q0_n;
    state_Decode <= Q2_n and Q1_n and Q(0);
    state_Wait <= Q2_n and Q(1) and Q0_n;    -- 010 (New)
    state_Input <= Q2_n and Q(1) and Q(0);
    state_Output <= Q(2) and Q1_n and Q0_n;
    state_Dec <= Q(2) and Q1_n and Q(0);
    state_JNZ <= Q(2) and Q(1) and Q0_n;
    state_Halt <= Q(2) and Q(1) and Q(0);

    -- Next State Logic
    -- D2 = Decode * O2 + Halt
    D(2) <= (state_Decode and opcode(2)) or state_Halt;
    
    -- D1 = Decode * O1 * (O2 + O0) + Halt + JNZ (Go to Wait logic: 110 -> 010)
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
    component rom32x8
        port(
            address : in std_logic_vector(4 downto 0);
            clock : in std_logic;
            q : out std_logic_vector(7 downto 0)
        );
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


```

---



## RAM/ROM Megafunction (IP Core)
 
 FPGA vendors provide optimized Intellectual Property (IP) cores for memory.
 
 **ROM: 1-PORT Configuration:**
 *   **Type:** `altsyncram` (Intel/Altera)
 *   **Width:** 8 bits (Data bus)
 *   **Depth:** 32 words (Addressable locations 0-31)
 *   **Clocking:** Single clock, registered output.
 *   **Initialization:** Loads data from `rom_data_1.hex` at programming time.
 
 > [!NOTE]
 > Using IP cores ensures the memory maps directly to the FPGA's dedicated Block RAM resources (M9K/M10K blocks) rather than using general logic cells.
 
---
 
 ### ROM VHDL Component (rom32x8.vhd)
 
 ```vhdl {*}{maxHeight:'380px',lines:true}
-- megafunction wizard: %ROM: 1-PORT%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altsyncram 

-- ============================================================
-- File Name: rom32x8.vhd
-- Megafunction Name(s):
-- 			altsyncram
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 20.1.1 Build 720 11/11/2020 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2020  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and any partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details, at
--https://fpgasoftware.intel.com/eula.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY rom32x8 IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END rom32x8;


ARCHITECTURE SYN OF rom32x8 IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
	q    <= sub_wire0(7 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_aclr_a => "NONE",
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "rom_data_1.hex",
		intended_device_family => "Cyclone V",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 32,
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "CLOCK0",
		widthad_a => 5,
		width_a => 8,
		width_byteena_a => 1
	)
	PORT MAP (
		address_a => address,
		clock0 => clock,
		q_a => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
-- Retrieval info: PRIVATE: AclrByte NUMERIC "0"
-- Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clken NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: MIFfilename STRING "rom_data_1.hex"
-- Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "32"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: RegAddr NUMERIC "1"
-- Retrieval info: PRIVATE: RegOutput NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: SingleClock NUMERIC "1"
-- Retrieval info: PRIVATE: UseDQRAM NUMERIC "0"
-- Retrieval info: PRIVATE: WidthAddr NUMERIC "5"
-- Retrieval info: PRIVATE: WidthData NUMERIC "8"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: INIT_FILE STRING "rom_data_1.hex"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
-- Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "32"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "ROM"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "5"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "8"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
-- Retrieval info: USED_PORT: address 0 0 5 0 INPUT NODEFVAL "address[4..0]"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
-- Retrieval info: USED_PORT: q 0 0 8 0 OUTPUT NODEFVAL "q[7..0]"
-- Retrieval info: CONNECT: @address_a 0 0 5 0 address 0 0 5 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: q 0 0 8 0 @q_a 0 0 8 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom32x8.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom32x8.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom32x8.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom32x8.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL rom32x8_inst.vhd FALSE
-- Retrieval info: LIB_FILE: altera_mf
```

---

## Intel HEX Format
 
 Standard text-based file format for binary data (like ROM contents).
 
 **Line Structure:** `:LLAAAATT[DD...]CC`
 
 *   **`:`** Start Code
 *   **`LL`** Byte Count (Number of data bytes)
 *   **`AAAA`** Address (16-bit starting address)
 *   **`TT`** Record Type (`00`=Data, `01`=End of File)
 *   **`DD`** Data Bytes
 *   **`CC`** Checksum (Two's complement of sum of all bytes)
 
 **Example:** `:050000006080A0C1E03A`
 *   Count=`05`, Addr=`0000`, Type=`00` (Data)
 *   Data=`60, 80, A0, C1, E0`
 *   Checksum=`3A`
 


---
 layout: two-cols
---

 ### ROM Data (rom_data_1.hex)

```text
:100000006080A0C1E00000000000000000000000CF
:1000100000000000000000000000000000000000E0
:00000001FF
```

### Hex File Breakdown

**Assembly Code:**
```text
Addr  Hex  Assembly
00    60   IN A      ; Input to A
01    80   OUT A     ; Output A
02    A0   DEC A     ; Decrement A
03    C1   JNZ 01    ; Jump to 01 if A!=0
04    E0   HALT      ; Halt execution
```
:: right ::
**Explanation:** `:100000006080A0C1E0...CF`
*   **`:10`**: 16 bytes (0x10) of data.
*   **`0000`**: Starting at address 0x0000.
*   **`00`**: Data Record.
*   **`6080A0C1E0...`**: The machine code for the program.
*   **`CF`**: Checksum.

<img src="/quartus_intel_hex.png" class="mx-auto p-4" alt="Quartus Intel HEX" />
<p class="text-center text-sm">Figure 10-1: Intel HEX Format</p>
---

### Top Level Entity (ec1.vhd)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

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
    signal dbg_state_sig : STD_LOGIC_VECTOR(2 downto 0);

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
        dbg_state => dbg_state_sig
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
    dbg_state <= dbg_state_sig;

end Structural;
```

---

### Testbench (ec1_tb.vhd)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.EC1_Components.ALL;

entity ec1_tb is
end ec1_tb;

architecture Behavioral of ec1_tb is
    component ec1
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
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal input_bus : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal output_bus : STD_LOGIC_VECTOR(7 downto 0);
    signal halt : STD_LOGIC;
    signal dbg_opcode : STD_LOGIC_VECTOR(2 downto 0);
    signal dbg_A_neq_0 : STD_LOGIC;
    signal dbg_PC : STD_LOGIC_VECTOR(3 downto 0);
    signal dbg_IR : STD_LOGIC_VECTOR(7 downto 0);
    signal dbg_state : STD_LOGIC_VECTOR(2 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: ec1 port map (
        clk => clk,
        reset => reset,
        input_bus => input_bus,
        output_bus => output_bus,
        halt => halt,
        dbg_opcode => dbg_opcode,
        dbg_A_neq_0 => dbg_A_neq_0,
        dbg_PC => dbg_PC,
        dbg_IR => dbg_IR,
        dbg_state => dbg_state
    );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        -- Hold reset for 20 ns
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Input data: 10 (0x0A)
        input_bus <= "00001010"; 
        
        -- Wait until halt
        wait until halt = '1';
        
        wait for 20 ns;
        assert false report "Simulation Finished" severity failure;
    end process;

end Behavioral;
```
---

## EC-1 RTL Viewer

<img src="/rtl_viewer_ec-1.png" class="mx-auto p-4" alt="EC-1 RTL Viewer" />
<p class="text-center text-sm">Figure 10-4: EC-1 RTL Viewer of Top Level</p>

---

## EC-1 Simulation

<img src="/ec-1_count_10_9.png" class="mx-auto p-4" alt="EC-1 Count 10-9" />
<p class="text-center text-sm">Figure 10-2: EC-1 Count 10-9</p>

<img src="/ec-1_count_2_1.png" class="mx-auto p-4" alt="EC-1 Count 2-1" />
<p class="text-center text-sm">Figure 10-3: EC-1 Count 2-1</p>


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