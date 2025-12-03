---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 4 - Number Representation & Arithmetic Circuits
---

# Lecture 4: Number Representation & Arithmetic Circuits
{{ $slidev.configs.subject }}

<div class="abs-br m-6 flex items-center">
  <span class="text-xs">ELECTRICAL Engineering KMITNB</span>
</div>

---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---
layout: two-cols-header
---

## Numbers Systems (Unsigned)

:: left ::

- **Binary (Base-2):** Uses only two digits, **0** and **1**. Each digit is a **bit**. A group of 8 bits is a **byte**.

- **Octal (Base-8):** Uses digits **0-7**. It's a compact way to represent binary numbers, as one octal digit represents 3 bits (e.g., $(7)₈ = (111)₂$).
- **Hexadecimal (Base-16):** Uses digits **0-9** and letters **A-F**. It is the most common for representing binary in a readable format, as one hex digit represents 4 bits (e.g., $(F)₁₆ = (1111)₂$).



:: right ::

<Transform scale="0.9">

$$
\begin{array}{c|c|c|c}
\textbf{Decimal} & \textbf{Binary} & \textbf{Octal} & \textbf{Hexadecimal} \\
\hline
00 & 00000 & 00 & 00 \\
01 & 00001 & 01 & 01 \\
02 & 00010 & 02 & 02 \\
03 & 00011 & 03 & 03 \\
04 & 00100 & 04 & 04 \\
05 & 00101 & 05 & 05 \\
06 & 00110 & 06 & 06 \\
07 & 00111 & 07 & 07 \\
08 & 01000 & 10 & 08 \\
09 & 01001 & 11 & 09 \\
10 & 01010 & 12 & 0A \\
11 & 01011 & 13 & 0B \\
12 & 01100 & 14 & 0C \\
13 & 01101 & 15 & 0D \\
14 & 01110 & 16 & 0E \\
15 & 01111 & 17 & 0F \\
16 & 10000 & 20 & 10 \\
\end{array}
$$

</Transform>
---

## Signed Number Systems

*   **Differences in negative numbers**
    *   Three major schemes:
        *   Sign Magnitude
        *   One's Complement
        *   Two's Complement
*   **Assumptions:**
    *   We'll assume a 4-bit machine word.
    *   16 different values can be represented.
    *   Roughly half are positive, half are negative.

---
layout: two-cols-header
---

## Sign Magnitude 

:: left ::

*   **Representation:** The most significant bit (MSB) is the sign (0 for positive, 1 for negative). The remaining bits represent the magnitude.
*   **Range:** For n bits, the range is $\pm(2^{(n-1)} - 1)$.
*   **Zero:** Has two representations for zero: `0000` (+0) and `1000` (-0).

*   **Arithmetic:** Complex, as it requires comparing signs and magnitudes.

:: right ::

<Transform scale="0.9">

$$
\begin{array}{c|c}
\textbf{Decimal} & \textbf{Sign Magnitude} \\
\hline
+7 & 0111 \\
+6 & 0110 \\
+5 & 0101 \\
+4 & 0100 \\
+3 & 0011 \\
+2 & 0010 \\
+1 & 0001 \\
+0 & 0000 \\
-0 & 1000 \\
-1 & 1001 \\
-2 & 1010 \\
-3 & 1011 \\
-4 & 1100 \\
-5 & 1101 \\
-6 & 1110 \\
-7 & 1111 \\
\end{array}
$$

</Transform>

---
layout: two-cols-header
---

## One's Complement

:: left ::

*   **Representation:** Positive numbers are represented the same way as in sign magnitude. Negative numbers are obtained by inverting all the bits of the corresponding positive number.
*   **Example:** For +5 (`0101`), -5 is `1010`.
*   **Zero:** Also has two representations for zero: `0000` (+0) and `1111` (-0).

*   **Arithmetic:** Simpler than sign magnitude, but addition may require an "end-around carry" (adding the carry-out from the MSB back to the result).

:: right ::

<Transform scale="0.9">

$$
\begin{array}{c|c|c}
\textbf{Decimal} & \textbf{Sign Mag.} & \textbf{One's Comp.} \\
\hline
+7 & 0111 & 0111 \\
+6 & 0110 & 0110 \\
+5 & 0101 & 0101 \\
+4 & 0100 & 0100 \\
+3 & 0011 & 0011 \\
+2 & 0010 & 0010 \\
+1 & 0001 & 0001 \\
+0 & 0000 & 0000 \\
-0 & 1000 & 1111 \\
-1 & 1001 & 1110 \\
-2 & 1010 & 1101 \\
-3 & 1011 & 1100 \\
-4 & 1100 & 1011 \\
-5 & 1101 & 1010 \\
-6 & 1110 & 1001 \\
-7 & 1111 & 1000 \\
\end{array}
$$

</Transform>

---
layout: two-cols-header
---

## Two's Complement

:: left ::

*   **Representation:** Positive numbers are the same as sign magnitude. To get a negative number, take the two's complement of its positive counterpart.
*   **Negation (Invert and Add 1):**
    1.  Invert all the bits.
    2.  Add 1 to the result.
    *   *Example: To get -5, start with +5 (`0101`), invert it (`1010`), and add 1 (`1011`).*
*   **Range:** Asymmetric. For n bits, the range is from $-2^{(n-1)}$ to $2^{(n-1)} - 1$.
*   **Zero:** Only one representation: `0000`.
*   **Arithmetic:** Simple. Subtraction is performed by adding the two's complement of the subtrahend.

:: right ::


<Transform scale="0.9">

$$
\begin{array}{c|c|c}
\textbf{Decimal} & \textbf{One's Comp.} & \textbf{Two's Comp.} \\
\hline
+7 & 0111 & 0111 \\
+6 & 0110 & 0110 \\
+5 & 0101 & 0101 \\
+4 & 0100 & 0100 \\
+3 & 0011 & 0011 \\
+2 & 0010 & 0010 \\
+1 & 0001 & 0001 \\
+0 & 0000 & 0000 \\
-1 & 1110 & 1111 \\
-2 & 1101 & 1110 \\
-3 & 1100 & 1101 \\
-4 & 1011 & 1100 \\
-5 & 1010 & 1011 \\
-6 & 1001 & 1010 \\
-7 & 1000 & 1001 \\
-8 & \text{---} & 1000 \\
\end{array}
$$

</Transform>


---

## Arithmetic

Let's calculate **`4 + (-3) = 1`**. In binary, `+4` is `0100`.

<div class="grid grid-cols-3 gap-4">
<div>

### Sign Magnitude

`-3` is `1011`

1.  **Check Signs:** Different.
2.  **Compare Magnitudes:** `|4| > |-3|`.
3.  **Subtract Magnitudes:** `0100 - 0011 = 0001`.
4.  **Determine Sign:** Result is positive (sign of 4).

**Result:** `0001` (+1)

</div>
<div>

### One's Complement

`-3` is `1100`

1.  **Add:** `0100 + 1100 = 1 0000`.
2.  **End-Around Carry:** A carry-out occurred, so add it back to the result.
    `0000 + 1 = 0001`.

**Result:** `0001` (+1)

</div>
<div>

### Two's Complement

`-3` is `1101`

1.  **Add:** `0100 + 1101 = 1 0001`.
2.  **Discard Carry:** Simply discard the carry-out.

**Result:** `0001` (+1)

⭐️**Advantage:** A single, simple adder circuit handles both addition and subtraction. **This is why it's used everywhere.**

</div>
</div>

---
layout: two-cols
---

## Overflow

*   The result of addition or subtraction is supposed to fit within the significant bits used to represent the numbers.
*   If *n* bits are used for signed numbers, the result must be in the range $-2^{(n-1)}$ to $+2^{(n-1)} - 1$.
*   If the result does not fit in this range, we say that **arithmetic overflow** has occurred.
*   It is important to be able to detect the occurrence of overflow to ensure the correct operation of an arithmetic circuit.

:: right ::

### Arithmetic Overflow Detection

For 4-bit numbers, there are 3 significant bits and the sign bit.

*   `(+7) + (+2) = +9` &rarr; `0111 + 0010 = 1001` (Incorrect, looks like -7)
    *   $c_4=0$, $c_3=1$ &rarr; **Overflow**
*   `(-7) + (-2) = -9` &rarr; `1001 + 1110 = 10111` (Incorrect, looks like +7)
    *   $c_4=1$, $c_3=0$ &rarr; **Overflow**

**Rule:** Overflow occurs if the carry into the sign bit ($c_{n-1}$) is not equal to the carry out of the sign bit ($c_n$).
- $\text{overflow} = c_{n-1} \oplus c_n$

*If the numbers have different signs, no overflow can occur.*

---
layout: two-cols-header
---

## Half-Adder

To perform binary addition in hardware, we start with the most basic component: the **Half-Adder**. It's a combinational circuit that adds two single bits (A and B).

::left::

#### Truth Table & Logic Equation

The behavior of the Half-Adder is defined by its truth table.

$$
\begin{array}{cc|cc}
\textbf{A} & \textbf{B} & \textbf{Carry} & \textbf{Sum} \\
\hline
0 & 0 & 0 & 0 \\
0 & 1 & 0 & 1 \\
1 & 0 & 0 & 1 \\
1 & 1 & 1 & 0 \\
\end{array}
$$

From the truth table, we can derive the logic equations:
*   $\text{Sum (S)} = A ⊕ B$
*   $\text{Carry (C)} = A ⋅ B$

::right::

#### Logic Circuit



This is implemented with one XOR gate and one AND gate.

<img src="/half_adder.svg" class="h-40 mt-4" alt="Half Adder Circuit"/>

---
layout: two-cols-header
---

## Full-Adder

A **Full Adder** is a combinational circuit that adds three bits: two input bits (A, B) and a carry-in ($C_{in}$). This allows them to be chained together to add multi-bit numbers.

::left::

#### Truth Table & Logic

$$
\begin{array}{ccc|cc}
\textbf{A} & \textbf{B} & \textbf{C}_\text{in} & \textbf{C}_\text{out} & \textbf{Sum} \\
\hline
0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 1 \\
0 & 1 & 0 & 0 & 1 \\
0 & 1 & 1 & 1 & 0 \\
1 & 0 & 0 & 0 & 1 \\
1 & 0 & 1 & 1 & 0 \\
1 & 1 & 0 & 1 & 0 \\
1 & 1 & 1 & 1 & 1 \\
\end{array}
$$

*   $\text{Sum} = A \oplus B \oplus C_\text{in}$
*   $C_\text{out} = (A \cdot B) + (C_\text{in} \cdot (A \oplus B))$

::right::

#### Implementation
<div class="text-sm">
A full-adder can be constructed from two half-adders and an OR gate.

<img src="/full_adder.svg" class="pt-4 w-100 mx-auto" alt="Full Adder Circuit"/>
<img src="/full_adder_from_ha.svg" class="pt-4 w-90 mx-auto pt-5" alt="HA"/>

</div>

---
layout: two-cols
---

### VHDL Implementation of Full Adder
<div class="pr-2">

The design requires two `VHDL` files or entities: **half_adder** (the component) and **full_adder_struct** (the structural design).

**half_adder.vhd**
```vhdl {*}{maxHeight:'380px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY half_adder IS
    PORT ( 
        X, Y : IN  STD_LOGIC;
        S, C : OUT STD_LOGIC 
    );
END ENTITY half_adder;

ARCHITECTURE dataflow OF half_adder IS
BEGIN
    S <= X XOR Y;
    C <= X AND Y;
END ARCHITECTURE dataflow;
```

</div>

:: right ::
**full_adder_struct.vhd**

This file connects two instances of the `half_adder` and one `OR` operation.
```vhdl {*}{maxHeight:'345px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Full Adder Interface
---------------------------------------------------------------------
ENTITY full_adder_struct IS
    PORT (
        A, B, Cin : IN  STD_LOGIC;  -- Three inputs
        S, Cout   : OUT STD_LOGIC   -- Two outputs
    );
END ENTITY full_adder_struct;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation
---------------------------------------------------------------------
ARCHITECTURE structural OF full_adder_struct IS

    -- 1. Declare the component used (Half Adder)
    COMPONENT half_adder
        PORT ( 
            X, Y : IN  STD_LOGIC;
            S, C : OUT STD_LOGIC 
        );
    END COMPONENT;

    -- 2. Define internal signals to connect the components
    SIGNAL S1, C1, C2 : STD_LOGIC; 
    -- S1: Sum from HA1 (A XOR B)
    -- C1: Carry from HA1 (A AND B)
    -- C2: Carry from HA2 ((A XOR B) AND Cin)

BEGIN

    -- 3. Component Instantiation 1 (HA1)
    HA_1: half_adder
        PORT MAP (
            X => A,
            Y => B,
            S => S1, -- Output S1 feeds into HA2
            C => C1  -- Output C1 feeds into the final OR gate
        );

    -- 4. Component Instantiation 2 (HA2)
    HA_2: half_adder
        PORT MAP (
            X => S1,  -- Input X is the sum from HA1
            Y => Cin, -- Input Y is the Carry-in
            S => S,   -- Output S is the final Sum of the Full Adder
            C => C2   -- Output C2 feeds into the final OR gate
        );

    -- 5. Final OR Gate (The Sum of the carries C1 and C2)
    -- Cout = C1 OR C2
    Cout <= C1 OR C2;

END ARCHITECTURE structural;
```

---
layout: two-cols-header
---

## Ripple-Carry Adder

To add multi-bit numbers, we can cascade full-adders. The carry-out ($C_{out}$) from one stage "ripples" to become the carry-in ($C_{in}$) of the next stage.

:: left ::

*   This creates a **4-bit ripple-carry adder**.
*   The initial carry-in, $C_0$, is typically set to 0 for standard addition.

*   The main drawback is the delay; the sum bit $S_3$ is not valid until the carry has propagated through all previous stages.
:: right ::
<img src="/ripple_adder.svg" class="w-100 mx-auto" alt="4-bit Ripple-Carry Adder"/>



---


### VHDL Implementation of Ripple-Carry Adder

The following code defines the 4-bit adder, receives two 4-bit vectors ($A$ and $B$) and a carry-in ($C_{in}$), and outputs the 4-bit sum ($S$) and the final carry-out ($C_{out}$).


```vhdl {*}{maxHeight:'345px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: 4-bit Ripple Adder Interface
---------------------------------------------------------------------
ENTITY ripple_adder_4bit IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Two 4-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (MSB)
    );
END ENTITY ripple_adder_4bit;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation
---------------------------------------------------------------------
ARCHITECTURE structural OF ripple_adder_4bit IS

    -- 1. Declare the Full Adder Component
    COMPONENT full_adder
        PORT (
            A, B, Cin : IN  STD_LOGIC;
            S, Cout   : OUT STD_LOGIC
        );
    END COMPONENT;

    -- 2. Define Internal Signals for the Carry Chain
    -- We need 3 internal carry signals (C1, C2, C3) to link the 4 FAs.
    -- Cin from the entity is C0. Cout from the last FA is Cout of the entity.
    SIGNAL C_internal : STD_LOGIC_VECTOR(3 DOWNTO 1); 

BEGIN

    -- FA0: LSB (Bit 0)
    -- Inputs: A(0), B(0), Entity Cin
    -- Outputs: S(0), Internal Carry C_internal(1)
    FA_0: full_adder
        PORT MAP (
            A   => A(0),
            B   => B(0),
            Cin => Cin,
            S   => S(0),
            Cout => C_internal(1) -- C1
        );

    -- FA1: Bit 1
    -- Inputs: A(1), B(1), Carry from FA0 (C_internal(1))
    -- Outputs: S(1), Internal Carry C_internal(2)
    FA_1: full_adder
        PORT MAP (
            A   => A(1),
            B   => B(1),
            Cin => C_internal(1),
            S   => S(1),
            Cout => C_internal(2) -- C2
        );

    -- FA2: Bit 2
    -- Inputs: A(2), B(2), Carry from FA1 (C_internal(2))
    -- Outputs: S(2), Internal Carry C_internal(3)
    FA_2: full_adder
        PORT MAP (
            A   => A(2),
            B   => B(2),
            Cin => C_internal(2),
            S   => S(2),
            Cout => C_internal(3) -- C3
        );

    -- FA3: MSB (Bit 3)
    -- Inputs: A(3), B(3), Carry from FA2 (C_internal(3))
    -- Outputs: S(3), Entity Cout
    FA_3: full_adder
        PORT MAP (
            A   => A(3),
            B   => B(3),
            Cin => C_internal(3),
            S   => S(3),
            Cout => Cout -- Final Cout of the 4-bit adder
        );

END ARCHITECTURE structural;
```

---
layout: two-cols-header
---

## Adder/Subtractor Circuit

::left::

A single circuit can perform both addition and subtraction using two's complement arithmetic.

$A - B = A + (-B) = A + B' + 1$

*   An $\overline{\text{Add}}/\text{Sub}$ control signal is used.
*   When $\overline{\text{Add}}/\text{Sub} = 0$ (for addition), B passes through the XOR gates unchanged and the initial carry-in is 0. The circuit performs $A + B$.
*   When $\overline{\text{Add}}/\text{Sub} = 1$ (for subtraction), the XOR gates invert each bit of B, and the initial carry-in is 1. The circuit performs $A + B' + 1$.
*   An XOR gate can be used as a controlled inverter for each bit of B.

::right::

<img src="/adder_subtractor.svg" class="w-120 mx-auto" alt="Adder/Subtractor Circuit"/>

---
layout: two-cols-header
---

## Carry Lookahead Adder

The critical path (worst-case delay) in a ripple-carry adder occurs when a carry signal must propagate, or "ripple," through every full-adder in the chain.
:: left ::
*   **Example:** `1111 + 0001`. The carry generated by the first stage must travel all the way to the last stage.
*   For an n-bit adder, the total delay is proportional to *n*. For a 16-bit adder, this could be **32 gate delays** or more.
*   This linear scaling of delay is unacceptable for modern high-speed processors.

:: right ::
<div class="p-1">

* A **Carry Lookahead Adder (CLA)** solves this by computing all the carry signals in parallel, directly from the input bits. This breaks the dependency chain and makes the adder significantly faster.

<img src="" class="w-120 mx-auto" alt="Carry Lookahead Adder Block Diagram"/>

</div>
---
layout: two-cols-header
---

### Carry Lookahead Logic
:: left ::
Sum and Carry can be re-expressed in terms of **generate/propagate**:

*   **Carry Generate $\bm{(G_i) = A_i ⋅ B_i}$**
    *   A carry is generated when both $A_i$ and $B_i$ are 1.
*   **Carry Propagate $\bm{(P_i) = A_i ⊕ B_i}$**
    *   A carry-in will be propagated to the carry-out.

The equations become:
*   $S_i = P_i ⊕ C_i$
*   $C_{i+1} = G_i + P_i ⋅ C_i$

:: right ::

We can re-express the carry logic to depend only on the inputs (A, B) and the initial carry `C0`.

*   $C_1 = G_0 + P_0⋅C_0$
*   $C_2 = G_1 + P_1⋅C_1 \\ C_2 = G_1 + P_1⋅G_0 + P_1⋅P_0⋅C_0$
*   $C_3 = G_2 + P_2⋅C_2 \\ C_3 = G_2 + P_2⋅G_1 + P_2⋅P_1⋅G_0 + P_2⋅P_1⋅P_0⋅C_0$
*   $C_4 = G_3 + P_3⋅C_3 \\ C_4 = G_3 + P_3⋅G_2 + P_3⋅P_2⋅G_1 + P_3⋅P_2⋅P_1⋅G_0 + P_3⋅P_2⋅P_1⋅P_0⋅C_0$

Each of these carry equations can be implemented in a two-level logic network.

---
layout: two-cols
---

### Hierarchical Carry Lookahead

A single-level carry-lookahead unit for a large adder (e.g., 16-bit) is impractical due to the massive fan-in required for the gates. The solution is a **hierarchical** or **cascaded** approach. We can build a 16-bit adder by connecting four 4-bit CLA adders.

A second-level Carry Lookahead Unit computes carries *between* the blocks. It uses "super" Propagate ($P^*$) and Generate ($G^*$) signals from each 4-bit block.


::right::

<div class="text-center">

**16-bit Adder with Cascaded CLAs**

<img src="" class="w-110 mx-auto" alt="Placeholder: 16-bit Cascaded Carry Lookahead Adder diagram"/>

<p class="text-sm mt-2">A second-level CLA unit uses the P* and G* signals from each 4-bit block to generate the carries between them ($C_4, C_8, C_{12}$) in parallel.</p>

</div>

---
layout: default
---

### Delay Analysis: Ripple vs. Hierarchical CLA

Let's compare a 16-bit adder, assuming 1 gate delay is `t`.

*   **16-bit Ripple-Carry Adder:**
    *   The carry must ripple through 15 full adders after the first. Each FA has a 2-gate delay for carry.
    *   Total Delay for $C_{16}$: $\approx 16 \times 2t = \textbf{32t}$.

*   **16-bit Hierarchical CLA (Two Levels):**
    1.  **1t:** Calculate all $P_i$ and $G_i$ signals in parallel.
    2.  **2t:** Calculate block $P^*$ and $G^*$ signals for all blocks.
    3.  **2t:** The second-level CLA calculates the block carries ($C_4, C_8, C_{12}$).
    4.  **2t:** The carries *within* each block (e.g., $C_1, C_2, C_3$) are calculated.
    5.  **1t:** The final sum bits ($S_i = P_i \oplus C_i$) are calculated.
    *   Total Delay for the final sum bit: $1t+2t+2t+2t+1t = \textbf{8t}$.

The hierarchical CLA is significantly faster, showing a **4x improvement** in this case.

---
layout: two-cols-header
---

## Multiplication
:: left ::
**Basic Concept:** Multiplication is a process of adding partial products.

```
  1101  (13)  (Multiplicand)
* 1011  (11)  (Multiplier)
-------
  1101  (Partial Product 0)
 1101   (Partial Product 1)
0000    (Partial Product 2)
1101     (Partial Product 3)
--------
10001111 (143) (Product)
```

The product of two 4-bit numbers is an 8-bit number.

:: right ::

### Combinational Multiplier

A combinational multiplier can be built using an array of AND gates to form the partial products and an array of adders to sum them up.

*   The partial products are `Ai ⋅ Bj`.
*   These products are then added together, shifted according to their bit position.
*   This can be implemented with an array of full adders and half adders.
*   For a 4x4 multiplier:
    *   16 AND gates to form partial products.
    *   12 adders (a mix of HA and FA) to sum them.

---

## Other Number Representations

*   **Fixed-point:** Allows for fractional representation by assuming a fixed position for the radix point.
*   **Floating-point:** Allows for high precision, very large, and/or very small numbers using a mantissa and an exponent.
*   **Binary-Coded Decimal (BCD):** Encodes each decimal digit with 4 bits.
*   **ASCII:** Represents characters (letters, numbers, symbols) as numbers.

---
layout: two-cols-header
---

## Floating-Point Numbers (IEEE 754 Single Precision)

:: left ::

A 32-bit format for floating-point values.

*   **Sign (S):** 1 bit (0 for positive, 1 for negative).
*   **Exponent (E):** 8 bits (excess-127 format).
    *   True exponent = E - 127.
*   **Mantissa (M):** 23 bits.

**Value = (-1)^S × (1.M) × 2^(E-127)**

The standard calls for a normalized mantissa, where the most significant bit is always 1. This "hidden bit" is not stored, providing an extra bit of precision.

:: right ::

**Convert (3.5)₁₀ to IEEE 754 single precision.**

1.  Convert to binary: `3.5 = 11.1₂`
2.  Normalize: `11.1₂ = 1.11₂ × 2¹`
3.  **Sign (S):** 0 (positive)
4.  **Exponent (E):** True exponent is 1. `E = 1 + 127 = 128`. In binary, `128 = 10000000₂`.
5.  **Mantissa (M):** The fractional part is `.11`. We pad with zeros to 23 bits: `11000000000000000000000`.

**Result:**
`0 10000000 11000000000000000000000`

---

## Binary-Coded-Decimal (BCD)

*   Represents decimal numbers by encoding each decimal digit in a 4-bit binary form.
*   Uses 4 bits per digit, for digits 0-9.
    *   `0 = 0000`, `1 = 0001`, ..., `9 = 1001`.
    *   The binary codes `1010` through `1111` are unused.
*   **Example:** `(78)₁₀ = (0111 1000)BCD`
*   Convenient for applications that interface with humans, like calculators or digital clocks, as it simplifies displaying numbers.