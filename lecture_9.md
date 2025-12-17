---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: "Lecture 9 - Dedicated Microprocessors: Datapath"
---

# Lecture 9: Dedicated Microprocessors: Datapath
{{ $slidev.configs.subject }}


{{ $slidev.configs.author }}
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
layout: two-cols-header
---

## The Von Neumann Model of a Computer

A computer system can be modeled with five basic components. The microprocessor contains the core processing elements.

:: left ::

*   **Input:** Provides data to the system.
*   **Output:** Displays results from the system.
*   **Memory:** Stores programs and data.
*   **Microprocessor:** The "brain" of the system.
    *   **Datapath:** Performs data processing operations (arithmetic, logic).
    *   **Control Unit:** Determines the sequence of operations.

:: right ::

<img src="/von_neumann_model.svg" class="rounded-lg bg-white p-4 w-full" alt="Von Neumann Model of a Computer"/>
<p class="text-center text-sm">Figure 9-1: The Von Neumann Model of a Computer</p>


---
layout: two-cols
---

## From Transistors to Microprocessors
**Complexity is managed through layers of abstraction.**
1.  **Transistors** combine to form logic **Gates**.
2.  Gates build **Combinational** and **Sequential Circuits**.
3.  Circuits form functional **Components** (e.g., Adders, MUXes).
4.  Components integrate into a **Datapath** and **Control Unit**.
5.  These units constitute the **Microprocessor**.

:: right ::

<img src="/digital_hierarchy.svg" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="Hierarchy of digital components"/>
<p class="text-center text-sm">Figure 9-2: Hierarchy of digital components</p>

---

## Dedicated Microprocessors

**Dedicated microprocessors**, also known as **Application-Specific Integrated Circuits (ASICs)**, are designed to perform a single, specific task.

*   The instructions for performing that one task are **hardwired** into the processor itself.
*   They are highly optimized for their specific function in terms of speed, power, and size.
*   Once manufactured, their function cannot be modified.
*   Examples: A chip in a digital camera for image processing, a controller in a microwave oven.

---
layout: two-cols-header
---

## Datapath and Control Unit



A microprocessor is partitioned into two main parts that work together.

:: left ::
<div class="text-base">

*   **Datapath:**
    *   Performs the data processing operations.
    *   Contains functional units like ALUs, registers, counters, and multiplexers.
    *   This is where the "number crunching" happens.

*   **Control Unit:**
    *   Determines the sequence of datapath operations.
    *   Generates **control signals** to tell the datapath what to do in each clock cycle.
    *   Receives **status signals** from the datapath (e.g., result is zero, A > B) to make decisions.

</div>

:: right ::

<img src="/datapath_control.svg" class="rounded-lg bg-white p-4 w-full" alt="Datapath and Control Unit Interaction"/>
<p class="text-center text-sm">Figure 9-3: Datapath and Control Unit Interaction</p>

---
layout: two-cols-header
---

## Register Transfer Level (RTL)



**Register Transfer Level (RTL)** is an abstraction used to describe the operation of a synchronous digital circuit.

::left::

*   It defines a circuit's behavior in terms of:
    1.  The flow of data (transfer) between hardware **registers**.
    2.  The **logical operations** performed on that data.
*   In the RTL model, we consider the flow of information 'in bulk' from one register to the next on each clock tick.
*   This is the level of abstraction used in Hardware Description Languages (HDLs) like VHDL and Verilog.

::right::

<img src="/rtl_model.svg" class="rounded-lg bg-white p-4 w-full" alt="RTL Model Diagram">
<p class="text-center text-sm">Figure 9-4: RTL Model Diagram</p>

---
layout: two-cols-header
---

## Designing a Dedicated Datapath

The goal is to build a circuit for solving a **single specific problem**. We assemble the necessary registers and functional units (like adders) to perform the required operations.

:: left ::

### Example 1: `A = B + C`

This datapath loads registers B and C, adds their values, and stores the result in register A when `ALoad` is asserted.

:: right ::

<img src="/datapath_A_B_plus_C.png" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Datapath for A = B + C">
<p class="text-center text-sm">Figure 9-5: Datapath for A = B + C</p>


---
layout: two-cols-header
---

## Designing a Dedicated Datapath (cont.)

:: left ::

### Example 2: `A = A + 3`

This datapath feeds the output of register A back to one input of an adder. The other input is the constant value `3`. The result is loaded back into A.

:: right ::

<img src="/datapath_A_plus_3.png" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="Datapath for A = A + 3">
<p class="text-center text-sm">Figure 9-6: Datapath for A = A + 3</p>

---
layout: two-cols
---

## Combining Datapaths with Multiplexers

What if we need to perform both `A = A + 3` and `A = B + C`? We can create a more flexible datapath by adding a multiplexer.

*   A MUX is placed at one of the adder's inputs.
*   A control signal (`Amux`) selects which data source to use for the operation.
    *   `Amux = 0`: Selects the output of register B.
    *   `Amux = 1`: Selects the constant value `3`.

:: right ::

<img src="/datapath_combine.png" class="rounded-lg bg-white p-4 w-95 mx-auto" alt="Combined Datapath with MUX">
<p class="text-center text-sm">Figure 9-7: Datapath for A = A + 3 with MUX</p>

---

To perform multiple operations using a single functional unit (the adder), we use **Multiplexers (MUXes)** on the inputs.

<div class="grid grid-cols-3 gap-4">
<div class="col-span-1">

*   **Input Mux 1**: Selects between Register `A` and Register `B`.
*   **Input Mux 2**: Selects between Register `C` and the constant `3`.
*   **Control Unit**: Generates select signals for the MUXes based on the required operation.
    *   For `A = A + 3`: Select `A` and `3`.
    *   For `A = B + C`: Select `B` and `C`. 

</div>
<div class="col-span-2">

<img src="/datapath_one_adder.png" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Datapath for A = A + 3 and A = B + C using only one adder">
<p class="text-center text-sm">Figure 9-8: Datapath for A = A + 3 and A = B + C using only one adder</p>

</div>
</div>

---

## Datapath for Conditional Logic (IF-THEN)

To implement conditional statements like `IF (A = 0) THEN...`, the datapath must generate a **status signal** for the control unit.

<div class="grid grid-cols-3 gap-4">
<div class="col-span-1">

*   An **equality comparator** can be used to check if the value in a register is equal to a constant.
*   For the condition `A = 0`, the comparator checks if all 8 bits of register A are 0.
*   This can be implemented efficiently with a single multi-input **NOR gate**. If any bit of A is 1, the NOR output is 0. If all bits are 0, the output is 1.

</div>

<div class="col-span-2">

<img src="/datapath_if.png" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Datapath for A=0 check">
<p class="text-center text-sm">Figure 9-9: Datapath for A=0 check; (a) Using comparator; (b) Using NOR gate</p>

</div>
</div>  

---


## Control Words

A **control word** is a binary vector containing all the control signals for the datapath for a given instruction. The control unit's job is to output the correct control word in each state.

<div class="grid grid-cols-3 gap-4">
<div class="col-span-1">

### Example: Control Word Table

For the datapath that performs `A = A + 3` and `A = B + C`.

$$
\def\arraystretch{1.5}
\begin{array}{|l|c|c|}
\hline
\textbf{Instruction} & \textbf{ALoad} & \textbf{Mux} \\
\hline
A = A + 3 & 1 & 1 \\
\hline
A = B + C & 1 & 0 \\
\hline
\end{array}
$$

</div>

<div class="col-span-2">

<img src="/datapath_one_adder.png" class="rounded-lg bg-white p-4 w-full" alt="Control Word Table Example"> 
<p class="text-center text-sm">Figure 9-8: Datapath for A = A + 3 and A = B + C</p>
</div>
</div>

---

## Example: `if-then-else` Datapath

<div class="grid grid-cols-2 gap-4">
<div class="col-span-1 text-base">

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

</div>

<div class="col-span-1">

<img src="/datapath_if_then_else.png" class="rounded-lg bg-white p-4 w-full" alt="if-then-else datapath">
<p class="text-center text-sm">Figure 9-10: Datapath for if-then-else</p>

</div>
</div>

---

## Example: `if-then-else` Control Words

The control unit would step through these control words based on the algorithm's flow.

<div class="grid grid-cols-2 gap-4">
<div class="col-span-1 text-base">





*   After step 1, the control unit checks the `(A=5)` status signal.
*   If `(A=5)` is true, it proceeds to control word 2.
*   If `(A=5)` is false, it proceeds to control word 3.
*   After step 2 or 3, it proceeds to control word 4.

$$
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|c|l|c|c|c|c|}
\hline
\textbf{CW} & \textbf{Instruction} & \textbf{ALoad} & \textbf{Muxsel} & \textbf{BLoad} & \textbf{Out} \\
\hline
1 & \text{INPUT A} & 1 & x & 0 & 0 \\
\hline
2 & B = 8 & 0 & 1 & 1 & 0 \\
\hline
3 & B = 13 & 0 & 0 & 1 & 0 \\
\hline
4 & \text{OUTPUT B} & 0 & x & 0 & 1 \\
\hline
\end{array}
$$

</div>

<div class="col-span-1">

<img src="/datapath_if_then_else.png" class="rounded-lg bg-white p-5 w-full mx-auto" alt="if-then-else datapath">
<p class="text-center text-sm">Figure 9-10: Datapath for if-then-else</p>

</div>
</div>



---
layout: two-cols-header
---

## Example: Generate and sum the numbers from 1 to 10

:: left ::

<div class="text-sm">

**Algorithm:** Generate and sum the numbers
from 1 to 10.
```
Sum = 0
i = 1
DO {
  Sum = Sum + i
  i = i + 1
} WHILE (i != 11)
OUTPUT Sum
```


1.  **Initialization**: `Sum` is cleared to 0, and the counter `i` is set to 1.
2.  **Accumulation**: In each iteration, the current value of `i` is added to `Sum`.
3.  **Increment**: The counter `i` is incremented by 1.
4.  **Termination**: The loop continues until `i` reaches 11 (after adding 10 to `Sum`).
5.  **Output**: Finally, the total `Sum` is outputted.

</div>




:: right ::

<img src="/datapath_sum_1_to_10.png" class="rounded-lg bg-white p-4 w-full" alt="Counter datapath with adder">
<p class="text-center text-sm">Figure 9-11: Datapath for summing numbers from 1 to 10</p>

---

*   **CW 1 & 3 (Update Sum)**: `sumLoad` is asserted. The value loaded is determined by `sumMux`. `iLoad` and `OE` are disabled. For CW 3, `addMux` is de-asserted (0) to use `Sum` as the second operand.
*   **CW 2 & 4 (Update i)**: `iLoad` is asserted. `iMux` selects the source (constant vs adder). For CW 4, `iMux` is asserted (1) for the increment operation.
*   **CW 5 (Output)**: `OE` is asserted to output the `Sum` value.

This can be implemented with a dedicated datapath using a register, an adder, and a comparator.

$$
\def\arraystretch{1.5}
\begin{array}{|c|l|c|c|c|c|c|c|}
\hline
\textbf{CW} & \textbf{Instruction} & \textbf{sumLoad} & \textbf{sumMux} & \textbf{iLoad} & \textbf{iMux} & \textbf{addMux} & \textbf{OE} \\
\hline
1 & \text{Sum} = 0 & 1 & 0 & 0 & \times & \times & 0 \\
\hline
2 & i = 1 & 0 & \times & 1 & 0 & \times & 0 \\
\hline
3 & \text{Sum} = \text{Sum} + i & 1 & 1 & 0 & \times & 0 & 0 \\
\hline
4 & i = i + 1 & 0 & \times & 1 & 1 & \times & 0 \\
\hline
5 & \text{OUTPUT Sum} & 0 & \times & 0 & \times & \times & 1 \\
\hline
\end{array}
$$


---

## Summary

*   The **Von Neumann Model** separates processing into a **Datapath** and a **Control Unit**.
*   **Datapath**: A collection of functional units (ALUs), registers, and buses that perform data operations.
*   **Control Unit**: Orchestrates the datapath by issuing **Control Words** (signals) based on the current state.
*   **RTL (Register Transfer Level)**: An abstraction for designing digital circuits by defining data flow between registers.
*   **Multiplexers (MUXes)** allow resource sharing (e.g., using one adder for multiple arithmetic operations).
*   **Status Signals** (from comparators) enable conditional branching in algorithms (IF-THEN, loops).

---

## Exercise 1: Datapath Design

**Question:**
Draw a dedicated datapath that can perform the operation:
$$ R1 = R1 - R2 $$

**Hint:**
*   You will need two registers (`R1`, `R2`).
*   You need a functional unit capable of subtraction (Subtractor or ALU).
*   Think about the paths for the operands and where the result is stored.
*   What control signals are needed? (e.g., `R1Load`, `SubtractEn`)

---

## Exercise 2: Control Signal Analysis

**Question:**
Refer to the **Combined Datapath** (Figure 9-8) which supports `A = A + 3` and `A = B + C`.
What would be the values of the control signals (`Amux`, `Bmux` equivalent MUX selectors) to perform the operation:
$$ A = B + 3 $$

**Assumption:**
*   Assume the Input 1 MUX can select `B`.
*   Assume the Input 2 MUX can select `3`.
*   Write down the state of the selectors (e.g., 0 or 1 based on your assumed truth table).

---

## Exercise 3: Conditional Logic

**Question:**
Design the hardware modification needed to support the instruction:
$$ \text{IF } (A > 10) \text{ THEN...} $$

**Hint:**
*   You need to compare register `A` with the constant `10`.
*   What kind of component compares two values?
*   What signal does it output to the Control Unit? (e.g., `AGreaterThan10`)

---

## Exercise 4: Sequence Design

**Question:**
Write the step-by-step **Control Word sequence** (similar to the Summation example) for **Swapping** the values of Register A and Register B.

**Hint:**
*   You cannot just say `A = B` and `B = A` in the same step if you don't have a temporary register or a specific swap path.
*   Assume you have a temporary register `Temp`.
*   **Step 1**: `Temp = A`
*   **Step 2**: `A = B`
*   **Step 3**: `B = Temp`
*   Define the control signals for each step.

