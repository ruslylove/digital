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
layout: two-cols
---

## General-Purpose Microprocessors

Unlike **dedicated microprocessors** (ASICs) designed for a single specific task, **general-purpose microprocessors** can perform many different functions.

*   **Programmable:** Their function is determined by the **software instructions** they execute.
*   **Versatile:** Changing the program changes the function without modifying the hardware.
*   **Examples:** Intel Core i7, ARM Cortex, etc.

:: right ::

> [!NOTE]
> A general-purpose microprocessor can be viewed as a **dedicated** microprocessor whose single dedicated function is to **fetch and execute instructions**.

<div class="mt-8">

**Design Perspective:**
We can design a general-purpose CPU using the same methods as dedicated datapaths, but the "data" we process includes user instructions.

</div>

---
layout: two-cols
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

## The EC-1 Microprocessor ("Enoch's Computer 1")

To understand the design process, we will build a simple 8-bit general-purpose microprocessor called the **EC-1**.

*   **Goal:** Keep it simple to allow manual design.
*   **Architecture:**
    *   **Data Width:** 8 bits
    *   **Address Width:** 4 bits (16 memory locations)
    *   **Memory:** Read-Only Memory (ROM) for program storage.

---

## 1. EC-1 Instruction Set

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
\textbf{JumpNotZero} & \text{JNZ addr} & 110 \text{ aaaa} & \text{If } A \neq 0, PC \leftarrow aaaa & \text{Conditional Jump} \\
\hline
\textbf{Halt} & \text{HALT} & 111 \text{ xxxxx} & \text{Halt} & \text{Stop execution} \\
\hline
\end{array}
$$

*   **nop:** Opcodes `000`, `001`, `010` are unused (No Operation).
*   **aaaa:** Represents a 4-bit memory address.
*   **xxxxx:** Don't care bits (unused).

---

## 2. EC-1 Datapath Design

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
<div>

**Instruction Cycle Logic:**
*   **PC Logic:**
    *   Usually `PC = PC + 1` (Next instruction).
    *   For `JNZ`, if taken: `PC = IR[3:0]` (Jump address).
    *   Uses a `JNZmux` to select between incremented PC and Jump address.

**Execution Logic:**
*   **Accumulator (A) Logic:**
    *   Input from generic `Input` port OR
    *   Input from `Decrement Unit`.
    *   Selected by `INmux`.
*   **Output:** Tri-state buffer controlled by `OutE`.

</div>
<div>

<!-- Placeholder for Datapath Image - Ideally this would be an SVG -->
<div class="border-2 border-gray-400 p-4 rounded-lg bg-white text-center">
    <div class="text-xs text-left mb-2">Datapath Construction</div>
    <div class="flex flex-col gap-4">
        <div class="border p-2">
            <strong>Fetch Path:</strong><br>
            PC (4-bit) -> Memory -> IR (8-bit)
        </div>
        <div class="border p-2">
            <strong>Update Path:</strong><br>
            PC + 1 -> PC (Normal)<br>
            IR[3:0] -> PC (Jump)
        </div>
        <div class="border p-2">
            <strong>Data Path:</strong><br>
            Input / (A-1) -> MUX -> Reg A -> Output
        </div>
    </div>
</div>

</div>
</div>

---

## 3. EC-1 Control Unit (FSM)

The Control Unit orchestrates the datapath. It transitions through generic states for fetching and decoding, then specific states for execution.

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

---
layout: two-cols
---

## Instruction Cycle Details

### Step 1: Fetch
*   **Operation:** $IR \leftarrow Memory[PC]$, $PC \leftarrow PC + 1$
*   **Control Signals:** `IRload = 1`, `PCload = 1`, `JNZmux = 0` (select increment).

### Step 2: Decode
*   **Operation:** Determine Next State based on `IR[7:5]`.
*   **Control Signals:** None (internal FSM transition).

:: right ::

### Step 3: Execute (Examples)

**IN A:**
*   Load A with data from Input port.
*   Signals: `INmux = 1` (Input), `Aload = 1`.
*   Return to **FETCH**.

**DEC A:**
*   Load A with (A - 1).
*   Signals: `INmux = 0` (Dec unit), `Aload = 1`.
*   Return to **FETCH**.

**JNZ address:**
*   If $A \neq 0$, load PC with address from IR.
*   Signals: If $A \neq 0$ then `PCload = 1`, `JNZmux = 1`.
*   Return to **FETCH**.

---

## EC-1 State Diagram

<img src="/ec1_fsm.svg" class="rounded-lg bg-white p-4 w-full h-80 object-contain mx-auto" alt="EC-1 Control Unit FSM">


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