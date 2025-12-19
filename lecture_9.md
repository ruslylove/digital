---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: "Lecture 9 - Dedicated Microprocessors"
---

# Lecture 9: Dedicated Microprocessors
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

<img src="/datapath_A_B_plus_C.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Datapath for A = B + C">
<p class="text-center text-sm">Figure 9-5: Datapath for A = B + C</p>


---


## Designing a Dedicated Datapath (cont.)



### Example 2: `A = A + 3`

This datapath feeds the output of register A back to one input of an adder. The other input is the constant value `3`. The result is loaded back into A.

<img src="/datapath_A_plus_3.svg" class="rounded-lg bg-white p-4 w-70 mx-auto" alt="Datapath for A = A + 3">
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



<div class="text-sm grid grid-cols-2 gap-4">
<div>

*   **CW 1 & 3 (Update Sum)**: `sumLoad` is asserted. The value loaded is determined by `sumMux`. `iLoad` and `OE` are disabled. For CW 3, `addMux` is de-asserted (0) to use `Sum` as the second operand.
*   **CW 2 & 4 (Update i)**: `iLoad` is asserted. `iMux` selects the source (constant vs adder). For CW 4, `iMux` is asserted (1) for the increment operation.
*   **CW 5 (Output)**: `OE` is asserted to output the `Sum` value.
This can be implemented with a dedicated datapath using a register, an adder, and a comparator.

<div class="text-sm">

$$
\scriptsize
\def\arraystretch{1.5}
\begin{array}{|c|l|c|c|c|c|c|c|}
\hline
\textbf{CW} & \textbf{Instruction} & \textbf{sumLoad} & \textbf{sumMux} & \textbf{iLoad} & \textbf{iMux} & \textbf{addMux} & \textbf{OE} \\
\hline
1 & \text{Sum} = 0 & 1 & 1 & 0 & \times & \times & 0 \\
\hline
2 & i = 1 & 0 & \times & 1 & 1 & \times & 0 \\
\hline
3 & \text{Sum} = \text{Sum} + i & 1 & 0 & 0 & \times & 0 & 0 \\
\hline
4 & i = i + 1 & 0 & \times & 1 & 0 & \times & 0 \\
\hline
5 & \text{OUTPUT Sum} & 0 & \times & 0 & \times & \times & 1 \\
\hline
\end{array}
$$

</div>
</div>

<div>
<img src="/datapath_sum_1_to_10.png" class="rounded-lg bg-white p-1 w-full mx-auto" alt="Counter datapath with adder">
<p class="text-center text-sm">Figure 9-11: Datapath for summing numbers from 1 to 10</p>
</div>
</div>




---
layout: section
---

## Control Unit (FSM)

---

## Recap: Datapath and Control Unit

A microprocessor is partitioned into two main parts that work together.

<div class="grid grid-cols-2 gap-4">
<div>

*   **Datapath:**
    *   Performs data processing operations. Contains ALUs, registers, MUXes, etc.
*   **Control Unit:**
    *   A Finite State Machine that determines the sequence of datapath operations.
    *   Generates **control signals** to tell the datapath what to do.
    *   Receives **status signals** from the datapath to make decisions.

</div>

<div>

<img src="/datapath_control.svg" class="rounded-lg bg-white p-4 w-full" alt="Datapath and Control Unit Interaction">
<p class="text-center text-sm">Figure 9-3: Datapath and Control Unit Interaction</p>

</div>
</div>

Our goal now is to design the **Control Unit** FSM.

---

## Design Example 1: Counter Control Unit

Let's design the control unit for the "Count from 1 to 10" algorithm.

<div class="grid grid-cols-2 gap-8">

<div>

**Algorithm:**
```
i = 0
WHILE (i != 10) {
  i = i + 1
}
```

**Control Unit FSM (State Diagram):**
*   **S₀ (Init):** Clear the counter (`i=0`).
*   **S₁ (Count):** Increment the counter (`i=i+1`).
*   **S₂ (Done):** Loop is finished.
</div>
<div>

<img src="/counter_fsm.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Counter Control Unit FSM">
<p class="text-center text-sm">Figure 9-12: Counter Control Unit FSM</p>


</div>
</div>



---

**Datapath:**
<img src="/counter_datapath.svg" class="rounded-lg bg-white p-4 w-full h-60 object-contain mx-auto" alt="Counter Datapath">
<p class="text-center text-sm">Figure 9-13: Counter Datapath</p>

* **Status Signal:** $(i\neq10)$
* **Control Signals:** `Clear`, `Count`

---

### Counter Control Unit: State & Output Tables

We can now create the tables from the state diagram.
**State Assignment:** `S₀=00`, `S₁=01`, `S₂=10`, `S₃(Halt)=11`.
**Input:** `(i=10)` status signal.

<div class="grid grid-cols-2 gap-8">

<div>

### Next State Table

$$
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|c|c|c|}
\hline
\textbf{Current State} & \textbf{Input } (i=10) & \textbf{Next State} \\
\hline
Q_1Q_0 & & D_1D_0 \\
\hline
00 (S_0) & X & 01 (S_1) \\
\hline
01 (S_1) & 0 & 01 (S_1) \\
\hline
01 (S_1) & 1 & 10 (S_2) \\
\hline
10 (S_2) & X & 11 (S_3) \\
\hline
11 (S_3) & X & 11 (S_3) \\
\hline
\end{array}
$$

</div>

<div>

### Output Table (Moore Model)

$$
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|c|c|c|}
\hline
\textbf{Current State} & \textbf{Clear} & \textbf{Count} \\
\hline
00 (S_0) & 1 & 0 \\
\hline
01 (S_1) & 0 & 1 \\
\hline
10 (S_2) & 0 & 0 \\
\hline
11 (S_3) & 0 & 0 \\
\hline
\end{array}
$$

</div>
</div>

From these tables, we can derive the logic equations for the FSM.


---

### Counter Control Unit: Logic Equations and Synthesis

From the tables, we derive the boolean equations (where $x$ is the input $(i=10)$):

<div class="grid grid-cols-2 gap-8">

<div>

**Next State Logic:**
$$
\begin{aligned}
D_1 &= Q_1 + Q_0 \cdot x \\
D_0 &= Q_1 + \overline{Q_0} + \overline{x}
\end{aligned}
$$

**Output Logic:**
$$
\begin{aligned}
Clear &= \overline{Q_1} \cdot \overline{Q_0} = \overline{Q_1 + Q_0} \quad (\text{NOR}) \\
Count &= \overline{Q_1} \cdot Q_0
\end{aligned}
$$

</div>

<div>

<img src="/counter_logic.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Counter Control Logic Circuit">
<p class="text-center text-sm">Figure 9-14: Counter Control Logic Circuit</p>

</div>
</div>

---

## Counter Control Unit: Complete Microprocessor

By combining the datapath and the synthesized control unit, we get the complete dedicated microprocessor. The control unit's logic generates the `Clear` and `Count` signals, while the `(i=10)` status signal from the datapath feeds back into the control unit's next-state logic.

<img src="https://i.imgur.com/u389v4s.png" class="rounded-lg bg-white p-4 w-full" alt="Complete Counter Microprocessor">

---

## Design Example 2: `if-then-else` Control Unit

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

<div class="grid grid-cols-2 gap-8">

<div>

**Datapath:**
<img src="https://i.imgur.com/v8t762L.png" class="rounded-lg bg-white p-4" alt="if-then-else datapath">

**Status Signal:** `(A=5)`
**Control Signals:** `ALoad`, `BLoad`, `Muxsel`, `Out`

</div>

<div>

**Control Unit FSM (State Diagram):**

*   **S_input:** Load register A.
*   **S_extra:** A wait state to allow register A to settle before checking its value.
*   **S_equal:** Load B with 8.
*   **S_notequal:** Load B with 13.
*   **S_output:** Output the value from B.

<img src="/if_then_else_fsm.svg" class="rounded-lg bg-white p-4 w-full h-60 object-contain mx-auto" alt="If-Then-Else Control Unit FSM">

</div>
</div>

---

## `if-then-else` Control Unit: Synthesis

From the state diagram, we derive the state and output tables to synthesize the logic.

**State Assignment:** `S_input=000`, `S_extra=001`, `S_notequal=010`, `S_equal=011`, `S_output=100`

<div class="grid grid-cols-2 gap-8">

<div>

### Next State Table (Partial)

$$
\def\arraystretch{1.5}
\begin{array}{|c|c|c|}
\hline
\textbf{PS} & \textbf{Input } (A=5) & \textbf{NS} \\
\hline
000 & X & 001 \\
\hline
001 & 0 & 010 \\
\hline
001 & 1 & 011 \\
\hline
010 & X & 100 \\
\hline
011 & X & 100 \\
\hline
100 & X & 100 \\
\hline
\end{array}
$$

</div>

<div>

### Output Table (Moore Model)

$$
\def\arraystretch{1.5}
\begin{array}{|c|c|c|c|c|}
\hline
\textbf{State} & \textbf{ALoad} & \textbf{Muxsel} & \textbf{BLoad} & \textbf{Out} \\
\hline
000 & 1 & X & 0 & 0 \\
\hline
010 & 0 & 0 & 1 & 0 \\
\hline
011 & 0 & 1 & 1 & 0 \\
\hline
100 & 0 & X & 0 & 1 \\
\hline
\end{array}
$$

</div>
</div>

**Synthesized Logic (from PDF):**
*   `ALoad = Q₂'Q₁'Q₀'`
*   `Muxsel = Q₂'Q₁'Q₀`
*   `BLoad = Q₂'Q₁`
*   `Out = Q₂Q₁'Q₀'`

---

## Design Example 3: GCD Control Unit

**Problem:** Design a control unit to find the Greatest Common Divisor (GCD) of two numbers, X and Y.

<div class="grid grid-cols-2 gap-8">

<div>

**Algorithm:**
```
WHILE (X != Y) {
  IF (X > Y) THEN
    X = X - Y
  ELSE
    Y = Y - X
}
```

**Datapath:**
<img src="https://i.imgur.com/s64052X.png" class="rounded-lg bg-white p-4" alt="GCD Datapath">

**Status Signals:** `XeqY`, `XgtY`

</div>

<div>

**Control Unit FSM (State Diagram):**

*   **S₀ (Init):** Load X and Y.
*   **S₁ (Check):** Compare X and Y.
*   **S₂ (X=X-Y):** Perform subtraction.
*   **S₃ (Y=Y-X):** Perform subtraction.
*   **S₄ (Done):** Output the result.

<img src="/gcd_fsm.svg" class="rounded-lg bg-white p-4 w-full h-60 object-contain mx-auto" alt="GCD Control Unit FSM">

</div>
</div>

---

## FSM+D vs. FSMD

There are two main methodologies for designing microprocessor systems in an HDL.

### FSM+D (FSM plus Datapath)
*   The FSM (Control Unit) and the Datapath are designed as **separate, manually constructed units**.
*   They are then connected together in a top-level module.
*   **Advantage:** You have full, explicit control over the datapath structure. This is useful for highly optimized or unusual datapaths. This is the method we have been following.

### FSMD (FSM with Datapath)
*   The entire design is described as a **single behavioral FSM** in an HDL.
*   Datapath operations (like `A <= B + C;`) are embedded directly within the FSM states.
*   The synthesis tool automatically infers and generates the necessary datapath components (registers, adders, MUXes) and connects them to the control unit.
*   **Advantage:** Faster and simpler design process for standard operations. This is the most common modern approach.

---

## Summary

*   The **Von Neumann Model** separates processing into a **Datapath** and a **Control Unit**.
*   **Datapath**: A collection of functional units (ALUs), registers, and buses that perform data operations.
*   **Control Unit**: Orchestrates the datapath by issuing **Control Words** (signals) based on the current state.
*   **RTL (Register Transfer Level)**: An abstraction for designing digital circuits by defining data flow between registers.
*   **Multiplexers (MUXes)** allow resource sharing (e.g., using one adder for multiple arithmetic operations).
*   **Status Signals** (from comparators) enable conditional branching in algorithms (IF-THEN, loops).

---
layout: section
---

## Lecture 9 Exercises

---

### Exercise 9-1: Datapath Design

**Question:**
Draw a dedicated datapath that can perform the operation:
$$ R1 = R1 - R2 $$

**Hint:**
*   You will need two registers (`R1`, `R2`).
*   You need a functional unit capable of subtraction (Subtractor or ALU).
*   Think about the paths for the operands and where the result is stored.
*   What control signals are needed? (e.g., `R1Load`, `SubtractEn`)

---

### Exercise 9-2: Control Signal Analysis

**Question:**
Refer to the **Combined Datapath** (Figure 9-8) which supports `A = A + 3` and `A = B + C`.
What would be the values of the control signals (`Amux`, `Bmux` equivalent MUX selectors) to perform the operation:
$$ A = B + 3 $$

**Assumption:**
*   Assume the Input 1 MUX can select `B`.
*   Assume the Input 2 MUX can select `3`.
*   Write down the state of the selectors (e.g., 0 or 1 based on your assumed truth table).

---

### Exercise 9-3: Conditional Logic

**Question:**
Design the hardware modification needed to support the instruction:
$$ \text{IF } (A > 10) \text{ THEN...} $$

**Hint:**
*   You need to compare register `A` with the constant `10`.
*   What kind of component compares two values?
*   What signal does it output to the Control Unit? (e.g., `AGreaterThan10`)

---

### Exercise 9-4: Sequence Design

**Question:**
Write the step-by-step **Control Word sequence** (similar to the Summation example) for **Swapping** the values of Register A and Register B.

**Hint:**
*   You cannot just say `A = B` and `B = A` in the same step if you don't have a temporary register or a specific swap path.
*   Assume you have a temporary register `Temp`.
*   **Step 1**: `Temp = A`
*   **Step 2**: `A = B`
*   **Step 3**: `B = Temp`
*   Define the control signals for each step.
