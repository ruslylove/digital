---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: "Lecture 9 - Dedicated Microprocessors: Datapath" 
---

# Lecture 9: Dedicated Microprocessors: Datapath
{{ $slidev.configs.subject }}
<div class="abs-br m-6 text-sm">
010113025 Digital Circuits and Logic Design
</div>

---

## Outline

*   The Von Neumann Model
*   Dedicated Microprocessors (ASICs)
*   Datapath and Control Unit
*   Register Transfer Level (RTL)
*   Designing Dedicated Datapaths
    *   Basic Operations
    *   Combining Operations with MUXes
    *   Handling Conditional Logic
*   Control Words

---

## The Von Neumann Model of a Computer

A computer system can be modeled with five basic components. The microprocessor contains the core processing elements.

*   **Input:** Provides data to the system.
*   **Output:** Displays results from the system.
*   **Memory:** Stores programs and data.
*   **Microprocessor:** The "brain" of the system.
    *   **Datapath:** Performs data processing operations (arithmetic, logic).
    *   **Control Unit:** Determines the sequence of operations.

<img src="https://i.imgur.com/g8V5G43.png" class="rounded-lg bg-white p-4 w-2/3" alt="Von Neumann Model">

---

## From Transistors to Microprocessors

We build complex systems by layering abstractions.

<img src="https://i.imgur.com/z488Y6J.png" class="rounded-lg bg-white p-4 w-2/3" alt="Hierarchy of digital components">

1.  **Transistors** are combined to create **Gates**.
2.  Gates form **Combinational** and **Sequential Circuits**.
3.  These circuits are used to build larger **Components** (adders, registers, MUXes).
4.  Components are assembled into a **Datapath** and a **Control Unit**.
5.  Together, they form a **Microprocessor**.

---

## Dedicated Microprocessors

**Dedicated microprocessors**, also known as **Application-Specific Integrated Circuits (ASICs)**, are designed to perform a single, specific task.

*   The instructions for performing that one task are **hardwired** into the processor itself.
*   They are highly optimized for their specific function in terms of speed, power, and size.
*   Once manufactured, their function cannot be modified.
*   Examples: A chip in a digital camera for image processing, a controller in a microwave oven.

---

## Datapath and Control Unit

A microprocessor is partitioned into two main parts that work together.

*   **Datapath:**
    *   Performs the data processing operations.
    *   Contains functional units like ALUs, registers, counters, and multiplexers.
    *   This is where the "number crunching" happens.

*   **Control Unit:**
    *   Determines the sequence of datapath operations.
    *   Generates **control signals** to tell the datapath what to do in each clock cycle.
    *   Receives **status signals** from the datapath (e.g., result is zero, A > B) to make decisions.

<img src="https://i.imgur.com/YgY1s3C.png" class="rounded-lg bg-white p-4 w-2/3" alt="Datapath and Control Unit Interaction">

---

## Register Transfer Level (RTL)

**Register Transfer Level (RTL)** is an abstraction used to describe the operation of a synchronous digital circuit.

*   It defines a circuit's behavior in terms of:
    1.  The flow of data (transfer) between hardware **registers**.
    2.  The **logical operations** performed on that data.

*   In the RTL model, we consider the flow of information 'in bulk' from one register to the next on each clock tick.
*   This is the level of abstraction used in Hardware Description Languages (HDLs) like VHDL and Verilog.

<img src="https://i.imgur.com/k9b821g.png" class="rounded-lg bg-white p-4 w-2/3" alt="RTL Model Diagram">

---

## Designing a Dedicated Datapath

The goal is to build a circuit for solving a **single specific problem**. We assemble the necessary registers and functional units (like adders) to perform the required operations.

### Example 1: `A = B + C`

This datapath loads registers B and C, adds their values, and stores the result in register A when `ALoad` is asserted.

<img src="https://i.imgur.com/643b24t.png" class="rounded-lg bg-white p-4 w-2/3" alt="Datapath for A = B + C">

---

## Designing a Dedicated Datapath (cont.)

### Example 2: `A = A + 3`

This datapath feeds the output of register A back to one input of an adder. The other input is the constant value `3`. The result is loaded back into A.

<img src="https://i.imgur.com/s64052X.png" class="rounded-lg bg-white p-4 w-2/3" alt="Datapath for A = A + 3">

---

## Combining Datapaths with Multiplexers

What if we need to perform both `A = A + 3` and `A = B + C`? We can create a more flexible datapath by adding a multiplexer.

*   A MUX is placed at one of the adder's inputs.
*   A control signal (`Amux`) selects which data source to use for the operation.
    *   `Amux = 0`: Selects the output of register B.
    *   `Amux = 1`: Selects the constant value `3`.

<img src="https://i.imgur.com/u389v4s.png" class="rounded-lg bg-white p-4 w-full" alt="Combined Datapath with MUX">

---

## Datapath for Conditional Logic (IF-THEN)

To implement conditional statements like `IF (A = 0) THEN...`, the datapath must generate a **status signal** for the control unit.

*   An **equality comparator** can be used to check if the value in a register is equal to a constant.
*   For the condition `A = 0`, the comparator checks if all 8 bits of register A are 0.
*   This can be implemented efficiently with a single multi-input **NOR gate**. If any bit of A is 1, the NOR output is 0. If all bits are 0, the output is 1.

<img src="https://i.imgur.com/j47y0tN.png" class="rounded-lg bg-white p-4 w-2/3" alt="Datapath for A=0 check">

---

## Control Words

A **control word** is a binary vector containing all the control signals for the datapath for a given instruction. The control unit's job is to output the correct control word in each state.

### Example: Control Word Table

For the datapath that performs `A = A + 3` and `A = B + C`.

<img src="https://i.imgur.com/3q1727x.png" class="rounded-lg bg-white p-4 w-full" alt="Control Word Table Example">

| Instruction | `ALoad` | `Mux` |
|:------------|:-------:|:-----:|
| `A = A + 3` | 1       | 1     |
| `A = B + C` | 1       | 0     |

---

## Example: `if-then-else` Datapath

**Algorithm:**
```
INPUT A
IF (A = 5) THEN
  B = 8
ELSE
  B = 13
END IF
OUTPUT B
```

**Datapath Components:**
*   Register `A` to hold the input.
*   Register `B` to hold the result.
*   A MUX to select between the constants `8` and `13`.
*   A comparator to generate the status signal `(A=5)`.
*   Control signals: `ALoad`, `BLoad`, `Muxsel`, `Out`.

<img src="https://i.imgur.com/v8t762L.png" class="rounded-lg bg-white p-4 w-full" alt="if-then-else datapath">

---

## Example: `if-then-else` Control Words

The control unit would step through these control words based on the algorithm's flow.

| Control Word | Instruction | `ALoad` | `Muxsel` | `BLoad` | `Out` |
|:------------:|:------------|:-------:|:--------:|:-------:|:-----:|
| 1            | `INPUT A`   | 1       | x        | 0       | 0     |
| 2            | `B = 8`     | 0       | 1        | 1       | 0     |
| 3            | `B = 13`    | 0       | 0        | 1       | 0     |
| 4            | `OUTPUT B`  | 0       | x        | 0       | 1     |

*   After step 1, the control unit checks the `(A=5)` status signal.
*   If `(A=5)` is true, it proceeds to control word 2.
*   If `(A=5)` is false, it proceeds to control word 3.
*   After step 2 or 3, it proceeds to control word 4.

---

## Example: Counter Datapath

**Algorithm:** Count from 1 to 10.
```
i = 0
WHILE (i != 10) {
  i = i + 1
  OUTPUT i
}
```

This can be implemented with a dedicated datapath using a register, an adder, and a comparator.

<img src="https://i.imgur.com/z488Y6J.png" class="rounded-lg bg-white p-4 w-2/3" alt="Counter datapath with adder">

A more efficient solution uses a **synchronous counter with parallel load and clear**, which combines the register and adder into one component.

<img src="https://i.imgur.com/5u0wJ6v.png" class="rounded-lg bg-white p-4 w-2/3" alt="Counter datapath with up-counter">