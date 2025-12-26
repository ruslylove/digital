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
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

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
layout: section
---

## Datapath Design

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
<p class="text-center text-sm">Figure 9-10: Datapath for A = A + 3 and A = B + C</p>
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
<p class="text-center text-sm">Figure 9-11: Datapath for if-then-else</p>

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
<p class="text-center text-sm">Figure 9-12: Datapath for if-then-else</p>

</div>
</div>



---
layout: two-cols-header
---

## Example: Sum the numbers from 1 to 10

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
<p class="text-center text-sm">Figure 9-13: Datapath for summing numbers from 1 to 10</p>

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
<p class="text-center text-sm">Figure 9-14: Datapath for summing numbers from 1 to 10</p>
</div>
</div>




---
layout: section
---

## Control Unit (FSM) Design



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
<p class="text-center text-sm">Figure 9-15: Datapath and Control Unit Interaction</p>

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
<p class="text-center text-sm">Figure 9-16: Counter Control Unit FSM</p>


</div>
</div>



---

**Datapath:**
<img src="/counter_datapath.svg" class="rounded-lg bg-white p-4 w-full h-60 object-contain mx-auto" alt="Counter Datapath">
<p class="text-center text-sm">Figure 9-17: Counter Datapath</p>

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
<p class="text-center text-sm">Figure 9-18: Counter Control Logic Circuit</p>

</div>
</div>

---

## Counter Control Unit: Complete Microprocessor

<div class="grid grid-cols-3 gap-8">

<div>

By combining the datapath and the synthesized control unit, we get the complete dedicated microprocessor. The control unit's logic generates the `Clear` and `Count` signals, while the `(i=10)` status signal from the datapath feeds back into the control unit's next-state logic.



</div>

<div class="col-span-2">
<img src="/counter_combined.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Complete Counter Microprocessor">
<p class="text-center text-sm">Figure 9-19: Complete Counter Microprocessor</p>
</div>
</div>

---

## Design Example 2: `if-then-else` Control Unit

<div class="grid grid-cols-2 gap-8">

<div class="text-sm">

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

* **Status Signal:** `(A=5)`
* **Control Signals:** `ALoad`, `BLoad`, `Muxsel`, `Out`
* **Control Word Table:**
$$
\scriptsize
\def\arraystretch{1.5}
\begin{array}{|l|c|c|c|c|}
\hline
\textbf{Instructions (States)} & \textbf{ALoad} & \textbf{BLoad} & \textbf{Muxsel} & \textbf{Out} \\ \hline
\text{INPUT A} \space (S_{input})    & 1 & 0 & X & 0 \\ \hline
\text{EXTRA} \space (S_{extra})    & 0 & 0 & X & 0 \\ \hline
\text{B = 8} \space (S_{equal})    & 0 & 1 & 0 & 0 \\ \hline
\text{B = 13} \space (S_{notequal}) & 0 & 1 & 1 & 0 \\ \hline
\text{OUTPUT B} \space (S_{output})   & 0 & 0 & X & 1 \\ \hline
\end{array}
$$

</div>

<div class="text-base">

**Datapath:**
<img src="/if_then_else_datapath.svg" class="rounded-lg bg-white p-4 w-90 object-contain mx-auto" alt="if-then-else datapath">
<p class="text-center text-sm">Figure 9-20: if-then-else Datapath</p>

</div>
</div>


---

**Control Unit FSM (State Diagram):**

*   **$S_{input}$:** Load register A.
*   **$S_{extra}$:** A wait state to allow register A to settle before checking its value.
*   **$S_{equal}$:** Load B with 8.
*   **$S_{notequal}$:** Load B with 13.
*   **$S_{output}$:** Output the value from B.

<img src="/if_then_else_fsm.svg" class="rounded-lg bg-white p-4 w-120 object-contain mx-auto" alt="If-Then-Else Control Unit FSM">
<p class="text-center text-sm">Figure 9-21: If-Then-Else Control Unit FSM</p>

---

## `if-then-else` Control Unit: Synthesis

From the state diagram, we derive the state and output tables to synthesize the logic.

**State Assignment:** `S_input=000`, `S_extra=001`, `S_notequal=010`, `S_equal=011`, `S_output=100`

<div class="grid grid-cols-2 gap-8">

<div>

### Next State Table

$$
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|c|c|c|}
\hline
\textbf{Present State} & \textbf{Input } (A=5) & \textbf{Next State} \\
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
\footnotesize
\def\arraystretch{1.5}
\begin{array}{|c|l|c|c|c|c|}
\hline
\textbf{State} & \textbf{Name} & \textbf{ALoad} & \textbf{Muxsel} & \textbf{BLoad} & \textbf{Out} \\
\hline
000 & S_{input} & 1 & X & 0 & 0 \\
\hline
001 & S_{extra} & 0 & X & 0 & 0 \\
\hline
010 & S_{equal} & 0 & 0 & 1 & 0 \\
\hline
011 & S_{notequal} & 0 & 1 & 1 & 0 \\
\hline
100 & S_{output} & 0 & X & 0 & 1 \\
\hline
\end{array}
$$

</div>
</div>

---

<div class="grid grid-cols-2 gap-8">

<div>

### Synthesized Logic:



* **State variables:** $Q_2, Q_1, Q_0$
* **Input:** $A=5$ (denoted as $I$)

**Next State Equations (D-Flip Flop):**
*   $D_2 = Q_2 + Q_1$
*   $D_1 = \bar{Q_1}Q_0$
*   $D_0 = \bar{Q_2}\bar{Q_1}(\bar{Q_0} + I)$

**Output Equations:**
*   $ALoad = \bar{Q_2}\bar{Q_1}\bar{Q_0}$
*   $BLoad = \bar{Q_2}Q_1$
*   $Muxsel = Q_0$
*   $Out = Q_2$

</div>

<div>

**VHDL Implementation (Structural):**

**IfThenElseControl.vhd**
```vhdl{*}{maxHeight:'330px',lines:true}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IfThenElseControl is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           A_eq_5   : in  STD_LOGIC;
           ALoad    : out STD_LOGIC;
           BLoad    : out STD_LOGIC;
           Muxsel   : out STD_LOGIC;
           Out_sig  : out STD_LOGIC);
end IfThenElseControl;

architecture Structural of IfThenElseControl is

    component d_ff
        Port ( D     : in  STD_LOGIC;
               Clk   : in  STD_LOGIC;
               Reset : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

    signal D, Q : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instantiate D Flip-Flops for State Register
    DFF2: d_ff port map (D(2), Clk, Reset, Q(2));
    DFF1: d_ff port map (D(1), Clk, Reset, Q(1));
    DFF0: d_ff port map (D(0), Clk, Reset, Q(0));

    -- Next State Logic
    D(2) <= Q(2) or Q(1);
    D(1) <= (not Q(1)) and Q(0);
    D(0) <= (not Q(2)) and (not Q(1)) and ((not Q(0)) or A_eq_5);

    -- Output Logic
    ALoad   <= (not Q(2)) and (not Q(1)) and (not Q(0));
    BLoad   <= (not Q(2)) and Q(1);
    Muxsel  <= Q(0);
    Out_sig <= Q(2);

end Structural;
```

</div>

</div>

---


<img src="/if_then_else_combined.svg" class="rounded-lg bg-white p-4 h-100 object-contain mx-auto" alt="if-then-else combined">
<p class="text-center text-sm">Figure 9-22: if-then-else Control Unit combined with Datapath</p>


---



## Design Example 3: GCD Control Unit

**Problem:** Design a control unit to find the Greatest Common Divisor (GCD) of two numbers, X and Y.

<div class="grid grid-cols-2 gap-8">

<div>

**Algorithm:**
```
INPUT X
INPUT Y
WHILE (X != Y) {
  IF (X > Y) THEN
    X = X - Y
  ELSE
    Y = Y - X
}
OUTPUT X
```



* **Status Signals:** `XeqY`, `XgtY`
* **Control Signals:** `In_X`, `In_Y`, `XLoad`, `YLoad`, `XY`, `Out`

</div>

<div>

**Datapath:**
<img src="/gcd_datapath.png" class="rounded-lg bg-white p-1 w-75 mx-auto" alt="GCD Datapath">
<p class="text-center text-sm">Figure 9-23: GCD Datapath</p>

</div>
</div>
---
layout: two-cols
---

**Control Unit FSM (State Diagram):**

*   **S₀ (Init):** Load X and Y.
*   **S₁ (Check):** Compare X and Y.
*   **S₂ (X=X-Y):** Perform subtraction.
*   **S₃ (Y=Y-X):** Perform subtraction.
*   **S₄ (Done):** Output the result.

:: right ::

<img src="/gcd_fsm.svg" class="rounded-lg bg-white p-4 w-full object-contain mx-auto" alt="GCD Control Unit FSM">
<p class="text-center text-sm">Figure 9-24: GCD Control Unit FSM</p>


---

### Structural VHDL: Components

Common components package and implementations.

```vhdl {*}{maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package gcd_components is
    
    component mux_2to1_8bit
        Port ( SEL : in  STD_LOGIC;
               A   : in  STD_LOGIC_VECTOR (7 downto 0);
               B   : in  STD_LOGIC_VECTOR (7 downto 0);
               Y   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component reg_8bit
        Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Reset : in  STD_LOGIC;
               Clk   : in  STD_LOGIC;
               Load  : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component subtractor_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               Diff : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component comparator_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               AeqB : out STD_LOGIC;
               AgtB : out STD_LOGIC);
    end component;

    component tristate_buffer_8bit
        Port ( Input  : in  STD_LOGIC_VECTOR (7 downto 0);
               Enable : in  STD_LOGIC;
               Output : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

end gcd_components;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- MUX 2:1 Implementation
entity mux_2to1_8bit is
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (7 downto 0);
           Y   : out STD_LOGIC_VECTOR (7 downto 0));
end mux_2to1_8bit;

architecture Behavioral of mux_2to1_8bit is
begin
    Y <= A when SEL = '0' else B;
end Behavioral;

-- Register Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_8bit is
    Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Reset : in  STD_LOGIC;
               Clk   : in  STD_LOGIC;
               Load  : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
end reg_8bit;

architecture Behavioral of reg_8bit is
signal storage : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                storage <= (others => '0');
            elsif Load = '1' then
                storage <= D;
            end if;
        end if;
    end process;
    Q <= storage;
end Behavioral;

-- Subtractor Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor_8bit is
    Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
           B    : in  STD_LOGIC_VECTOR (7 downto 0);
           Diff : out STD_LOGIC_VECTOR (7 downto 0));
end subtractor_8bit;

architecture Behavioral of subtractor_8bit is
begin
    Diff <= std_logic_vector(unsigned(A) - unsigned(B));
end Behavioral;

-- Comparator Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator_8bit is
    Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
           B    : in  STD_LOGIC_VECTOR (7 downto 0);
           AeqB : out STD_LOGIC;
           AgtB : out STD_LOGIC);
end comparator_8bit;

architecture Behavioral of comparator_8bit is
begin
    AeqB <= '1' when unsigned(A) = unsigned(B) else '0';
    AgtB <= '1' when unsigned(A) > unsigned(B) else '0';
end Behavioral;

-- Tristate Buffer Implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tristate_buffer_8bit is
    Port ( Input  : in  STD_LOGIC_VECTOR (7 downto 0);
           Enable : in  STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end tristate_buffer_8bit;

architecture Behavioral of tristate_buffer_8bit is
begin
    Output <= Input when Enable = '1' else (others => 'Z');
end Behavioral;
```

---

### Structural VHDL: Datapath

The structural datapath connecting components.

```vhdl {*}{maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.gcd_components.all; -- Use the package we defined

entity gcd_datapath is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           InputX   : in  STD_LOGIC_VECTOR (7 downto 0);
           InputY   : in  STD_LOGIC_VECTOR (7 downto 0);
           
           -- Control Signals
           In_X     : in  STD_LOGIC; -- 1 = Load External X, 0 = Load Result
           In_Y     : in  STD_LOGIC; -- 1 = Load External Y, 0 = Load Result
           XLoad    : in  STD_LOGIC;
           YLoad    : in  STD_LOGIC;
           XY       : in  STD_LOGIC; -- 0 = X-Y, 1 = Y-X
           Out_En   : in  STD_LOGIC;
           
           -- Status Signals
           XeqY     : out STD_LOGIC;
           XgtY     : out STD_LOGIC;
           
           -- Data Output
           OutputData : out STD_LOGIC_VECTOR (7 downto 0));
end gcd_datapath;

architecture Structural of gcd_datapath is

    signal X_Reg_Q, Y_Reg_Q : STD_LOGIC_VECTOR(7 downto 0);
    signal X_Mux_Out, Y_Mux_Out : STD_LOGIC_VECTOR(7 downto 0);
    signal Sub_A, Sub_B, Sub_Diff : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Register X
    -- Input MUX for X: Selects between Subtractor Result (0) and InputX (1)
    Mux_In_X: mux_2to1_8bit port map (
        SEL => In_X,
        A   => Sub_Diff,
        B   => InputX,
        Y   => X_Mux_Out
    );

    Reg_X: reg_8bit port map (
        D     => X_Mux_Out,
        Reset => Reset,
        Clk   => Clk,
        Load  => XLoad,
        Q     => X_Reg_Q
    );

    -- Register Y
    -- Input MUX for Y: Selects between Subtractor Result (0) and InputY (1)
    Mux_In_Y: mux_2to1_8bit port map (
        SEL => In_Y,
        A   => Sub_Diff,
        B   => InputY,
        Y   => Y_Mux_Out
    );

    Reg_Y: reg_8bit port map (
        D     => Y_Mux_Out,
        Reset => Reset,
        Clk   => Clk,
        Load  => YLoad,
        Q     => Y_Reg_Q
    );

    -- Comparator
    Comp: comparator_8bit port map (
        A    => X_Reg_Q,
        B    => Y_Reg_Q,
        AeqB => XeqY,
        AgtB => XgtY
    );

    -- Subtractor Operand Selection (Swap Logic)
    -- If XY=0 (X-Y): SubA=X, SubB=Y
    -- If XY=1 (Y-X): SubA=Y, SubB=X
    
    Mux_Sub_A: mux_2to1_8bit port map (
        SEL => XY,
        A   => X_Reg_Q,
        B   => Y_Reg_Q,
        Y   => Sub_A
    );

    Mux_Sub_B: mux_2to1_8bit port map (
        SEL => XY,
        A   => Y_Reg_Q,
        B   => X_Reg_Q,
        Y   => Sub_B
    );

    -- Subtractor
    Sub: subtractor_8bit port map (
        A    => Sub_A,
        B    => Sub_B,
        Diff => Sub_Diff
    );

    -- Output Tristate Buffer (Outputs X)
    Out_Buf: tristate_buffer_8bit port map (
        Input  => X_Reg_Q,
        Enable => Out_En,
        Output => OutputData
    );

end Structural;
```

---

### Structural VHDL: Control Unit

The Finite State Machine logic.

```vhdl {*}{maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gcd_control is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           
           -- Status Signals
           XeqY     : in  STD_LOGIC;
           XgtY     : in  STD_LOGIC;
           
           -- Control Signals
           In_X     : out STD_LOGIC;
           In_Y     : out STD_LOGIC;
           XLoad    : out STD_LOGIC;
           YLoad    : out STD_LOGIC;
           XY       : out STD_LOGIC;
           Out_En   : out STD_LOGIC);
end gcd_control;

architecture Behavioral of gcd_control is
    type StateType is (S0, S1, S2, S3, S4);
    signal CurrentState, NextState : StateType;
begin

    -- State Register
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                CurrentState <= S0;
            else
                CurrentState <= NextState;
            end if;
        end if;
    end process;

    -- Next State Logic
    process(CurrentState, XeqY, XgtY)
    begin
        case CurrentState is
            when S0 => -- Init: Load X and Y
                NextState <= S1;
            
            when S1 => -- Check
                if XeqY = '1' then
                    NextState <= S4; -- Done
                elsif XgtY = '1' then
                    NextState <= S2; -- X > Y
                else
                    NextState <= S3; -- Y > X
                end if;
                
            when S2 => -- X = X - Y
                NextState <= S1;
                
            when S3 => -- Y = Y - X
                NextState <= S1;
                
            when S4 => -- Done
                NextState <= S4; -- Stay here until Reset
                
            when others =>
                NextState <= S0;
        end case;
    end process;

    -- Output Logic
    process(CurrentState)
    begin
        -- Default values
        In_X   <= '0';
        In_Y   <= '0';
        XLoad  <= '0';
        YLoad  <= '0';
        XY     <= '0';
        Out_En <= '0';
        
        case CurrentState is
            when S0 => -- Load Inputs
                In_X  <= '1'; -- Select Input
                In_Y  <= '1'; -- Select Input
                XLoad <= '1';
                YLoad <= '1';
            
            when S1 => -- Check (No operation)
                NULL;
                
            when S2 => -- X = X - Y
                XY    <= '0'; -- X-Y
                In_X  <= '0'; -- Select Result
                XLoad <= '1';
                
            when S3 => -- Y = Y - X
                XY    <= '1'; -- Y-X (Swap)
                In_Y  <= '0'; -- Select Result
                YLoad <= '1';
                
            when S4 => -- Output
                Out_En <= '1';
                
            when others =>
                NULL;
        end case;
    end process;

end Behavioral;
```

---

### Structural VHDL: Top Level

Connecting Datapath and Control Unit.

```vhdl {*}{maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gcd_top is
    Port ( Clk    : in  STD_LOGIC;
           Reset  : in  STD_LOGIC;
           InputX : in  STD_LOGIC_VECTOR (7 downto 0);
           InputY : in  STD_LOGIC_VECTOR (7 downto 0);
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end gcd_top;

architecture Structural of gcd_top is

    component gcd_datapath
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               InputX   : in  STD_LOGIC_VECTOR (7 downto 0);
               InputY   : in  STD_LOGIC_VECTOR (7 downto 0);
               In_X     : in  STD_LOGIC;
               In_Y     : in  STD_LOGIC;
               XLoad    : in  STD_LOGIC;
               YLoad    : in  STD_LOGIC;
               XY       : in  STD_LOGIC;
               Out_En   : in  STD_LOGIC;
               XeqY     : out STD_LOGIC;
               XgtY     : out STD_LOGIC;
               OutputData : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component gcd_control
        Port ( Clk      : in  STD_LOGIC;
               Reset    : in  STD_LOGIC;
               XeqY     : in  STD_LOGIC;
               XgtY     : in  STD_LOGIC;
               In_X     : out STD_LOGIC;
               In_Y     : out STD_LOGIC;
               XLoad    : out STD_LOGIC;
               YLoad    : out STD_LOGIC;
               XY       : out STD_LOGIC;
               Out_En   : out STD_LOGIC);
    end component;

    -- Internal Signals
    signal In_X, In_Y, XLoad, YLoad, XY, Out_En : STD_LOGIC;
    signal XeqY, XgtY : STD_LOGIC;

begin

    -- Instantiate Datapath
    Datapath: gcd_datapath port map (
        Clk        => Clk,
        Reset      => Reset,
        InputX     => InputX,
        InputY     => InputY,
        In_X       => In_X,
        In_Y       => In_Y,
        XLoad      => XLoad,
        YLoad      => YLoad,
        XY         => XY,
        Out_En     => Out_En,
        XeqY       => XeqY,
        XgtY       => XgtY,
        OutputData => Output
    );

    -- Instantiate Control Unit
    Control: gcd_control port map (
        Clk => Clk,
        Reset => Reset,
        XeqY => XeqY,
        XgtY => XgtY,
        In_X => In_X,
        In_Y => In_Y,
        XLoad => XLoad,
        YLoad => YLoad,
        XY => XY,
        Out_En => Out_En
    );

end Structural;
```
---

<img src="/gcd.png" class="rounded-lg bg-white p-1 w-170 mx-auto" alt="GCD Control Unit and Datapath">
<p class="text-center text-sm">Figure 9-25: GCD Control Unit and Datapath</p>

<img src="/gcd_sim.png" class="rounded-lg bg-white p-1 w-full mx-auto" alt="GCD Simulation">
<p class="text-center text-sm">Figure 9-26: GCD Simulation</p>

---

## FSM+D vs. FSMD

There are two main methodologies for designing microprocessor systems in an HDL.

<div class="grid grid-cols-2 gap-8">

<div>

### FSM+D (FSM plus Datapath)
*   The FSM (Control Unit) and the Datapath are designed as **separate, manually constructed units**.
*   They are then connected together in a top-level module.
*   **Advantage:** You have full, explicit control over the datapath structure. This is useful for highly optimized or unusual datapaths. This is the method we have been following.

</div>

<div>

### FSMD (FSM with Datapath)
*   The entire design is described as a **single behavioral FSM** in an HDL.
*   Datapath operations (like `A <= B + C;`) are embedded directly within the FSM states.
*   The synthesis tool automatically infers and generates the necessary datapath components (registers, adders, MUXes) and connects them to the control unit.
*   **Advantage:** Faster and simpler design process for standard operations. This is the most common modern approach.

</div>
</div>

---

## FSMD Example: GCD Calculator

<div class="grid grid-cols-2 gap-8">
<div class="text-base">

**Algorithm:**
```
INPUT X, Y
WHILE (X != Y) {
  IF (X > Y) THEN
    X = X - Y
  ELSE
    Y = Y - X
}
OUTPUT X
```




**State Diagram:**

<img src="/gcd_fsm.svg" class="rounded-lg bg-white w-52 mx-auto" alt="GCD State Diagram">

</div>

<div>

**FSMD:**

```vhdl {*}{maxHeight:'350px',lines:true}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GCD is
    Port ( Clk      : in  STD_LOGIC;
           Reset    : in  STD_LOGIC;
           InputX   : in  UNSIGNED(7 downto 0);
           InputY   : in  UNSIGNED(7 downto 0);
           Output   : out UNSIGNED(7 downto 0));
end GCD;

architecture Behavioral of GCD is
    type StateType is (S0, S1, S2, S3, S4);
    signal State : StateType;
    signal X, Y  : UNSIGNED(7 downto 0);
begin

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                State <= S0;
            else
                case State is
                    when S0 =>  -- Init
                        X <= InputX; Y <= InputY;
                        State <= S1;
                    when S1 =>  -- Check
                        if (X = Y) then State <= S4;
                        elsif (X > Y) then State <= S2;
                        else State <= S3;
                        end if;
                    when S2 =>  -- X = X - Y
                        X <= X - Y;
                        State <= S1;
                    when S3 =>  -- Y = Y - X
                        Y <= Y - X;
                        State <= S1;
                    when S4 =>  -- Done
                        Output <= X;
                end case;
            end if; 
        end if; 
    end process; 

end Behavioral;
```

</div>
</div>

---

<img src="/gcd_fsmd.png" class="rounded-lg bg-white w-full mx-auto" alt="GCD Logic Diagram (Synthesized)">
<p class="text-center text-sm">Figure 9-27: GCD Logic Diagram (Synthesized)</p>

---

<img src="/gcd_fsmd_sim.png" class="rounded-lg bg-white w-full mx-auto" alt="GCD FSMD Simulation">
<p class="text-center text-sm">Figure 9-28: GCD FSMD Simulation</p>

---

## Lecture 9 Summary

*   **Dedicated Microprocessors (ASICs)** are designed for specific tasks, optimizing speed and efficiency.
*   **Architecture**: Divided into a **Datapath** (execution) and a **Control Unit** (decision making).
    *   **Datapath**: Registers, MUXes, ALUs, and Comparators.
    *   **Control Unit**: A Finite State Machine (FSM) that issues **Control Words** based on **Status Signals**.
*   **RTL (Register Transfer Level)**: Design abstraction focusing on data flow between registers.
*   **VHDL Implementation**:
    *   **FSM+D (Structural)**: Manually constructing and connecting Datapath and Control Unit components.
    *   **FSMD (Behavioral)**: describing the entire system behavior in a single FSM process, letting synthesis inference the hardware.

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
