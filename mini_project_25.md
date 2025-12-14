
---
theme: seriph
background: https://cover.sli.dev
class: text-center
highlighter: shiki
lineNumbers: false
info: |
    ## SPI Packet Detector Design
    Mini Project 2025 Design Proposal
drawings:
    persist: false
transition: fade
title: Mini Project 2025 - SPI Packet Detector Design
layout: cover
---

# SPI Packet Detector
## Mini Project 2025

Design & Implementation of a Sequence Detector FSM

<div class="pt-12">
  <span class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---
layout: default
---

## Project Objective: SPI Packet Detector

The goal is to design a digital circuit that monitors the **SPI (Serial Peripheral Interface)** bus and detects a specific 6-bit binary sequence unique to your Student ID.

<div class="grid grid-cols-2 gap-4">

<div>

### Inputs
* **MOSI (Master Out Slave In):** Serial data line
* **SCLK:** Serial Clock (synchronizes data)
* **CS (Chip Select):** Active low enable signal
* **CLK:** System Clock (500 kHz / 1 kHz)

</div>

<div>

### Outputs
* **Detected:** Generates a **square wave** signal when the sequence is found
* **State Lamp:** LEDs indicating the current FSM state

</div>

</div>

> **Core Logic:** The system is essentially a **Sequence Detector** implemented as a Finite State Machine (FSM).

---

## Target Sequence Derivation

The target 6-bit sequence is derived from the last 5 digits of your Student ID.

### Calculation Steps

1.  Take the **Last 5 Digits** of your ID.
2.  Convert this decimal number to **Binary**.
3.  Extract the **Last 6 Bits** (LSB).

### Example
* **Student ID:** `...630827`
* **Last 5 Digits:** $30827_{10}$
* **Binary Conversion:** $111100001101011_2$
* **Target Sequence (Last 6 bits):** `10 1011` ($2B_{16}$)

---


## System Architecture
The design is divided into three distinct modules ("Boxes").

<div class="grid grid-cols-2 gap-4 text-base">
<div>

**1. Left Box (Combinational Logic)**
* Contains **Next-State Logic** and **Output Logic**.
* **Input:** Current State ($Q_n$), Inputs (MOSI, SCLK).
* **Output:** Next State ($D_n$).
* **Constraint:** No MUX/DEMUX allowed. Logic gates only.



</div>

<div>

**2. Middle Box (Sequential Logic)**
* Contains the Memory elements (Flip-Flops).
* Stores the **Current State**.

**3. Right Box (Output Interface)**
* Handles the "Detected" signal generation.
* Modulates output as a square wave.

</div>
</div>

<img src="/spi_block_diagram.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="SPI Packet Detector Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 2: System Block Diagram</div>



---

## Step 1: State Diagram Design

The design begins with a Mealy/Moore State Machine diagram.

  * **States:** Represent the progress of matching the sequence (e.g., $S_0$ start, $S_1$ 1st bit matched, etc.)
  * **Transitions:**
      * Driven by `MOSI` and `SCLK`.
      * Must account for correct bits (advance state) and incorrect bits (reset/partial reset).
  * **Validation:** Verify transition lines for all input combinations ($2^n$ lines per state).

  <br>



> **Task 5 Requirement:** Explain the origin of all transition numbers (e.g., `1xx`).

---

<img src="/spi_sequence_fsm.svg" class="rounded-lg bg-white p-4 w-180 mx-auto" alt="State Diagram Example: 101011">
<div class="text-center text-sm opacity-50 mt-2">Figure 1: Example State Diagram for Sequence 101011</div>



---

## Step 2: State Table & Minimization

Convert the diagram into a formal State Table to derive the logic.

| Current State ($Q_n$) | Input (MOSI, SCLK) | Next State ($Q_{n+1}$) | Output |
| :--- | :--- | :--- | :--- |
| $S_0$ (000) | 0 0 | $S_0$ | 0 |
| $S_0$ (000) | 1 1 (Match) | $S_1$ | 0 |
| ... | ... | ... | ... |

### Requirements:

1.  Map every transition from the diagram to the table.
2.  Assign min-term names (e.g., $m_1, m_2$) to rows.
3.  Plan for unused states (Don't Cares or Reset).

---

## Step 3: Boolean Equation Derivation

Derive the **Left Box Equations** for the Next State logic using the State Table.

  * **Format:** Sum-of-Products (SOP).
  * **Covering:** You must explicitly illustrate the covering of each term (e.g., K-Map grouping).

### Example Format

$$ Q_0 = (\overline{Q_4} \cdot \overline{Q_2} \cdot Q_0 \cdot SCLK \cdot MOSI) + ... $$

  * **Note:** The equations must explain *why* they are written that way. Do not just state the final result.

---
layout: two-cols
---

## Implementation Workflow

### 1\. Quartus Simulation (Task 5)

  * **Schematic Entry:** Convert Left Box equations to logic gates manually.
  * **No HDL:** VHDL/Verilog code is **strictly forbidden** for the core logic.
  * **Testing:**
      * Correct Code Test.
      * 4th Bit Error Test.
      * Continuous Sequence Test.

:: right ::

### 2\. Hardware Build (Task 6 & 7)

  * **Breadboard:**
      * Solid hard wire only.
      * Right-angle bending (no "bird's nest").
      * **Selfie Requirement:** Every 1 hour of work.
  * **PCB:**
      * Final verified design soldered on PCB.
      * Use pin headers for interface (MOSI, SCLK, Detected).


---

## Summary of Deliverables

**Video Presentation** (Strict 12-topic sequence)
<br>
**PDF Report** (Equations, Schematics)
<br>
**Physical Circuit** (Breadboard & PCB)

<br>

<div class="text-xl font-bold text-red-600">
Warning: "Bird nest like is un-acceptable"
</div>
