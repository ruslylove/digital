---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 5 - Combinational Circuit Building Blocks
---

# Lecture 5: Combinational Circuit Building Blocks
{{ $slidev.configs.subject }}


{{ $slidev.configs.author }}
---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

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
<div class="text-center text-sm opacity-50 mt-2">Figure 5-1: Combinational Logic Circuit Diagram.</div>
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

<div class="pr-2 text-base">

### Step 1: Ensure the circuit is combinational.

Let's analyze the circuit below to find the functions for $F₁$ and $F₂$.



<img src="/analysis_example_circuit.svg" class="rounded-lg bg-white w-92" alt="Circuit for Analysis Example">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-2: Circuit for Analysis Example.</div>

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
<div class="text-center text-sm opacity-50 mt-2">Figure 5-3: BCD to Excess-3 Block Diagram.</div>

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

<div class="grid grid-cols-2">
<div>
<img src="/bcd_kmaps_wx.svg" class="rounded-lg bg-white p-2" alt="K-Maps for w and x">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-4: K-Maps for w and x.</div>
</div>
<div>
<img src="/bcd_kmaps_yz.svg" class="rounded-lg bg-white p-2 w-104" alt="K-Maps for y and z">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-5: K-Maps for y and z.</div>

</div>
</div>

<div class="text-sm">

*   $w = A + BC + BD = A + B(C+D)$
*   $x = B'C + B'D + BC'D' = B'(C+D) + B(C+D)'$
*   $y = CD + C'D' = (C \oplus D)'$
*   $z = D'$

</div>

---

6.  **Draw the Logic Diagram:** The circuit is implemented based on the simplified Boolean functions.

<div class="grid grid-cols-2 gap-4">

<div>
<img src="/bcd_to_excess3_circuit.svg" class="rounded-lg bg-white p-5" alt="Logic Diagram for BCD to Excess-3 Converter">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-6: Logic Diagram for BCD to Excess-3 Converter.</div>
</div>

<div>

**bcd_to_excess3.vhd**  
```vhdl {*}{maxHeight:'300px',lines:true}
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

## Decimal Adder (BCD Adder)

A **BCD Adder** adds two BCD digits in parallel and produces a sum digit also in BCD.

*   BCD digits range from 0 to 9.
*   Binary sum can range from 0 to 19 (9 + 9 + 1 carry).
*   **Correction is needed** if the binary sum exceeds 9 (10-19 are invalid BCD codes).

### Design Logic

1.  Design a combinational circuit that adds two BCD digits. It needs 8 inputs ($A_3 A_2 A_1 A_0,  B_3 B_2 B_1 B_0$) and 5 outputs ($Z_3 Z_2 Z_1 Z_0 K$). A truth table of 8 inputs (256 lines)! K-map of 8 variables is not possible!
2.  Possible to add the two BCD digits using a 4-bit binary adder.
3.  If the binary sum is greater than 9 ($K=1$ or $Z > 9$), add **6 (0110)** to the result.
    *   Adding 6 skips the 6 invalid states (10-15) and returns the sum to the correct BCD code.
    *   Need Correction Logic.



---

### Derivation of Correction Logic



The binary sum of two BCD digits can produce results from 0 to 19. We need to correct (Add 6) when the sum is invalid (10-15) or when there is a carry ($K=1$) for sums 16-19.

<div class="grid grid-cols-2 gap-4">

<div>

**Truth Table for Binary Sum ($Z_3 Z_2 Z_1 Z_0$) > 9:**

$$
\begin{array}{|c|c|c|c|c|c|c|}
\hline
\text{Decimal} & K & Z_3 & Z_2 & Z_1 & Z_0 & \text{Corr.} (C) \\
\hline
0-9 & 0 & - & - & - & - & 0 \\
10 & 0 & 1 & 0 & 1 & 0 & 1 \\
11 & 0 & 1 & 0 & 1 & 1 & 1 \\
12 & 0 & 1 & 1 & 0 & 0 & 1 \\
13 & 0 & 1 & 1 & 0 & 1 & 1 \\
14 & 0 & 1 & 1 & 1 & 0 & 1 \\
15 & 0 & 1 & 1 & 1 & 1 & 1 \\
16-19 & 1 & X & X & X & X & 1 \\
\hline
\end{array}
$$

</div>

<div>

**Boolean Algebra Derivation:**
*   $C=1$ if $K=1$.
*   For the range 10-15 ($K=0$), $Z_3$ is always 1.
    *   For 12-15: $Z_3$ and $Z_2$ are 1. $\rightarrow$ **Term: $Z_3 Z_2$**
    *   For 10-11: $Z_3$ and $Z_1$ are 1. $\rightarrow$ **Term: $Z_3 Z_1$** (Also covers 14-15 redundantly)
*   **Final Equation:** $C = K + Z_3 Z_2 + Z_3 Z_1$

</div>

</div>



---

<img src="/bcd_adder.svg" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="BCD Adder Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-7: BCD Adder Block Diagram.</div>

---

### VHDL Implementation
**bcd_adder.vhd**
```vhdl {*}{maxHeight:'380px',lines:true}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_adder is
    port ( A, B : in  std_logic_vector(3 downto 0); -- Input BCD digits
           Cin  : in  std_logic;                    -- Carry Input
           S    : out std_logic_vector(3 downto 0); -- Sum BCD digit
           Cout : out std_logic );                  -- Carry Output
end bcd_adder;

architecture behavioral of bcd_adder is
    signal sum_temp : unsigned(4 downto 0); -- 5 bits to hold sum up to 19
    signal sum_corr : unsigned(4 downto 0);
begin
    -- 1. Binary Addition
    sum_temp <= resize(unsigned(A), 5) + resize(unsigned(B), 5) + ("0000" & Cin);

    -- 2. Correction Logic (Check if > 9)
    process(sum_temp)
    begin
        if (sum_temp > 9) then
            sum_corr <= sum_temp + 6; -- Add 6 to correct
            Cout <= '1';
        else
            sum_corr <= sum_temp;
            Cout <= '0';
        end if;
    end process;

    -- 3. Output Sum
    S <= std_logic_vector(sum_corr(3 downto 0));
end behavioral;
```

---
layout: two-cols-header
---

## Decoders

A **decoder** is a combinational circuit that converts binary information from *n* input lines to a maximum of **2ⁿ** unique output lines.

:: left ::

*   For any given input combination, only **one** output is active (e.g., HIGH), while all others are inactive (e.g., LOW).
*   Decoders are often called *n-to-m-line* decoders, where *m ≤ 2ⁿ*.

<img src="/decoder_3to8_block.svg" class="rounded-lg bg-white p-3 w-48 mx-auto" alt="Block Diagram of 3-to-8 Decoder">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-8: Block Diagram of 3-to-8 Decoder.</div>

:: right ::

<div class="pl-4 text-base">

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

<img src="/decoder_3to8_circuit.svg" class="rounded-lg bg-white p-3 w-80 mx-auto" alt="Logic Diagram of 3-to-8 Decoder">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-9: Logic Diagram of 3-to-8 Decoder.</div>

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

<div class="grid grid-cols-2 gap-4">

<div class="text-base">

## Decoder with Enable Input


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
<img src="/decoder_3to8_enable_circuit.svg" class="rounded-lg bg-white p-4 w-85 mx-auto" alt="3-to-8 Decoder with Enable Input Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-10: 3-to-8 Decoder with Enable Input.</div>
</div>

</div>

---

This allows us to cascade decoders to build larger ones. For example, two 3-to-8 decoders with an enable input can be used to create a 4-to-16 decoder.

<img src="/decoder_4to16_block.svg" class="rounded-lg bg-white p-4 w-65 mx-auto" alt="4-to-16 Decoder using two 3-to-8 Decoders">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-11: 4-to-16 Decoder using two 3-to-8 Decoders.</div>


---

## Demultiplexers

A **demultiplexer** (DEMUX) is a circuit that takes information from a single input line and directs it to one of $2^n$ output lines.

*   It has **1** data input, **n** selection lines, and **2ⁿ** outputs.
*   It performs the inverse operation of a multiplexer.

### Relation to Decoders
<div class="grid grid-cols-2 gap-4 mt-4">
<div>

**A decoder with an enable input can function as a demultiplexer.**

*   **Decoder:** Enable input controls activation; Select inputs choose output.
*   **Demultiplexer:** The *Enable* input becomes the **Data Input**. The *Select* inputs steer this data to the selected output line.

</div>

<div>

**1-to-4 Demultiplexer Truth Table**

$$
\small
\begin{array}{|c|cc|cccc|}
\hline
\text{Data} & S_1 & S_0 & Y_0 & Y_1 & Y_2 & Y_3 \\
\hline
D & 0 & 0 & D & 0 & 0 & 0 \\
D & 0 & 1 & 0 & D & 0 & 0 \\
D & 1 & 0 & 0 & 0 & D & 0 \\
D & 1 & 1 & 0 & 0 & 0 & D \\
\hline
\end{array}
$$

</div>

</div>

---

<div>
<img src="/demux_1to4.svg" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="1-to-4 Demultiplexer Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-12: 1-to-4 Demultiplexer Logic Diagram.</div>
</div>

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

<img src="/encoder_8to3_circuit.svg" class="rounded-lg bg-white p-4 mx-auto w-95" alt="Octal-to-Binary Encoder (8-to-3) Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-13: Octal-to-Binary Encoder (8-to-3).</div>

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

<img src="/priority_encoder_circuit.svg" class="rounded-lg bg-white p-4 mx-auto w-92" alt="4-to-2 Priority Encoder Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-14: 4-to-2 Priority Encoder.</div>



---

## Multiplexers (MUX)

A **multiplexer** (or data selector) is a circuit that selects binary information from one of many input lines and directs it to a single output line.

<div class="grid grid-cols-2 gap-8">

<div>

*   It has **2ⁿ** data input lines, **n** selection lines, and **one** output line.
*   The selection lines determine which data input is connected to the output.

**4-to-1 MUX**

$$
\begin{array}{|cc|c|}
\hline
S_1 & S_0 & Y \text{ (Output)} \\
\hline
0 & 0 & I_0 \\
0 & 1 & I_1 \\
1 & 0 & I_2 \\
1 & 1 & I_3 \\
\hline
\end{array}
$$

</div>

<div>

<img src="/mux_4to1_logic.svg" class="rounded-lg bg-white w-62 mx-auto" alt="4-to-1 MUX Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-15: 4-to-1 MUX Logic Diagram.</div>


</div>
</div>

---

### VHDL Implementation

<div class="grid grid-cols-2 gap-8">

<div>

**mux_4to1.vhd (structural)**
<div class="text-xs text-gray-500 mb-2">Describing the circuit using logic gates and their connections.</div>
```vhdl{*}{lines:true}
library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
    port ( I : in  std_logic_vector(3 downto 0);
           S : in  std_logic_vector(1 downto 0);
           Y : out std_logic );
end mux_4to1;

architecture structural of mux_4to1 is
begin
    Y <= (I(0) and not S(1) and not S(0)) or
         (I(1) and not S(1) and     S(0)) or
         (I(2) and     S(1) and not S(0)) or
         (I(3) and     S(1) and     S(0));
end structural;
```

</div>

<div>

**mux_4to1.vhd (behavioral)**
<div class="text-xs text-gray-500 mb-2">Describing the circuit's function/algorithm without specifying the internal structure.</div>
```vhdl{*}{lines:true}
library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
    port ( I : in  std_logic_vector(3 downto 0);
           S : in  std_logic_vector(1 downto 0);
           Y : out std_logic );
end mux_4to1;

architecture behavioral of mux_4to1 is
begin
    Y <= I(0) when S = "00" else
         I(1) when S = "01" else
         I(2) when S = "10" else
         I(3);
end behavioral;
```

</div>
</div>

---

## Boolean Function Implementation using MUX

A multiplexer is essentially a **universal logic circuit**. Any Boolean function of $n$ variables can be implemented using a multiplexer with $n-1$ selection lines.

**Procedure:**
1.  Connect the first $n-1$ variables to the **Selection** inputs.
2.  The remaining single variable (say, $D$) is connected to the **Data** inputs.
3.  Each data input $I_k$ will be connected to either $D, D', 0,$ or $1$ based on the function's requirements utilizing an implementation table.

---

### Example: $F(A, B, C, D) = \Sigma(1, 3, 4, 11, 12, 13, 14, 15)$

<div class="grid grid-cols-2 gap-8">
<div>

**Implementation Table:**
Group the truth table by the selection variables ($A, B, C$).
Determine the output $F$ in terms of the data variable ($D$) for each group.

$$
\scriptsize
\begin{array}{cc}
\begin{array}{|cccc|c|c|}
\hline
S_2 & S_1 & S_0 & D & F & \text{MUX Input} \\
\hline
0 & 0 & 0 & 0 & 0 & I_0 = D \\
0 & 0 & 0 & 1 & 1 & \\
\hline
0 & 0 & 1 & 0 & 0 & I_1 = D \\
0 & 0 & 1 & 1 & 1 & \\
\hline
0 & 1 & 0 & 0 & 1 & I_2 = D' \\
0 & 1 & 0 & 1 & 0 & \\
\hline
0 & 1 & 1 & 0 & 0 & I_3 = 0 \\
0 & 1 & 1 & 1 & 0 & \\
\hline
\end{array}
&
\begin{array}{|cccc|c|c|}
\hline
S_2 & S_1 & S_0 & D & F & \text{MUX Input} \\
\hline
1 & 0 & 0 & 0 & 0 & I_4 = 0 \\
1 & 0 & 0 & 1 & 0 & \\
\hline
1 & 0 & 1 & 0 & 0 & I_5 = D \\
1 & 0 & 1 & 1 & 1 & \\
\hline
1 & 1 & 0 & 0 & 1 & I_6 = 1 \\
1 & 1 & 0 & 1 & 1 & \\
\hline
1 & 1 & 1 & 0 & 1 & I_7 = 1 \\
1 & 1 & 1 & 1 & 1 & \\
\hline
\end{array}
\end{array}
$$

</div>
<div>

**Logic Diagram using 8-to-1 MUX**

<img src="/mux_8to1_func.svg" class="rounded-lg bg-white p-4 w-60 mx-auto" alt="8-to-1 MUX Function Implementation">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-16: Boolean Function Implementation with 8-to-1 MUX.</div>

</div>
</div>

---
layout: default
---

## Shannon's Expansion Theorem

**Shannon's Expansion Theorem** states that any Boolean function $F(x_1, x_2, \dots, x_n)$ can be decomposed into two sub-functions (co-factors) derived by setting a variable $x_i$ to 0 and 1.

$$F(x_1, \dots, x_n) = \bar{x}_i \cdot F(x_1, \dots, 0, \dots, x_n) + x_i \cdot F(x_1, \dots, 1, \dots, x_n)$$

*   This corresponds directly to a **2-to-1 Multiplexer**:
    *   $x_i$ acts as the **Select** input.
    *   The co-factors $F_{x_i=0}$ and $F_{x_i=1}$ act as the Data inputs.

---
layout: two-cols-header
---

### MUX Synthesis Example

**Synthesis Theorem:** Any $n$-variable logic function can be implemented using a tree of $2^{n-1} - 1$ multiplexers (2-to-1).

:: left ::

**Example:** Implement $F(A,B,C) = A \cdot B + C$ using 2-to-1 MUXes.

1.  **Expand on A:**
    *   $F_{\bar{A}} = 0 \cdot B + C = C$
    *   $F_A = 1 \cdot B + C = B + C$
2.  **Expand co-factors on B:**
    *   For $F_A$:
        *   $F_{A\bar{B}} = 0 + C = C$
        *   $F_{AB} = 1 + C = 1$
3.  **Use C** as the input to the final MUXes.

:: right ::

<img src="/mux_tree_3var.svg" class="w-80 mx-auto" alt="Shannon Expansion MUX Tree"/>
<div class="text-center text-sm opacity-50 mt-2">Figure 5-17: 3-Variable MUX Tree.</div>

---
layout: two-cols-header
---

## Arithmetic Logic Unit (ALU)

The **Arithmetic Logic Unit (ALU)** is a combinational circuit that performs arithmetic and logic operations on binary numbers. A classic example is the **74381** 4-bit ALU.

:: left ::

*   It performs 8 different operations on two 4-bit operands ($A$ and $B$).
*   The operation is selected by a 3-bit input ($S_{2..0}$).
*   It generates **Group Propagate ($\bar{P}$)** and **Group Generate ($\bar{G}$)** signals.
*   These signals are critical for high-speed addition using **Carry Lookahead Generators** (like the 74182).

:: right ::

<img src="/alu_74381_block.svg" class="w-80 mx-auto" alt="74381 ALU Symbol"/>
<div class="text-center text-sm opacity-50 mt-2">Figure 5-18: 74381 ALU Block Diagram.</div>

---
layout: default
---

### 74381 Function Table

The 74381 provides the following functions based on the selection inputs:

$$
\begin{array}{ccc|l|l}
\textbf{S}_2 & \textbf{S}_1 & \textbf{S}_0 & \textbf{Function} & \textbf{Operation} \\
\hline
0 & 0 & 0 & \text{Clear} & F = 0000 \\
0 & 0 & 1 & \text{Subtract} & F = B - A \\
0 & 1 & 0 & \text{Subtract} & F = A - B \\
0 & 1 & 1 & \text{Add} & F = A + B \\
1 & 0 & 0 & \text{XOR} & F = A \oplus B \\
1 & 0 & 1 & \text{OR} & F = A + B \text{ (Logical)} \\
1 & 1 & 0 & \text{AND} & F = A \cdot B \\
1 & 1 & 1 & \text{Preset} & F = 1111 \\
\end{array}
$$

*   Note that subtraction is usually performed using 2's complement logic (e.g., $A + \bar{B} + 1$).
*   The P and G outputs allow for expansion to wider ALUs (e.g., 16-bit or 64-bit) without significant delay penalties.

---


### 1-Bit ALU Slice Logic

Each bit of the ALU contains logic to perform the selected operation and generate the local propagate/generate signals.

<div class="grid grid-cols-3 gap-8">
<div>

*   **Logic Unit:** Performs AND, OR, XOR.
*   **Arithmetic Unit:** A Full Adder simplifies to $P_i = A_i \oplus B_i$ and $G_i = A_i \cdot B_i$ for CLA.
*   **Multiplexer:** Selects the result based on $S$.

</div>
<div class="col-span-2">

<img src="/alu_74381_logic.svg" class="w-120 mx-auto" alt="1-Bit ALU Slice Logic"/>
<div class="text-center text-sm opacity-50 mt-2">Figure 5-19: Simplified 1-Bit ALU Slice.</div>

</div>
</div>

---
layout: two-cols-header
---

## Three-State Gates

:: left ::

A **three-state gate** (or tri-state buffer) exhibits three possible output states:
1.  Logic **0** (LOW)
2.  Logic **1** (HIGH)
3.  **High-Impedance (Hi-Z)**

<img src="/tri_state_buffer.svg" class="rounded-lg bg-white p-4 w-80 mt-8 mx-auto" alt="Three-State Buffer">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-20: Three-State Buffer.</div>

:: right ::

*   The Hi-Z state behaves like an open circuit. The output is disconnected and has no logic significance.
*   A control input (`C`) determines the output state.
    *   If `C=1`, the gate is enabled: `Output = Input`.
    *   If `C=0`, the gate is disabled: `Output = Hi-Z`.


* Three-state gates are useful for connecting multiple devices to a common wire (a **bus**), where only one device can drive the bus at a time.

---

### VHDL Implementation


**tri_state_buffer.vhd (behavioral)**
```vhdl{*}{lines:true}
library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer is
    port ( Input   : in  std_logic;
           Control : in  std_logic;
           Output  : out std_logic );
end tri_state_buffer;

architecture behavioral of tri_state_buffer is
begin
    Output <= Input when (Control = '1') else 'Z';
end behavioral;
```
<br>


> For the **Three-State Buffer**, only a **behavioral** design is possible. The high-impedance state (`Z`) is a fundamental property of the output driver circuit and cannot be constructed dynamically using standard Boolean logic gates (AND, OR, NOT) in a structural architecture.





---

## Magnitude Comparator

A **magnitude comparator** is a circuit that compares two binary numbers (A and B) and determines their relative magnitude.

*   **Outputs:** Three outputs are typical: $A > B$, $A = B$, and $A < B$.
*   **Algorithm:** The comparison is done bit-by-bit, starting from the most significant bit (MSB).
    *   $A = B$ if all corresponding bits are equal ($Aᵢ = Bᵢ$ for all $i$).
        *   (Note: The **XNOR** gate is the equivalence function: $x_i = A_i \odot B_i = 1$ if $A_i = B_i$).
    *   $A > B$ if there is a bit position $i$ where $Aᵢ = 1$ and $Bᵢ = 0$, and all higher-order bits are equal.
    *   $A < B$ if there is a bit position $i$ where $Aᵢ = 0$ and $Bᵢ = 1$, and all higher-order bits are equal.

Let $x_i = A_i \odot B_i$ (Equivalence).
$$
    \begin{aligned}
    (A=B) &= x_3 x_2 x_1 x_0 \\
    (A>B) &= A_3 \overline{B}_3 + x_3 A_2 \overline{B}_2 + x_3 x_2 A_1 \overline{B}_1 + x_3 x_2 x_1 A_0 \overline{B}_0 \\
    (A<B) &= \overline{A}_3 B_3 + x_3 \overline{A}_2 B_2 + x_3 x_2 \overline{A}_1 B_1 + x_3 x_2 x_1 \overline{A}_0 B_0
    \end{aligned}
    $$

---

### Logic Diagram of 4-bit Magnitude Comparator
<img src="/magnitude_comparator.svg" class="rounded-lg bg-white p-4 w-150 mx-auto" alt="4-bit Magnitude Comparator Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 5-21: 4-bit Magnitude Comparator.</div>

---

### VHDL Implementation of 4-bit Magnitude Comparator

<div class="grid grid-cols-2 gap-8">

<div>

**magnitude_comparator.vhd (behavioral)**
<div class="text-xs text-gray-500 mb-2">Describing the circuit's function/algorithm without specifying the internal structure.</div>

```vhdl{*}{maxHeight: '350px',lines: true}
library ieee;
use ieee.std_logic_1164.all;

entity magnitude_comparator is
    port ( A : in  std_logic_vector(3 downto 0);
           B : in  std_logic_vector(3 downto 0);
           A_Greater_B : out std_logic;
           A_Equal_B : out std_logic;
           A_Less_B : out std_logic );
end magnitude_comparator;

architecture behavioral of magnitude_comparator is
begin
    A_Greater_B <= '1' when A > B else '0';
    A_Equal_B <= '1' when A = B else '0';
    A_Less_B <= '1' when A < B else '0';
end behavioral;
```
</div>

<div>

**magnitude_comparator.vhd (structural)**
<div class="text-xs text-gray-500 mb-2">Describing the circuit using logic gates and their connections.</div>

```vhdl{*}{maxHeight: '350px',lines: true}
library ieee;
use ieee.std_logic_1164.all;

entity magnitude_comparator is
    port ( A : in  std_logic_vector(3 downto 0);
           B : in  std_logic_vector(3 downto 0);
           A_Greater_B : out std_logic;
           A_Equal_B : out std_logic;
           A_Less_B : out std_logic );
end magnitude_comparator;

architecture structural of magnitude_comparator is
    signal x : std_logic_vector(3 downto 0);
    signal term0, term1, term2, term3 : std_logic;
    signal A_Greater_B_int, A_Equal_B_int : std_logic;
begin
    -- Equivalence (x_i = A_i XNOR B_i)
    x <= not (A xor B);

    -- Terms for A > B (AND Gates)
    term3 <= A(3) and not B(3);
    term2 <= x(3) and A(2) and not B(2);
    term1 <= x(3) and x(2) and A(1) and not B(1);
    term0 <= x(3) and x(2) and x(1) and A(0) and not B(0);

    -- Output Logic
    A_Greater_B_int <= term3 or term2 or term1 or term0; -- OR Gate
    A_Equal_B_int   <= x(3) and x(2) and x(1) and x(0);  -- AND Gate
    
    -- Final Outputs
    A_Greater_B <= A_Greater_B_int;
    A_Equal_B   <= A_Equal_B_int;
    A_Less_B    <= not (A_Greater_B_int or A_Equal_B_int); -- NOR Gate logic
end structural;
```
</div>

</div>


---

## Lecture 5 Summary

<div class="grid grid-cols-2 gap-8">

<div>

### Decoders & Encoders
*   **Decoders**: Convert $n$-bit binary codes into $2^n$ unique output lines. Used for address decoding and implementing boolean functions.
*   **Encoders**: Perform the reverse operation, generating a binary code from active input lines. Priority encoders handle simultaneous inputs.

### Multiplexers (MUX)
*   **Data Selectors**: Route one of $2^n$ data inputs to a single output based on $n$ select lines.
*   **Universal Logic**: Can implement any Boolean function of $n$ variables.

</div>

<div>

### Tri-State Buffers
*   **Bus Drivers**: Allow multiple devices to share a common data line.
*   **Hi-Z State**: Disconnects the output, preventing short circuits (contention) when not driving the bus.

### Comparators
*   **Magnitude Comparison**: Compare two binary numbers ($A, B$) to determine relative magnitude ($A>B, A=B, A<B$).
*   **Cascadable**: Designed to be connected in series for wider bit-widths.

</div>

</div>

---
layout: section
---

## Lecture 5 Exercises

---

### Exercise 5-1: Multiplexer Expansion

**Problem:**
Construct a **4-to-1 Multiplexer** using only **2-to-1 Multiplexers**.

**Hints:**
*   A 4-to-1 MUX has 4 inputs ($I_0, I_1, I_2, I_3$) and 2 select lines ($S_1, S_0$).
*   How many 2-to-1 MUXs are needed? (Think about a tree structure).
*   Use the LSB select line ($S_0$) to select between pairs of inputs ($I_0/I_1$ and $I_2/I_3$) in the first stage.
*   Use the MSB select line ($S_1$) to select between the outputs of the first stage to produce the final output.

---

### Exercise 5-2: MUX Logic Implementation

**Problem:**
Implement the Boolean function $F(A, B, C) = \Sigma(1, 3, 5, 6, 7)$ using a single **4-to-1 Multiplexer**.

**Approach:**
1.  Connect variables $A$ and $B$ to the Select lines ($S_1, S_0$).
2.  Derive the inputs $I_0, I_1, I_2, I_3$ in terms of the variable $C$.
    *   **Case 00 ($A=0, B=0$):** Rows 0, 1. Output needs to be 1 at row 1 (so $I_0 = C$).
    *   **Case 01 ($A=0, B=1$):** Rows 2, 3. Output needs to be 1 at row 3 (so $I_1 = C$).
    *   **Case 10 ($A=1, B=0$):** Rows 4, 5. Output needs to be 1 at row 5 (so $I_2 = C$).
    *   **Case 11 ($A=1, B=1$):** Rows 6, 7. Output needs to be 1 at rows 6 and 7 (so $I_3 = 1$).

---

### Exercise 5-3: Tri-State Bus

**Problem:**
Explain why a standard logic gate (like an AND gate) cannot be connected directly in parallel with another standard logic gate outputs.


**Hints:**
*   What is the output voltage level for logic '1' vs logic '0'?
*   If one gate outputs '1' and another outputs '0' on the same wire, is there a low-resistance path created?
*   What happens to the current in such a path?
---

### Exercise 5-4: Comparator Analysis

**Problem:**
For a 4-bit magnitude comparator comparing $A = 1011$ and $B = 1001$:
1.  Determine the values of the intermediate signals $x_3, x_2, x_1, x_0$ (Equivalence).
2.  Determine the final outputs ($A>B, A=B, A<B$).

**Hints:**
*   Perform the equivalence operation ($x_i$) for each bit pair. Remember $x_i = 1$ only if bits match.
*   Start checking from the Most Significant Bit ($i=3$).
*   If $x_3$ is 1, check $x_2$. If $x_3$ is 0, the magnitudes are already decided by $A_3$ and $B_3$.
*   The first bit position (from MSB down) where $x_i = 0$ determines the result.



