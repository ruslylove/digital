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

## Combinational Logic Circuit

*   A combinational circuit consists of logic gates whose outputs at any time are determined directly from the present combination of inputs without regard to previous inputs.
*   For *n* input variables, there are **2ⁿ** possible combinations of input values.

<div class="text-center">
<img src="https://i.imgur.com/u5vV39l.png" class="rounded-lg bg-white p-4 w-2/3" alt="Combinational Logic Circuit Diagram">
</div>

### Common Functions
*   Adders, Subtractors, Comparators
*   Decoders, Encoders, Multiplexers
*   These are often available as Medium-Scale Integration (MSI) circuits or standard cells in design libraries.

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

Let's analyze the circuit below to find the functions for `F₁` and `F₂`.

::left::

<img src="https://i.imgur.com/g8V5G43.png" class="rounded-lg bg-white p-4" alt="Circuit for Analysis Example">

::right::

### Deriving Expressions

1.  `F₂ = AB + AC + BC` (This is the carry-out of a full adder)
2.  `T₁ = A + B + C`
3.  `T₂ = ABC`
4.  `T₃ = F₂' · T₁`
5.  `F₁ = T₃ + T₂`

Substituting to get `F₁` in terms of A, B, C:

`F₁ = (F₂' · T₁) + T₂`
`F₁ = (AB + AC + BC)' · (A + B + C) + ABC`

After simplification (using De Morgan's theorem and algebraic manipulation), this becomes:

`F₁ = A'B'C + A'BC' + AB'C' + ABC`

This is the sum output of a full adder: `F₁ = A ⊕ B ⊕ C`

---

## Analysis Example: Truth Table

By creating a truth table, we can verify the functions and understand the circuit's behavior. This circuit is a **Full Adder**.

*   **Inputs:** `A`, `B`, `C` (where C can be considered Carry-in)
*   **Output `F₁`:** The Sum bit (`A ⊕ B ⊕ C`)
*   **Output `F₂`:** The Carry-out bit

| A | B | C | F₂ (Carry) | F₁ (Sum) |
|:-:|:-:|:-:|:----------:|:--------:|
| 0 | 0 | 0 |     0      |    0     |
| 0 | 0 | 1 |     0      |    1     |
| 0 | 1 | 0 |     0      |    1     |
| 0 | 1 | 1 |     1      |    0     |
| 1 | 0 | 0 |     0      |    1     |
| 1 | 0 | 1 |     1      |    0     |
| 1 | 1 | 0 |     1      |    0     |
| 1 | 1 | 1 |     1      |    1     |

---

## Design Procedure

Design is the process of creating a circuit that meets a given set of specifications.

1.  **State the problem (System Spec).**
    *   Understand the requirements and desired behavior.
2.  **Determine the number of inputs and outputs.**
3.  **Assign symbols** to the input and output variables (e.g., A, B, C for inputs; X, Y, Z for outputs).
4.  **Derive the truth table** that defines the required relationship between inputs and outputs.
5.  **Derive the simplified Boolean functions** for each output (e.g., using K-maps).
6.  **Draw the logic diagram** and verify its correctness.

---

## Design Example: BCD to Excess-3 Code Converter

1.  **Problem:** Design a circuit that converts a 4-bit Binary-Coded Decimal (BCD) digit to a 4-bit Excess-3 code.
2.  **Inputs/Outputs:** 4 input lines (for BCD) and 4 output lines (for Excess-3).
3.  **Symbols:** Inputs `A, B, C, D`; Outputs `w, x, y, z`.
4.  **Truth Table:** Excess-3 code is found by adding 3 to the BCD value. BCD inputs from 10 to 15 are "don't care" conditions as they are not valid BCD digits.

| Decimal | BCD (ABCD) | Excess-3 (wxyz) |
|:-------:|:----------:|:---------------:|
| 0       | 0000       | 0011            |
| 1       | 0001       | 0100            |
| 2       | 0010       | 0101            |
| 3       | 0011       | 0110            |
| 4       | 0100       | 0111            |
| 5       | 0101       | 1000            |
| 6       | 0110       | 1001            |
| 7       | 0111       | 1010            |
| 8       | 1000       | 1011            |
| 9       | 1001       | 1100            |
| 10-15   | 1010-1111  | xxxx            |

---

## BCD to Excess-3: K-Maps & Simplification

5.  **Simplified Functions:** We create K-maps for each output `w, x, y, z` using the truth table and "don't care" conditions to find the simplest expressions.

<div class="grid grid-cols-2 gap-4">

<img src="https://i.imgur.com/k6v853g.png" class="rounded-lg bg-white p-2" alt="K-Maps for w and x">
<img src="https://i.imgur.com/9029t3o.png" class="rounded-lg bg-white p-2" alt="K-Maps for y and z">

</div>

*   `z = D'`
*   `y = CD + C'D' = C ⊕ D`
*   `x = B'C + B'D + BC'D' = B'(C+D) + B(C+D)'`
*   `w = A + BC + BD = A + B(C+D)`

---

## BCD to Excess-3: Logic Diagram

6.  **Draw the Logic Diagram:** The circuit is implemented based on the simplified Boolean functions.

<img src="https://i.imgur.com/8354c5y.png" class="rounded-lg bg-white p-4" alt="Logic Diagram for BCD to Excess-3 Converter">

### VHDL Implementation

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
    y <= C xor D;
    x <= (not B and (C or D)) or (B and not C and not D);
    w <= A or (B and (C or D));
end dataflow;
```

---

## Decoders

A **decoder** is a combinational circuit that converts binary information from *n* input lines to a maximum of **2ⁿ** unique output lines.

*   For any given input combination, only **one** output is active (e.g., HIGH), while all others are inactive (e.g., LOW).
*   Decoders are often called *n-to-m-line* decoders, where *m ≤ 2ⁿ*.

### 3-to-8 Line Decoder

| x | y | z | D₀ | D₁ | D₂ | D₃ | D₄ | D₅ | D₆ | D₇ |
|:-:|:-:|:-:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 0 | 0 | 0 | **1**| 0  | 0  | 0  | 0  | 0  | 0  | 0  |
| 0 | 0 | 1 | 0  | **1**| 0  | 0  | 0  | 0  | 0  | 0  |
| 0 | 1 | 0 | 0  | 0  | **1**| 0  | 0  | 0  | 0  | 0  |
| 0 | 1 | 1 | 0  | 0  | 0  | **1**| 0  | 0  | 0  | 0  |
| 1 | 0 | 0 | 0  | 0  | 0  | 0  | **1**| 0  | 0  | 0  |
| 1 | 0 | 1 | 0  | 0  | 0  | 0  | 0  | **1**| 0  | 0  |
| 1 | 1 | 0 | 0  | 0  | 0  | 0  | 0  | 0  | **1**| 0  |
| 1 | 1 | 1 | 0  | 0  | 0  | 0  | 0  | 0  | 0  | **1**|

### VHDL Implementation

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
    port ( I : in  std_logic_vector(2 downto 0);
           D : out std_logic_vector(7 downto 0) );
end decoder_3to8;

architecture behavioral of decoder_3to8 is
begin
    process(I)
    begin
        D <= (others => '0');
        D(to_integer(unsigned(I))) <= '1';
    end process;
end behavioral;
```

---

## Decoder with Enable Input

Decoders often include an **Enable** input (`E`) to control the circuit's operation.

*   If `E = 0` (for active-low enable), the decoder functions normally.
*   If `E = 1`, all outputs are disabled (e.g., all forced to 0 or 1, depending on the design).

This allows us to cascade decoders to build larger ones. For example, two 3-to-8 decoders with an enable input can be used to create a 4-to-16 decoder.

<img src="https://i.imgur.com/uN9Xk9r.png" class="rounded-lg bg-white p-4 w-2/3" alt="4-to-16 Decoder from two 3-to-8 Decoders">

---

## Encoders

An **encoder** performs the inverse operation of a decoder.

*   It has **2ⁿ** (or fewer) input lines and *n* output lines.
*   It converts a single active input line into its corresponding binary code on the output lines.
*   It is assumed that only **one** input line is active at a time.

### Octal-to-Binary Encoder (8-to-3)

| D₇ | D₆ | D₅ | D₄ | D₃ | D₂ | D₁ | D₀ | x | y | z |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:-:|:-:|:-:|
| 0  | 0  | 0  | 0  | 0  | 0  | 0  | **1**| 0 | 0 | 0 |
| 0  | 0  | 0  | 0  | 0  | 0  | **1**| 0  | 0 | 0 | 1 |
| 0  | 0  | 0  | 0  | 0  | **1**| 0  | 0  | 0 | 1 | 0 |
| ...|... |... |... |... |... |... |... |...|...|...|
| **1**| 0  | 0  | 0  | 0  | 0  | 0  | 0  | 1 | 1 | 1 |

The logic is simple: `x = D₄+D₅+D₆+D₇`, `y = D₂+D₃+D₆+D₇`, `z = D₁+D₃+D₅+D₇`.

---

## Priority Encoders

What happens if more than one input to a simple encoder is active? The output is undefined or incorrect.

A **priority encoder** solves this by establishing an importance level (priority) for the inputs.

*   If multiple inputs are active, the encoder outputs the binary code corresponding to the input with the **highest priority**.
*   They also usually include a "Valid" output (`V`) to indicate if any input is active.

### 4-to-2 Priority Encoder (D₃ is highest priority)

| D₃ | D₂ | D₁ | D₀ | x | y | V |
|:--:|:--:|:--:|:--:|:-:|:-:|:-:|
| 0  | 0  | 0  | 0  | x | x | 0 |
| 0  | 0  | 0  | 1  | 0 | 0 | 1 |
| 0  | 0  | 1  | x  | 0 | 1 | 1 |
| 0  | 1  | x  | x  | 1 | 0 | 1 |
| 1  | x  | x  | x  | 1 | 1 | 1 |

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