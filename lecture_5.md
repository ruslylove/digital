---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 5 - Combinational Circuit Building Blocks
---

# Lecture 5: Combinational Circuit Building Blocks
{{ $slidev.configs.subject }}
<div class="abs-br m-6 text-sm">
010113025 Digital Circuits and Logic Design
</div>

---

## Outline

*   Analysis & Design Procedure
*   Decoders & Encoders
*   Multiplexers
*   Three-State Gates
*   Arithmetic Circuits
    *   Adders (Binary, BCD)
    *   Comparators

---

## Combinational vs. Sequential Circuits

Logic circuits for digital systems can be classified into two types:

<div class="grid grid-cols-2 gap-8">

<div>

### Combinational Circuits
*   The outputs are a function of only the **current input** values.
*   They are "memoryless" - their behavior does not depend on past inputs.
*   **Example:** An adder. The sum output depends only on the numbers currently being applied to the inputs.

</div>

<div>

### Sequential Circuits
*   Contain memory elements (like Flip-Flops).
*   The outputs are a function of the **current inputs AND the state** of the memory elements.
*   The outputs also depend on **past inputs**, as past inputs determine the current state.
*   **Example:** A counter. The next count value depends on the current count value.

</div>

</div>

---
layout: two-cols-header
---

## Combinational Logic Circuit


*   A combinational circuit consists of logic gates whose outputs at any time are determined directly from the present combination of inputs without regard to previous inputs.
*   For *n* input variables, there are **2ⁿ** possible combinations of input values.

::left::


### Common Functions
*   Adders, Subtractors, Comparators
*   Decoders, Encoders, Multiplexers
*   These are often available as Medium-Scale Integration (MSI) circuits or standard cells in design libraries.

::right::

<div class="text-center">
<img src="/combinational_logic_circuit.svg" class="rounded-lg bg-white p-4 w-full" alt="Combinational Logic Circuit Diagram">
</div>



---

## Analysis Procedure

Analysis is the process of determining the function that a given circuit implements.

1.  **Ensure the circuit is combinational.**
    *   Verify there are no feedback paths or memory elements.
2.  **Derive its Boolean functions.**
    *   Label all gate outputs with arbitrary symbols.
    *   Find the Boolean functions for each gate output, starting from the inputs and working towards the final outputs.
    *   By substitution, derive the final output functions in terms of only the input variables.
3.  **Create a truth table.**
    *   Use the derived functions to compute the output values for all 2ⁿ input combinations.
4.  **Explain its function.**
    *   Observe the relationship between inputs and outputs in the truth table to provide a verbal explanation of what the circuit does.

---
layout: two-cols-header
---

## Analysis Example

::left::

<div class="pr-2">

### Step 1: Ensure the circuit is combinational.

Let's analyze the circuit below to find the functions for $F₁$ and $F₂$.



<img src="/analysis_example_circuit.svg" class="rounded-lg bg-white p-2" alt="Circuit for Analysis Example">

</div>

::right::

### Step 2: Deriving Expressions

<div class="text-sm pt-5">

1.  $F_2 = AB + AC + BC$
2.  $T_1 = A + B + C$
3.  $T_2 = ABC$
4.  $T_3 = F_2' \cdot T_1$
5.  $F_1 = T_3 + T_2$

Substituting to get $F_1$ in terms of A, B, C:

* $F_1 = (F_2' \cdot T_1) + T_2$
* $F_1 = (AB + AC + BC)' \cdot (A + B + C) + ABC$

After simplification (using De Morgan's theorem and algebraic manipulation), this becomes:

* $F_1 = A'B'C + A'BC' + AB'C' + ABC$

This is the sum output of a full adder: $F_1 = A \oplus B \oplus C$



</div>
---

<div class="grid grid-cols-2 gap-8">
<div>

### Step 3: Truth Table

By creating a truth table, we can verify the functions and understand the circuit's behavior.

$$
\begin{array}{|c|c|c|c|c|}
\hline
A & B & C & F_2 (\text{Carry}) & F_1 (\text{Sum}) \\
\hline
0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 1 \\
0 & 1 & 0 & 0 & 1 \\
0 & 1 & 1 & 1 & 0 \\
1 & 0 & 0 & 0 & 1 \\
1 & 0 & 1 & 1 & 0 \\
1 & 1 & 0 & 1 & 0 \\
1 & 1 & 1 & 1 & 1 \\
\hline
\end{array}
$$

</div>
<div>

### Step 4: Explain its function.
This circuit is a **Full Adder**.

*   **Inputs:** $A$, $B$, $C$ (where $C$ can be considered Carry-in)
*   **Output $F_1$:** The Sum bit ($F_1 = A \oplus B \oplus C$)
*   **Output $F_2$:** The Carry-out bit ($F_2 = AB + AC + BC$)

</div>
</div>
---

## Design Procedure

Design is the process of creating a circuit that meets a given set of specifications.

1.  **State the problem (System Spec).**
    *   Understand the requirements and desired behavior.
2.  **Determine the number of inputs and outputs.**
    *   The inputs determine the size of the truth table ($2^n$ rows).
3.  **Assign symbols** to the input and output variables.
    *   Typical inputs: $A, B, C, \dots$ or $x, y, z, \dots$
    *   Typical outputs: $F_1, F_2, \dots$ or $F, G, \dots$
4.  **Derive the truth table** that defines the required relationship between inputs and outputs.
5.  **Derive the simplified Boolean functions** for each output.
    *   Use **K-maps** or **Boolean algebra** to minimize the logic.
6.  **Draw the logic diagram** and verify its correctness.
    *   Implement using standard gates (AND, OR, NOT, NAND, NOR, etc.).

---

## Design Example: BCD to Excess-3 Code Converter

<div class="grid grid-cols-2 gap-8">
<div class="text-base pt-2">

1.  **Problem:** Design a circuit that converts a 4-bit Binary-Coded Decimal (BCD) digit to a 4-bit Excess-3 code.
2.  **Inputs/Outputs:** 4 input lines (for BCD) and 4 output lines (for Excess-3).
3.  **Symbols:** Inputs $A, B, C, D$; Outputs $w, x, y, z$.
<img src="/bcd_to_excess3_block.svg" class="rounded-lg bg-white p-4 w-60 mx-auto" alt="BCD to Excess-3 Block Diagram">
4.  **Truth Table:** Excess-3 code is found by adding 3 to the BCD value. BCD inputs from 10 to 15 are "don't care" conditions as they are not valid BCD digits.
</div>
<div>

$$
\begin{array}{|c|c|c|}
\hline
\text{Decimal} & \text{BCD (ABCD)} & \text{Excess-3 (wxyz)} \\
\hline
0 & 0000 & 0011 \\
1 & 0001 & 0100 \\
2 & 0010 & 0101 \\
3 & 0011 & 0110 \\
4 & 0100 & 0111 \\
5 & 0101 & 1000 \\
6 & 0110 & 1001 \\
7 & 0111 & 1010 \\
8 & 1000 & 1011 \\
9 & 1001 & 1100 \\
10-15 & 1010-1111 & \text{xxxx} \\
\hline
\end{array}
$$

</div>
</div>

---

5.  **Simplified Functions:** We create K-maps for each output $w, x, y, z$ using the truth table and "don't care" conditions to find the simplest expressions.

<div class="grid grid-cols-2 pb-4">

<img src="/bcd_kmaps_wx.svg" class="rounded-lg bg-white p-2" alt="K-Maps for w and x">
<img src="/bcd_kmaps_yz.svg" class="rounded-lg bg-white p-2 w-104" alt="K-Maps for y and z">

</div>

*   $w = A + BC + BD = A + B(C+D)$
*   $x = B'C + B'D + BC'D' = B'(C+D) + B(C+D)'$
*   $y = CD + C'D' = (C \oplus D)'$
*   $z = D'$

---

6.  **Draw the Logic Diagram:** The circuit is implemented based on the simplified Boolean functions.

<div class="grid grid-cols-2 gap-4">

<img src="/bcd_to_excess3_circuit.svg" class="rounded-lg bg-white p-5" alt="Logic Diagram for BCD to Excess-3 Converter">

<div>

**bcd_to_excess3.vhd**  
```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_excess3 is
    port ( A, B, C, D : in  std_logic;
           w, x, y, z : out std_logic );
end bcd_to_excess3;

architecture dataflow of bcd_to_excess3 is
begin
    z <= not D;
    y <= C xnor D;
    x <= B xor (C or D);
    w <= A or (B and (C or D));
end dataflow;
```
</div>

</div>

---
layout: two-cols-header
---

## Decoders

A **decoder** is a combinational circuit that converts binary information from *n* input lines to a maximum of **2ⁿ** unique output lines.

:: left ::

*   For any given input combination, only **one** output is active (e.g., HIGH), while all others are inactive (e.g., LOW).
*   Decoders are often called *n-to-m-line* decoders, where *m ≤ 2ⁿ*.

<img src="/decoder_3to8_block.svg" class="rounded-lg bg-white p-3 w-60 mx-auto" alt="Block Diagram of 3-to-8 Decoder">

:: right ::

<div class="pl-4">

### 3-to-8 Line Decoder



$$
\begin{array}{|c|c|c||c|c|c|c|c|c|c|c|}
\hline
x & y & z & D_0 & D_1 & D_2 & D_3 & D_4 & D_5 & D_6 & D_7 \\
\hline
0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & \mathbf{1} & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & 1 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 \\
1 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 \\
1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 \\
1 & 1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} \\
\hline
\end{array}
$$

</div>

---

<div class="grid grid-cols-2 gap-4">

<div>

### Logic Diagram

<img src="/decoder_3to8_circuit.svg" class="rounded-lg bg-white p-3 w-60" alt="Logic Diagram of 3-to-8 Decoder">

</div>

<div>

### VHDL Implementation

**decoder_3to8.vhd**
```vhdl {*}{lines:true}
library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
    port ( I : in  std_logic_vector(2 downto 0);
           D : out std_logic_vector(7 downto 0) );
end decoder_3to8;

architecture dataflow of decoder_3to8 is
begin
    D(0) <= not I(2) and not I(1) and not I(0);
    D(1) <= not I(2) and not I(1) and     I(0);
    D(2) <= not I(2) and     I(1) and not I(0);
    D(3) <= not I(2) and     I(1) and     I(0);
    D(4) <=     I(2) and not I(1) and not I(0);
    D(5) <=     I(2) and not I(1) and     I(0);
    D(6) <=     I(2) and     I(1) and not I(0);
    D(7) <=     I(2) and     I(1) and     I(0);
end dataflow;
```

</div>

</div>


---

## Decoder with Enable Input
<div class="grid grid-cols-2 gap-4">

<div class="text-base">

Decoders often include an **Enable** input (`E`) to control the circuit's operation.

*   If `E = 0` (for active-low enable), the decoder functions normally.
*   If `E = 1`, all outputs are disabled (e.g., all forced to 0 or 1, depending on the design).

$$
\small
\begin{array}{|c|ccc|cccccccc|}
\hline
E & x & y & z & D_0 & D_1 & D_2 & D_3 & D_4 & D_5 & D_6 & D_7 \\
\hline
1 & X & X & X & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 \\
0 & 0 & 0 & 0 & \mathbf{0} & 1 & 1 & 1 & 1 & 1 & 1 & 1 \\
0 & 0 & 0 & 1 & 1 & \mathbf{0} & 1 & 1 & 1 & 1 & 1 & 1 \\
0 & 0 & 1 & 0 & 1 & 1 & \mathbf{0} & 1 & 1 & 1 & 1 & 1 \\
0 & 0 & 1 & 1 & 1 & 1 & 1 & \mathbf{0} & 1 & 1 & 1 & 1 \\
0 & 1 & 0 & 0 & 1 & 1 & 1 & 1 & \mathbf{0} & 1 & 1 & 1 \\
0 & 1 & 0 & 1 & 1 & 1 & 1 & 1 & 1 & \mathbf{0} & 1 & 1 \\
0 & 1 & 1 & 0 & 1 & 1 & 1 & 1 & 1 & 1 & \mathbf{0} & 1 \\
0 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & \mathbf{0} \\
\hline
\end{array}
$$
</div>

<div>
<img src="/decoder_3to8_enable_circuit.svg" class="rounded-lg bg-white p-4 w-60 mx-auto" alt="3-to-8 Decoder with Enable Input Logic Diagram">
</div>

</div>

---

This allows us to cascade decoders to build larger ones. For example, two 3-to-8 decoders with an enable input can be used to create a 4-to-16 decoder.

<img src="/decoder_4to16_block.svg" class="rounded-lg bg-white p-4 w-70 mx-auto" alt="4-to-16 Decoder using two 3-to-8 Decoders">



---
layout: two-cols-header
---

## Encoders
An **encoder** performs the inverse operation of a decoder.
:: left ::

<div class="text-sm">

*   It has **2ⁿ** (or fewer) input lines and *n* output lines.
*   It converts a single active input line into its corresponding binary code on the output lines.
*   It is assumed that only **one** input line is active at a time.

**Octal-to-Binary Encoder (8-to-3)**
$$
\small
\begin{array}{|cccccccc|ccc|}
\hline
D_7 & D_6 & D_5 & D_4 & D_3 & D_2 & D_1 & D_0 & x & y & z \\
\hline
0 & 0 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 & 0 & \mathbf{1} & 0 & 0 & 0 & 1 & 0 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
\mathbf{1} & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1 \\
\hline
\end{array}
$$

* The logic is simple:
    *   $x = D_4 + D_5 + D_6 + D_7$
    *   $y = D_2 + D_3 + D_6 + D_7$
    *   $z = D_1 + D_3 + D_5 + D_7$

</div>

:: right ::

<img src="/encoder_8to3_circuit.svg" class="rounded-lg bg-white p-4 mx-auto w-full" alt="Octal-to-Binary Encoder (8-to-3) Logic Diagram">

---
layout: two-cols
---

## Priority Encoders

<div class="text-sm">

What happens if more than one input to a simple encoder is active? The output is undefined or incorrect.

A **priority encoder** solves this by establishing an importance level (priority) for the inputs.

*   If multiple inputs are active, the encoder outputs the binary code corresponding to the input with the **highest priority**.
*   They also usually include a "Valid" output (`V`) to indicate if any input is active.

**4-to-2 Priority Encoder (D₃ is highest priority)**


$$
\small
\begin{array}{|cccc|ccc|}
\hline
D_3 & D_2 & D_1 & D_0 & x & y & V \\
\hline
0 & 0 & 0 & 0 & X & X & 0 \\
0 & 0 & 0 & 1 & 0 & 0 & 1 \\
0 & 0 & 1 & X & 0 & 1 & 1 \\
0 & 1 & X & X & 1 & 0 & 1 \\
1 & X & X & X & 1 & 1 & 1 \\
\hline
\end{array}

$$

</div>

:: right ::

<img src="/priority_encoder_circuit.svg" class="rounded-lg bg-white p-4 mx-auto" alt="4-to-2 Priority Encoder Logic Diagram">



---

## Multiplexers (MUX)

A **multiplexer** (or data selector) is a circuit that selects binary information from one of many input lines and directs it to a single output line.

*   It has **2ⁿ** data input lines, **n** selection lines, and **one** output line.
*   The selection lines determine which data input is connected to the output.

<div class="grid grid-cols-2 gap-8 items-center">

<img src="https://i.imgur.com/k91206t.png" class="rounded-lg bg-white p-4" alt="4-to-1 MUX Logic Diagram">

<div>

**4-to-1 MUX**

| S₁ | S₀ | Y (Output) |
|:--:|:--:|:----------:|
| 0  | 0  |     I₀     |
| 0  | 1  |     I₁     |
| 1  | 0  |     I₂     |
| 1  | 1  |     I₃     |

</div>
</div>

### VHDL Implementation

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
    port ( I : in  std_logic_vector(3 downto 0);
           S : in  std_logic_vector(1 downto 0);
           Y : out std_logic );
end mux_4to1;

architecture behavioral of mux_4to1 is
begin
    Y <= I(to_integer(unsigned(S)));
end behavioral;
```

---

## Three-State Gates

A **three-state gate** (or tri-state buffer) exhibits three possible output states:
1.  Logic **0** (LOW)
2.  Logic **1** (HIGH)
3.  **High-Impedance (Hi-Z)**

*   The Hi-Z state behaves like an open circuit. The output is disconnected and has no logic significance.
*   A control input (`C`) determines the output state.
    *   If `C=1`, the gate is enabled: `Output = Input`.
    *   If `C=0`, the gate is disabled: `Output = Hi-Z`.

<img src="https://i.imgur.com/83J2y5r.png" class="rounded-lg bg-white p-4 w-96" alt="Three-State Buffer">

Three-state gates are useful for connecting multiple devices to a common wire (a **bus**), where only one device can drive the bus at a time.

---

## Magnitude Comparator

A **magnitude comparator** is a circuit that compares two binary numbers (A and B) and determines their relative magnitude.

*   **Outputs:** Three outputs are typical: `A > B`, `A = B`, and `A < B`.
*   **Algorithm:** The comparison is done bit-by-bit, starting from the most significant bit (MSB).
    *   `A = B` if all corresponding bits are equal (`Aᵢ = Bᵢ` for all `i`).
    *   `A > B` if there is a bit position `i` where `Aᵢ = 1` and `Bᵢ = 0`, and all higher-order bits are equal.
    *   `A < B` if there is a bit position `i` where `Aᵢ = 0` and `Bᵢ = 1`, and all higher-order bits are equal.

<img src="https://i.imgur.com/2k8v3vN.png" class="rounded-lg bg-white p-4 w-full" alt="4-bit Magnitude Comparator Circuit">