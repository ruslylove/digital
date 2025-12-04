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



To represent both positive and negative values in binary, we need a system to encode the sign. The most common approach is to use the **Most Significant Bit (MSB)** as a **sign bit**.

*   An MSB of **0** indicates a **positive** number.
*   An MSB of **1** indicates a **negative** number.

There are three primary schemes for this, each with different ways of handling negative values:

1.  **Sign-Magnitude**
2.  **One's Complement**
3.  **Two's Complement**


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

## Two's Complement

<div class="grid grid-cols-2 gap-4">
<div>

*   **Representation:** Positive numbers are the same as sign magnitude. To get a negative number, take the two's complement of its positive counterpart.
*   **Negation (Invert and Add 1):**
    1.  Invert all the bits.
    2.  Add 1 to the result.
    *   *Example: To get -5, start with +5 (`0101`), invert it (`1010`), and add 1 (`1011`).*
*   **Range:** Asymmetric. For n bits, the range is from $-2^{(n-1)}$ to $2^{(n-1)} - 1$.
*   **Zero:** Only one representation: `0000`.
*   **Arithmetic:** Simple. Subtraction is performed by adding the two's complement of the subtrahend.

</div>

<Transform scale="0.92">

$$
\begin{array}{c|c|c|c}
\textbf{Dec} & \textbf{Signed Mg.} & \textbf{1's Comp.} & \textbf{2's Comp.} \\
\hline
+7 & 0111 & 0111 & 0111 \\
+6 & 0110 & 0110 & 0110 \\
+5 & 0101 & 0101 & 0101 \\
+4 & 0100 & 0100 & 0100 \\
+3 & 0011 & 0011 & 0011 \\
+2 & 0010 & 0010 & 0010 \\
+1 & 0001 & 0001 & 0001 \\
+0 & 0000 & 0000 & 0000 \\
-0 & 1000 & 1111 & \text{---} \\
-1 & 1001 & 1110 & 1111 \\
-2 & 1010 & 1101 & 1110 \\
-3 & 1011 & 1100 & 1101 \\
-4 & 1100 & 1011 & 1100 \\
-5 & 1101 & 1010 & 1011 \\
-6 & 1110 & 1001 & 1010 \\
-7 & 1111 & 1000 & 1001 \\
-8 & \text{---} & \text{---} & 1000 \\
\end{array}
$$

</Transform>

</div>
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

### Overflow Detection

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
<img src="/full_adder_from_ha.svg" class="pt-4 w-100 mx-auto pt-5" alt="HA"/>

</div>

---
layout: two-cols
---

### VHDL Implementation of Full Adder
<div class="pr-2">

The design requires two `VHDL` files or entities: **half_adder** (the component) and **full_adder** (the structural design).

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
**full_adder.vhd**

This file connects two instances of the `half_adder` and one `OR` operation.
```vhdl {*}{maxHeight:'345px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Full Adder Interface
---------------------------------------------------------------------
ENTITY full_adder IS
    PORT (
        A, B, Cin : IN  STD_LOGIC;  -- Three inputs
        S, Cout   : OUT STD_LOGIC   -- Two outputs
    );
END ENTITY full_adder;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation
---------------------------------------------------------------------
ARCHITECTURE structural OF full_adder IS

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

### VHDL Implementation

**adder_subtractor_4bit.vhd**
```vhdl {*}{maxHeight:'360px',lines:true}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

-- Top-Level Entity
entity adder_subtractor_4bit is
    port (
        A       : in  std_logic_vector(3 downto 0); -- Input operand A
        B       : in  std_logic_vector(3 downto 0); -- Input operand B
        add_sub : in  std_logic;                    -- Mode control: '0' = Add, '1' = Subtract
        S       : out std_logic_vector(3 downto 0); -- Sum / Difference output
        Cout    : out std_logic                     -- Carry out / Borrow out
    );
end entity adder_subtractor_4bit;

architecture structural of adder_subtractor_4bit is

    -- 1. Component Declaration (Matches ripple_adder_4bit port list)
    component ripple_adder_4bit
        port (
            A       : in  std_logic_vector(3 downto 0);
            B       : in  std_logic_vector(3 downto 0);
            Cin     : in  std_logic;
            S       : out std_logic_vector(3 downto 0);
            Cout    : out std_logic
        );
    end component;

    -- 2. Internal Signals
    -- Signal to hold the modified B input (B XOR add_sub)
    signal B_comp : std_logic_vector(3 downto 0);

begin
    -- ** Logic for Subtraction (2's Complement) **
    
    -- 1. Bitwise XOR Operation (Equivalent to 4 XOR gates)
    -- add_sub='0' -> B_comp = B (Addition)
    -- add_sub='1' -> B_comp = not B (1's Complement)
    B_comp <= B xor (add_sub & add_sub & add_sub & add_sub); 

    -- ** Component Instantiation **
    
    -- 2. Instantiate the 4-bit Ripple Adder
    Adder_Instance : ripple_adder_4bit
        port map (
            A    => A,
            B    => B_comp,        -- Connect the (possibly inverted) B
            Cin  => add_sub,       -- Connect 'add_sub' to Carry_in (for the +1 in 2's complement)
            S    => S,             -- Connect the adder's sum output to the main output
            Cout => Cout           -- Connect the adder's carry-out to the main output
        );

end architecture structural;
```

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

<img src="/cla_4bit.svg" class="w-120 mx-auto pt-4" alt="Carry Lookahead Adder Block Diagram"/>

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

### VHDL Implementation

<div class="grid grid-cols-2 gap-4">
<div>

**1. Propagate and Generate Logic Unit (pg_unit.vhd)**
```vhdl{*}{lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pg_unit IS
    PORT (
        A, B : IN  STD_LOGIC;
        P_out, G_out : OUT STD_LOGIC
    );
END ENTITY pg_unit;

ARCHITECTURE dataflow OF pg_unit IS
BEGIN
    -- G_out: Generate signal (G = A AND B)
    G_out <= A AND B;
    
    -- P_out: Propagate signal (P = A XOR B)
    P_out <= A XOR B;
END ARCHITECTURE dataflow;
```
</div>
<div>

**2. Carry Lookahead Logic Block (cla_logic.vhd)**


```vhdl {*}{maxHeight:'365px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_logic IS
    PORT (
        P_in, G_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P and G vectors (P0-P3, G0-G3)
        C0         : IN  STD_LOGIC;                    -- Global Carry-in
        C_out      : OUT STD_LOGIC_VECTOR(4 DOWNTO 1)  -- Calculated Carries (C1-C4)
    );
END ENTITY cla_logic;

ARCHITECTURE dataflow OF cla_logic IS
BEGIN
    -- C1 = G0 + P0 * C0
    C_out(1) <= G_in(0) OR (P_in(0) AND C0);
    
    -- C2 = G1 + P1*G0 + P1*P0*C0
    C_out(2) <= G_in(1) OR (P_in(1) AND G_in(0)) OR (P_in(1) AND P_in(0) AND C0);

    -- C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*C0
    C_out(3) <= G_in(2) OR (P_in(2) AND G_in(1)) OR (P_in(2) AND P_in(1) AND G_in(0)) OR 
                (P_in(2) AND P_in(1) AND P_in(0) AND C0);

    -- C4 = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*C0 (Final Carry-out of the 4-bit block)
    C_out(4) <= G_in(3) OR (P_in(3) AND G_in(2)) OR (P_in(3) AND P_in(2) AND G_in(1)) OR 
                (P_in(3) AND P_in(2) AND P_in(1) AND G_in(0)) OR 
                (P_in(3) AND P_in(2) AND P_in(1) AND P_in(0) AND C0);

END ARCHITECTURE dataflow;
```
</div>
</div>

---

<div class="grid grid-cols-2 gap-4">
<div>

**3. Sum Logic Unit (sum_logic.vhd)**
```vhdl {*}{lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sum_logic IS
    PORT (
        P_in, C_in : IN  STD_LOGIC;
        S_out      : OUT STD_LOGIC
    );
END ENTITY sum_logic;

ARCHITECTURE dataflow OF sum_logic IS
BEGIN
    -- S_out: Sum bit (S = P XOR C)
    S_out <= P_in XOR C_in;
END ARCHITECTURE dataflow;
```
</div>
<div>

**4. Top-Level 4-bit CLA Adder (cla_4bit_adder.vhd)**
```vhdl {*}{maxHeight:'385px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_4bit_adder IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in (C0)
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (C4)
    );
END ENTITY cla_4bit_adder;

ARCHITECTURE structural OF cla_4bit_adder IS

    -- Declare all necessary components
    COMPONENT pg_unit
        PORT ( A, B : IN STD_LOGIC; P_out, G_out : OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT cla_logic
        PORT ( P_in, G_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); C0 : IN STD_LOGIC; C_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 1) );
    END COMPONENT;

    COMPONENT sum_logic
        PORT ( P_in, C_in : IN STD_LOGIC; S_out : OUT STD_LOGIC );
    END COMPONENT;

    -- Internal Signals for P and G vectors
    SIGNAL P_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL G_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Internal Signals for the Carries (C1, C2, C3, C4)
    SIGNAL C_vec : STD_LOGIC_VECTOR(4 DOWNTO 1); 

BEGIN

    -- 1. Generate P and G Signals (4 instances of PG_Unit)
    -- Generates P(i) and G(i) for each bit i=0 to 3
    PG_GEN: FOR i IN 0 TO 3 GENERATE
        PG_I: pg_unit
            PORT MAP (
                A => A(i),
                B => B(i),
                P_out => P_vec(i),
                G_out => G_vec(i)
            );
    END GENERATE;

    -- 2. CLA Logic Block (1 instance)
    -- Calculates all internal carries C1, C2, C3, C4 in parallel
    CLA_BLOCK: cla_logic
        PORT MAP (
            P_in => P_vec,
            G_in => G_vec,
            C0   => Cin,
            C_out => C_vec
        );

    -- Map the final calculated carry C4 to the entity's Cout
    Cout <= C_vec(4);

    -- 3. Sum Logic (4 instances of Sum_Logic)
    -- Calculates the final sum S(i) using P(i) and the calculated carry C(i)
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in => P_vec(i),
                -- Note: The carry input for Sum_Logic(i) is C_vec(i) for i=1 to 3, 
                -- but for i=0, it is the global Cin (C0).
                -- We use the entity input Cin directly for the LSB (i=0).
                C_in => C_vec(i) WHEN i > 0 ELSE Cin,
                S_out => S(i)
            );
    END GENERATE;

END ARCHITECTURE structural;
```
</div>
</div>
---
layout: two-cols
---

### Hierarchical Carry Lookahead

A single-level carry-lookahead unit for a large adder (e.g., 16-bit) is impractical due to the massive fan-in required for the gates. The solution is a **hierarchical** or **cascaded** approach. We can build a 16-bit adder by connecting four 4-bit CLA adders.

A second-level Carry Lookahead Unit computes carries *between* the blocks. It uses "super" Propagate ($P^*$) and Generate ($G^*$) signals from each 4-bit block.
<div class="text-xs">

* $P_0^* = P_3 \cdot P_2 \cdot P_1 \cdot P_0$
* $P_1^* = P_7 \cdot P_6 \cdot P_5 \cdot P_4$
* $P_2^* = P_{11} \cdot P_{10} \cdot P_9 \cdot P_8$
* $P_3^* = P_{15} \cdot P_{14} \cdot P_{13} \cdot P_{12}$
* $G_0^* = G_3 + (P_3 \cdot G_2) + (P_3 \cdot P_2 \cdot G_1) + (P_3 \cdot P_2 \cdot P_1 \cdot G_0)$
* $G_1^* = G_7 + (P_7 \cdot G_6) + (P_7 \cdot P_6 \cdot G_5) + (P_7 \cdot P_6 \cdot P_5 \cdot G_4)$
* $G_2^* = G_{11} + (P_{11} \cdot G_{10}) + (P_{11} \cdot P_{10} \cdot G_9) + (P_{11} \cdot P_{10} \cdot P_9 \cdot G_8)$
* $G_3^* = G_{15} + (P_{15} \cdot G_{14}) + (P_{15} \cdot P_{14} \cdot G_{13}) + (P_{15} \cdot P_{14} \cdot P_{13} \cdot G_{12})$
</div>

::right::

<div class="p-4">

**16-bit Adder with Cascaded CLAs**

<img src="/16bit_cla.jpg" class="w-110 mx-auto" alt="Placeholder: 16-bit Cascaded Carry Lookahead Adder diagram"/>

<div class="text-sm mt-2">A second-level CLA unit uses the P* and G* signals from each 4-bit block to generate the carries between them ($C_4, C_8, C_{12}$) in parallel.</div>

<div class="text-xs mt-2">

* $c_4 = G_0^* + P_0^* \cdot c_0$
* $c_8 = G_1^* + P_1^* \cdot G_0^* + P_1^* \cdot P_0^* \cdot c_0$
* $c_{12} = G_2^* + P_2^* \cdot G_1^* + P_2^* \cdot P_1^* \cdot G_0^* + P_2^* \cdot P_1^* \cdot P_0^* \cdot c_0$

</div>


</div>

---

### VHDL Implementation
This code relies on the three component files defined previously (**pg_unit.vhd**, **cla_logic.vhd**, and **sum_logic.vhd**).

**1. cla_4bit_block.vhd (The 4-bit Building Block)**

```vhdl {*}{maxHeight:'320px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_4bit_block IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin     : IN  STD_LOGIC;
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Pg_out  : OUT STD_LOGIC; -- Group Propagate (P^G)
        Gg_out  : OUT STD_LOGIC; -- Group Generate (G^G)
        Cout    : OUT STD_LOGIC  -- Local Cout (C4)
    );
END ENTITY cla_4bit_block;

ARCHITECTURE structural OF cla_4bit_block IS

    -- Component Declarations (Assuming these are defined externally)
    COMPONENT pg_unit PORT ( A, B : IN STD_LOGIC; P_out, G_out : OUT STD_LOGIC ); END COMPONENT;
    COMPONENT cla_logic PORT ( P_in, G_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); C0 : IN STD_LOGIC; C_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 1) ); END COMPONENT;
    COMPONENT sum_logic PORT ( P_in, C_in : IN STD_LOGIC; S_out : OUT STD_LOGIC ); END COMPONENT;

    -- Internal Signals
    SIGNAL P_vec, G_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C_local : STD_LOGIC_VECTOR(4 DOWNTO 1); -- C1, C2, C3, C4

BEGIN

    -- 1. Instantiate 4x P/G Units
    PG_GEN: FOR i IN 0 TO 3 GENERATE
        PG_I: pg_unit PORT MAP (A => A(i), B => B(i), P_out => P_vec(i), G_out => G_vec(i));
    END GENERATE;

    -- 2. Instantiate 1x Local CLA Logic
    CLA_LOCAL: cla_logic
        PORT MAP (
            P_in  => P_vec,
            G_in  => G_vec,
            C0    => Cin,
            C_out => C_local
        );

    -- 3. Calculate Group Signals (P^G and G^G)
    
    -- P^G = P3 AND P2 AND P1 AND P0
    Pg_out <= P_vec(3) AND P_vec(2) AND P_vec(1) AND P_vec(0); 

    -- G^G: This logic is identical to C4 in cla_logic, but without the C0 term.
    Gg_out <= G_vec(3) OR (P_vec(3) AND G_vec(2)) OR (P_vec(3) AND P_vec(2) AND G_vec(1)) OR 
              (P_vec(3) AND P_vec(2) AND P_vec(1) AND G_vec(0));


    -- 4. Instantiate 4x Sum Logic Units
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in  => P_vec(i),
                -- Cin for bit 0 is the block's Cin; Cin for bits 1-3 is C_local(i)
                C_in  => C_local(i) WHEN i > 0 ELSE Cin,
                S_out => S(i)
            );
    END GENERATE;
    
    -- 5. Map Local Cout
    Cout <= C_local(4);

END ARCHITECTURE structural;
```


---
layout: two-cols
---

**2. gcla_logic.vhd (Global Carry Lookahead)**

* This block calculates the block-level carries ($C_4, C_8, C_{12}, C_{16}$)

<div class="p-4">

```vhdl{*}{maxHeight:'335px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY gcla_logic IS
    PORT (
        Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G and G^G vectors
        C0           : IN  STD_LOGIC;                    -- Global Cin
        C_block_out  : OUT STD_LOGIC_VECTOR(4 DOWNTO 1)  -- Block Carries (C4, C8, C12, C16)
    );
END ENTITY gcla_logic;

ARCHITECTURE dataflow OF gcla_logic IS
BEGIN
    -- C4 (Block 1 Cin) = Gg0 + Pg0 * C0
    C_block_out(1) <= Gg_in(0) OR (Pg_in(0) AND C0);
    
    -- C8 (Block 2 Cin) = Gg1 + Pg1*Gg0 + Pg1*Pg0*C0
    C_block_out(2) <= Gg_in(1) OR (Pg_in(1) AND Gg_in(0)) OR (Pg_in(1) AND Pg_in(0) AND C0);

    -- C12 (Block 3 Cin) = Gg2 + Pg2*Gg1 + Pg2*Pg1*Gg0 + Pg2*Pg1*Pg0*C0
    C_block_out(3) <= Gg_in(2) OR (Pg_in(2) AND Gg_in(1)) OR (Pg_in(2) AND Pg_in(1) AND Gg_in(0)) OR 
                      (Pg_in(2) AND Pg_in(1) AND Pg_in(0) AND C0);

    -- C16 (Final Cout) = Gg3 + ... + Pg3*Pg2*Pg1*Pg0*C0
    C_block_out(4) <= Gg_in(3) OR (Pg_in(3) AND Gg_in(2)) OR (Pg_in(3) AND Pg_in(2) AND Gg_in(1)) OR 
                      (Pg_in(3) AND Pg_in(2) AND Pg_in(1) AND Gg_in(0)) OR 
                      (Pg_in(3) AND Pg_in(2) AND Pg_in(1) AND Pg_in(0) AND C0);

END ARCHITECTURE dataflow;
```
</div>

:: right ::

**3. cla_adder_16bit.vhd**
* This is the top-level VHDL code for the 16-bit Carry Lookahead Adder (CLA)

```vhdl {*}{maxHeight:'350px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: 16-bit CLA Adder Interface
---------------------------------------------------------------------
ENTITY cla_adder_16bit IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- Two 16-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in (C0)
        S       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- 16-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (C16)
    );
END ENTITY cla_adder_16bit;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation using GCLA
---------------------------------------------------------------------
ARCHITECTURE structural OF cla_adder_16bit IS

    -- --- 1. Component Declarations (4-bit Blocks) ---

    -- The 4-bit CLA component (which contains its own P/G/Sum logic)
    COMPONENT cla_4bit_block
        PORT (
            A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin     : IN  STD_LOGIC;
            S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            -- Group P and G signals (Outputs used by the GCLA)
            Pg_out  : OUT STD_LOGIC;
            Gg_out  : OUT STD_LOGIC;
            Cout    : OUT STD_LOGIC -- (C4, C8, C12, C16)
        );
    END COMPONENT;

    -- The Group Carry Lookahead (GCLA) component
    COMPONENT gcla_logic
        PORT (
            Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G, G^G from 4 blocks
            C0           : IN  STD_LOGIC;                    -- Global C0
            C_block_out  : OUT STD_LOGIC_VECTOR(4 DOWNTO 1)  -- Calculated Carries C4, C8, C12, C16
        );
    END COMPONENT;


    -- --- 2. Internal Signals ---

    -- Group Propagate (P^G) and Group Generate (G^G) signals from each of the 4 blocks
    SIGNAL Pg_vec, Gg_vec : STD_LOGIC_VECTOR(3 DOWNTO 0); 
    
    -- Block Carry-in signals: C4, C8, C12, C16 (C_vec(1) to C_vec(4))
    SIGNAL C_block_carry : STD_LOGIC_VECTOR(4 DOWNTO 1); 


BEGIN

    -- --- 3. Instantiate the Four 4-bit CLA Blocks (B0 to B3) ---

    -- Block 0 (Bits 0-3): LSB
    B0: cla_4bit_block
        PORT MAP (
            A       => A(3 DOWNTO 0),
            B       => B(3 DOWNTO 0),
            Cin     => Cin,                  -- Global Cin
            S       => S(3 DOWNTO 0),
            Pg_out  => Pg_vec(0),
            Gg_out  => Gg_vec(0),
            Cout    => C_block_carry(1)      -- C4 (Output is C_block_carry(1))
        );

    -- Block 1 (Bits 4-7)
    B1: cla_4bit_block
        PORT MAP (
            A       => A(7 DOWNTO 4),
            B       => B(7 DOWNTO 4),
            Cin     => C_block_carry(1),     -- Cin is C4 from GCLA/B0
            S       => S(7 DOWNTO 4),
            Pg_out  => Pg_vec(1),
            Gg_out  => Gg_vec(1),
            Cout    => C_block_carry(2)      -- C8 (Output is C_block_carry(2))
        );
        
    -- Block 2 (Bits 8-11)
    B2: cla_4bit_block
        PORT MAP (
            A       => A(11 DOWNTO 8),
            B       => B(11 DOWNTO 8),
            Cin     => C_block_carry(2),     -- Cin is C8 from GCLA/B1
            S       => S(11 DOWNTO 8),
            Pg_out  => Pg_vec(2),
            Gg_out  => Gg_vec(2),
            Cout    => C_block_carry(3)      -- C12 (Output is C_block_carry(3))
        );

    -- Block 3 (Bits 12-15): MSB
    B3: cla_4bit_block
        PORT MAP (
            A       => A(15 DOWNTO 12),
            B       => B(15 DOWNTO 12),
            Cin     => C_block_carry(3),     -- Cin is C12 from GCLA/B2
            S       => S(15 DOWNTO 12),
            Pg_out  => Pg_vec(3),
            Gg_out  => Gg_vec(3),
            Cout    => C_block_carry(4)      -- C16 (Output is C_block_carry(4))
        );

    -- 4. Map Final Output
    Cout <= C_block_carry(4); -- Final Carry (C16)

    -- NOTE: For simplicity in synthesis, the C_block_carry signals here are 
    -- connected in a simple ripple fashion between the blocks. In a full two-level 
    -- CLA, these signals would be calculated by the 'gcla_logic' component 
    -- INSTANTIATED HERE using Pg_vec and Gg_vec, and then fed back to the blocks.

    -- For a true two-level CLA implementation, you would replace the ripple connections
    -- and add the GCLA instantiation like this (uncommented implementation below):

    /* GCLA_UNIT: gcla_logic
        PORT MAP (
            Pg_in => Pg_vec,
            Gg_in => Gg_vec,
            C0    => Cin,
            C_block_out => C_block_carry
        );

    -- Then, B1, B2, and B3 would receive their Cin from C_block_carry(1), C_block_carry(2), etc.
    */


END ARCHITECTURE structural;
```

---
layout: two-cols-header
---

### Delay Analysis: Ripple vs. Hierarchical CLA

Let's compare a 16-bit adder, assuming 1 gate delay is `t`.

:: left ::
<div class="pr-4">

*   **16-bit Ripple-Carry Adder:**
    *   The carry must ripple through 15 full adders after the first. Each FA has a 2-gate delay for carry.
    *   Total Delay for $C_{16}$: $\approx 16 \times 2t = \textbf{32t}$.

</div>

:: right ::

*   **16-bit Hierarchical CLA (Two Levels):**

<transform scale="0.9">

1.  **1t:** Calculate all $P_i$ and $G_i$ signals in parallel.
2.  **2t:** Calculate block $P^*$ and $G^*$ signals for all blocks.
3.  **2t:** The second-level CLA calculates the block carries ($C_4, C_8, C_{12}$).
4.  **2t:** The carries *within* each block (e.g., $C_1, C_2, C_3$) are calculated.
5.  **1t:** The final sum bits ($S_i = P_i \oplus C_i$) are calculated.
*   Total Delay for the final sum bit: $1t+2t+2t+2t+1t = \textbf{8t}$.


The hierarchical CLA is significantly faster, showing a **4x improvement** in this case.
</transform>

---
layout: two-cols-header
---

## Multiplication

:: left ::

**Basic Concept:** Multiplication is a process of adding partial products.

<div class="pr-4">

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

</div>

The product of two 4-bit numbers is an 8-bit number.

:: right ::

### Combinational Multiplier

A combinational multiplier can be built using an array of AND gates to form the partial products and an array of adders to sum them up.

*   The partial products are $A_i \cdot B_j$.
*   These products are then added together, shifted according to their bit position.
*   This can be implemented with an array of full adders and half adders.
*   For a 4x4 multiplier:
    *   16 AND gates to form partial products.
    *   12 adders (a mix of HA and FA) to sum them.

---

### VHDL Implementation

```vhdl {*}{maxHeight:'350px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: 4x4 Multiplier Interface (A * B = P)
---------------------------------------------------------------------
ENTITY multiplier_4x4 IS
    PORT (
        A, B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- Two 4-bit multiplicands
        P    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- 8-bit product (P7 to P0)
    );
END ENTITY multiplier_4x4;

---------------------------------------------------------------------
-- ARCHITECTURE: Structural Implementation (Array Multiplier)
---------------------------------------------------------------------
ARCHITECTURE structural OF multiplier_4x4 IS

    -- 1. Component Declarations
    -- Assumes existence of Half Adder and Full Adder entities.
    COMPONENT half_adder
        PORT ( X, Y : IN STD_LOGIC; S, C : OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT full_adder
        PORT ( A, B, Cin : IN STD_LOGIC; S, Cout : OUT STD_LOGIC );
    END COMPONENT;

    -- 2. Internal Signals

    -- 16 Partial Products (PP_i_j)
    -- PP(i, j) = A(i) AND B(j)
    SIGNAL PP : STD_LOGIC_MATRIX(3 DOWNTO 0, 3 DOWNTO 0);
    
    -- Internal Sums and Carries (S, C) for the 12 Adders
    -- We define 3 carry signal vectors (C1 to C3) and 4 sum signal vectors (S0 to S3).
    SIGNAL S_int : STD_LOGIC_MATRIX(3 DOWNTO 0, 3 DOWNTO 0);
    SIGNAL C_int : STD_LOGIC_MATRIX(3 DOWNTO 1, 3 DOWNTO 0);

BEGIN
    -- --- Stage 1: Partial Product Generation (16 AND Gates) ---
    -- PP(i, j) = A(i) AND B(j)
    PP_GEN: FOR i IN 0 TO 3 GENERATE
        PP_ROW: FOR j IN 0 TO 3 GENERATE
            PP(i, j) <= A(i) AND B(j);
        END GENERATE PP_ROW;
    END GENERATE PP_GEN;

    -- --- Stage 2: Adder Array Summation (12 Adders) ---
    
    -- 0. Product Bit P(0) (Direct from LSB Partial Product)
    P(0) <= PP(0, 0);

    -- 1. Row 0: Carry chain for the first row of additions (P1, P2, P3)
    -- Uses 3 Half Adders (HA)
    
    -- Col 1 (P1)
    HA01: half_adder PORT MAP (
        X => PP(0, 1),
        Y => PP(1, 0),
        S => P(1),
        C => C_int(1, 0) -- C1_0
    );

    -- Col 2 (S_int(0, 2))
    HA02: half_adder PORT MAP (
        X => PP(0, 2),
        Y => PP(2, 0),
        S => S_int(0, 2),
        C => C_int(1, 1) -- C1_1
    );

    -- Col 3 (S_int(0, 3))
    HA03: half_adder PORT MAP (
        X => PP(0, 3),
        Y => PP(3, 0),
        S => S_int(0, 3),
        C => C_int(1, 2) -- C1_2
    );

    -- 2. Row 1: Full Adders (FA) for the second row of summation
    -- Uses 4 Full Adders (FA)
    
    -- Col 2 (S_int(1, 2))
    FA12: full_adder PORT MAP (
        A   => PP(1, 1),
        B   => S_int(0, 2),
        Cin => C_int(1, 0), -- Carry-in from HA01
        S   => S_int(1, 2),
        Cout => C_int(2, 0) -- C2_0
    );

    -- Col 3 (S_int(1, 3))
    FA13: full_adder PORT MAP (
        A   => PP(1, 2),
        B   => S_int(0, 3),
        Cin => C_int(1, 1), -- Carry-in from HA02
        S   => S_int(1, 3),
        Cout => C_int(2, 1) -- C2_1
    );

    -- Col 4 (S_int(1, 4))
    FA14: full_adder PORT MAP (
        A   => PP(2, 1),
        B   => PP(3, 1),
        Cin => C_int(1, 2), -- Carry-in from HA03
        S   => S_int(1, 4),
        Cout => C_int(2, 2) -- C2_2
    );
    
    -- Col 5 (S_int(1, 5)) -- This is just a half adder or a direct path, let's use FA for consistency
    FA15: full_adder PORT MAP (
        A   => PP(3, 2),
        B   => '0', -- Padding for simplification
        Cin => C_int(1, 3), -- Assumed carry-in (or simplified logic)
        S   => S_int(1, 5),
        Cout => C_int(2, 3) -- C2_3
    );


    -- 3. Row 2: Final Adders (P4, P5, P6, P7)
    -- This row completes the final sum bits P(4) through P(7).
    
    -- Col 4 (P4)
    FA24: full_adder PORT MAP (
        A   => PP(2, 2),
        B   => S_int(1, 4),
        Cin => C_int(2, 0), -- Carry-in from FA12
        S   => P(4),
        Cout => C_int(3, 0) -- C3_0
    );

    -- Col 5 (P5)
    FA25: full_adder PORT MAP (
        A   => PP(3, 3),
        B   => S_int(1, 5),
        Cin => C_int(2, 1), -- Carry-in from FA13
        S   => P(5),
        Cout => C_int(3, 1) -- C3_1
    );

    -- Col 6 (P6)
    FA26: full_adder PORT MAP (
        A   => C_int(2, 2), -- Input is the carry from FA14
        B   => C_int(2, 3), -- Input is the carry from FA15
        Cin => C_int(3, 0), -- Carry-in from FA24
        S   => P(6),
        Cout => C_int(3, 2) -- C3_2
    );

    -- Col 7 (P7)
    P(7) <= C_int(3, 1) OR C_int(3, 2); -- Final MSB logic (simplified)

END ARCHITECTURE structural;
```

---
layout: two-cols-header
---

## Fixed-Point Numbers

:: left ::
Fixed-point is a simple way to represent fractional numbers using a fixed number of bits for the integer and fractional parts.



<div class="text-sm p-2">

*   **Format:** The position of the radix point (binary point) is implicitly fixed. A common notation is `Qn.m`, where `n` is the number of integer bits and `m` is the number of fractional bits.
*   **Conversion:** The integer part is converted as a standard unsigned binary number. The fractional part is converted by repeatedly multiplying by 2.
*   **Advantages:**
    *   Much simpler and faster hardware than floating-point.
    *   Lower power consumption.
*   **Disadvantages:**
    *   Limited range and precision. The programmer must choose the format carefully to avoid overflow or loss of precision.

</div>

:: right ::

<div class="text-sm">

**Example: Represent (6.75)₁₀ in Q4.4 format**

An 8-bit number with 4 integer bits and 4 fractional bits.

1.  **Integer Part:** `(6)₁₀ = (0110)₂`
2.  **Fractional Part:** `(0.75)₁₀`
    *   `0.75 × 2 = 1.50` &rarr; `1`
    *   `0.50 × 2 = 1.00` &rarr; `1`
    *   `0.00 × 2 = 0.00` &rarr; `0`
    *   `0.00 × 2 = 0.00` &rarr; `0`
    *   Fractional part is `(.1100)₂`

**Result:**
The Q4.4 representation is `0110 1100`.

* Value = $(0 \cdot 2^3 + 1 \cdot 2^2 + 1 \cdot 2^1 + 0 \cdot 2^0) + (1 \cdot 2^{-1} + 1 \cdot 2^{-2} + 0 \cdot 2^{-3} + 0 \cdot 2^{-4})$
* Value = $(4 + 2) + (0.5 + 0.25) = 6.75$

</div>


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

**Value = $\bm{(-1)^S × (1.M) × 2^{(E-127)}}$**

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

---
layout: two-cols-header
---

## ASCII (American Standard Code for Information Interchange)



ASCII is a character encoding standard that assigns a unique numeric code to letters, numbers, punctuation marks, and control characters.

:: left ::

<div class="pr-4">

*   **7-bit Standard:** The original standard uses 7 bits to represent 128 characters (0-127).
    *   `0-31`: Non-printable control characters (e.g., `NUL`, `ETX`, `BEL`).
    *   `32-127`: Printable characters, including space, punctuation, digits `0-9`, and letters `A-Z` and `a-z`.
*   **8-bit (Extended ASCII):** Most modern systems use 8-bit encodings which add another 128 characters for special symbols, accented letters, and graphics.

</div>
:: right ::

*   **Importance:** ASCII forms the basis for most modern character encodings, including Unicode and UTF-8.


**Example ASCII Codes**

$$
\begin{array}{c|c|c|c}
\textbf{Character} & \textbf{Decimal} & \textbf{Hex} & \textbf{Binary} \\
\hline
\text{A} & 65 & 41 & 0100\ 0001 \\
\text{B} & 66 & 42 & 0100\ 0010 \\
\text{a} & 97 & 61 & 0110\ 0001 \\
\text{b} & 98 & 62 & 0110\ 0010 \\
\text{0} & 48 & 30 & 0011\ 0000 \\
\text{1} & 49 & 31 & 0011\ 0001 \\
\text{Space} & 32 & 20 & 0010\ 0000 \\
\text{!} & 33 & 21 & 0010\ 0001 \\
\end{array}
$$

---
layout: two-cols-header
---

## Lecture 4 Summary

::left::

### Number Systems & Representations
<div class="text-base">

*   **Unsigned vs. Signed:** We differentiated between basic binary/hex and systems for representing negative numbers.
*   **Two's Complement:** The dominant standard for signed integers due to its simple arithmetic, single zero representation, and predictable behavior.
*   **Other Codes:**
    *   **Fixed-Point:** A simple, efficient way to handle fractions.
    *   **Floating-Point (IEEE 754):** A complex but powerful standard for a wide dynamic range of real numbers.
    *   **BCD & ASCII:** Essential for human-centric interfaces (displays, keyboards).
</div>

::right::

#### Arithmetic Circuits

<div class="text-[14.5px]">

*   **Building Blocks:** We started with **Half Adders** and **Full Adders**.
*   **Ripple-Carry Adder:** Simple to construct by chaining Full Adders, but slow because the carry signal must propagate serially.
*   **Adder/Subtractor:** A clever application of XOR gates and two's complement to combine addition and subtraction into one circuit.
*   **Carry Lookahead Adder (CLA):** A high-speed adder that calculates carries in parallel using **Propagate (P)** and **Generate (G)** logic, overcoming the ripple-carry delay.
*   **Hierarchical CLA:** A practical method for building large, fast adders (e.g., 16-bit, 64-bit) by organizing CLAs into multiple levels.
*   **Array Multiplier:** A combinational circuit for multiplication based on generating and summing partial products.

</div>

---
layout: section
---

## Lecture 4 Exercises

---
layout: two-cols-header
---

### Exercise 4-1: Number Conversion

::left::

### Question 1

Convert the decimal number **-75** to:
1.  An 8-bit two's complement binary number.
2.  A hexadecimal number.



::right::

### Question 2

What is the decimal value of the 8-bit two's complement number `1011 0101`?

---

### Exercise 4-2: Two's Complement Arithmetic

Given two 8-bit two's complement numbers:
*   `A = 0110 1001`
*   `B = 1101 0110`

1.  Calculate `A + B`. Is there an overflow?
2.  Calculate `A - B`. Is there an overflow? (Remember: $A - B = A + (-B)$)


---

### Exercise 4-3: Adder Logic

Consider a 16-bit adder.

1.  What is the approximate worst-case delay for a **16-bit Ripple-Carry Adder** if each full adder has a carry-out delay of 2 gate delays?

2.  What are the **Propagate ($P_i$)** and **Generate ($G_i$)** signals for a Carry Lookahead Adder, and why are they useful?


---

### Exercise 4-4: VHDL of 8-bit Ripple-Carry Adder

You have the `ripple_adder_4bit` entity from the lecture.

```vhdl
ENTITY ripple_adder_4bit IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin     : IN  STD_LOGIC;
        S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout    : OUT STD_LOGIC
    );
END ENTITY ripple_adder_4bit;
```

How would you use this component to create an **8-bit ripple-carry adder**? Write the structural VHDL code for the 8-bit adder entity.


