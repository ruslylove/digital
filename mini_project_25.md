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


# Mini Project 2025
## SPI Packet Detector

Design & Implementation of a Sequence Detector FSM


---
layout: default
---

## Project Objective: SPI Packet Detector

The goal is to design a digital circuit that monitors the **SPI (Serial Peripheral Interface)** bus and detects a specific 6-bit binary sequence unique to your Student ID.

<div class="grid grid-cols-2 gap-4 text-sm">

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

<img src="/spi_system_block.svg" class="rounded-lg bg-white p-2 w-90 mx-auto" alt="SPI Packet Detector System Block">

<br>

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

---

<img src="/spi_block_diagram.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="SPI Packet Detector Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 2: System Block Diagram (High Level)</div>





---

## Step 1: State Diagram Design

The design begins with a Mealy/Moore State Machine diagram.

  * **States:** Represent the progress of matching the sequence (e.g., $S_0$ start, $S_1$ 1st bit matched, etc.)
  * **Transitions:**
      * **CS (Chip Select):** Active Low. When `CS=1`, FSM resets to $S_0$ (Asynchronous Reset).
      * **MOSI & SCLK:** Drive transitions when `CS=0`.
      * Must account for correct bits (advance state) and incorrect bits (reset/partial reset).
  * **Validation:** Verify transition lines for all input combinations ($2^n$ lines per state).

  <br>



> **Task 5 Requirement:** Explain the origin of all transition numbers (e.g., `1xx`).

---

## Problem: SCLK vs System CLK Synchronization
<br>

> The system uses a fast `System CLK` (e.g., 50 MHz) while `MOSI` changes on the edge of a much slower `SCLK`.

**The Issue:**
*   If we use `SCLK` directly as a clock for flip-flops, we cross clock domains, leading to metastability or timing violations.
*   If we use `SCLK` as a simple input condition (`if SCLK = '1'`), the fast system clock will sample it as '1' for *many* cycles, causing the FSM to advance through multiple states erroneously in a single `SCLK` period.

**The Solution: Edge Detection**
*   We treat `SCLK` as a data input and synchronize it.
*   An **Edge Detector** circuit generates a single-cycle pulse (`SCLK_pulse`) exactly when `SCLK` transitions from 0 to 1.
*   The FSM transitions only when `SCLK_pulse = '1'`.

---

  <img src="/spi_block_diagram_edge.svg" class="rounded-lg bg-white p-4 w-full" alt="SPI Block Diagram with Edge Detector">
  <div class="text-center text-sm opacity-50 mt-2">Figure 3: System Block Diagram (Break down SCLK)</div>

  <img src="/edge_detector_fsm.svg" class="rounded-lg bg-white p-4 w-90 mx-auto" alt="Edge Detector FSM">
  <div class="text-center text-sm opacity-50 mt-2">Figure 4: Edge Detector State Machine</div>

---

<img src="/spi_sequence_fsm.svg" class="rounded-lg bg-white p-4 w-180 mx-auto" alt="State Diagram Example: 101011">
<div class="text-center text-sm opacity-50 mt-2">Figure 1: Example State Diagram for Sequence 101011</div>


---

## Output Modulator Logic
<br>

> The output triggers only when the system is in the "Match" state and modulated by a slower clock.

  <img src="/output_modulator.svg" class="rounded-lg bg-white p-4 w-full" alt="Output Modulator Circuit">
  <div class="text-center text-sm opacity-50 mt-2">Figure 5: Output Modulator Logic Circuit</div>
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


## Implementation Workflow

### 1\. Quartus Simulation (Task 5)

  * **Schematic Entry:** Convert Left Box equations to logic gates manually.
  * **No HDL:** VHDL/Verilog code is **strictly forbidden** for the core logic.
  * **Testing:**
      * Correct Code Test.
      * 4th Bit Error Test.
      * Continuous Sequence Test.


---

## Simulation & RTL Verification

Verification of the design using Quartus RTL Viewer and Waveform Simulation.

### Top Level RTL
<img src="/spi_top_level.png" class="rounded-lg w-full mx-auto p-4" alt="Top Level RTL">

---

### Edge Detector
<img src="/spi_edge.png" class="rounded-lg w-full mx-auto p-4" alt="Edge Detector RTL">


---

## RTL: FSM & Output Modulator

### Main FSM
<img src="/spi_main_fsm.png" class="rounded-lg w-150 mx-auto p-4" alt="Main FSM RTL">

---

### Output Modulator
<img src="/spi_output.png" class="rounded-lg w-full mx-auto p-4" alt="Output Modulator RTL">


---

## Simulation Cycle

Complete successful detection sequence simulation.

<img src="/spi_sim.png" class="rounded-lg w-full" alt="Simulation Waveform">

* Correct sequence
* 6th bit error (requirement is 4th bit)
* Continuous sequence (begin with 000...)

---

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

