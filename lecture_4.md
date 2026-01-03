---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 4 - Number Representation & Arithmetic Circuits
routeAlias: lecture_4
---

# Lecture 4: Number Representation & Arithmetic Circuits
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

<div class="grid grid-cols-7 gap-4">

<div class="col-span-2">

1.  **Sign-Magnitude**
2.  **One's Complement**
3.  **Two's Complement**
</div>

<div class="col-span-5">

<img src="/lect_4_8bit_msb_lsb.svg" class="w110 mx-auto mt-4 mb-8 bg-white rounded-lg p-4" alt="8-bit MSB LSB Illustration"/>
<p class="text-center text-sm">Figure 4-1: 8-bit Signed Number uses MSB as sign bit.</p>

</div>
</div>


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

<img src="/lect_2_half_adder.svg" class="h-40 mt-4 bg-white rounded-lg p-4" alt="Half Adder Circuit"/>
<p class="text-sm text-center">Figure 4-2. Half Adder Circuit.</p>

---

### Quartus(r) Schematic for Half Adder

<div class="grid grid-cols-3 gap-4">

<div class="col-span-2">
<img src="/lect_4_quartus_schematic_HA.png" class="w-full p-2 mx-auto bg-white rounded-lg" alt="Half Adder Schematic"/>
<p class="text-sm text-center">Figure 4-3. Half Adder Schematic (Block Diagram/Schematic File).</p>
<img src="/lect_4_simulation_waveform_HA.png" class="w-full p-2 mx-auto bg-white rounded-lg" alt="Half Adder Simulation"/>
<p class="text-sm text-center">Figure 4-4. Half Adder Simulation (University Program VWF).</p>
</div>

<div>
<img src="/lect_4_rtl_viewer_schematic_HA.png" class="w-full p-2 mx-auto bg-white rounded-lg mt-25" alt="Half Adder Schematic"/>
<p class="text-sm text-center">Figure 4-5. Half Adder Schematic (RTL Viewer).</p>
</div>

</div>
---


## Full-Adder

A **Full Adder** is a combinational circuit that adds three bits: two input bits (A, B) and a carry-in ($C_{in}$). This allows them to be chained together to add multi-bit numbers.

<div class="grid grid-cols-10 gap-1">
<div class="col-span-4 text-base">

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



</div>
<div class="col-span-6 text-base">

<img src="/lect_4_circuit_full_adder.svg" class="p-1 w-95 mx-auto bg-white rounded-lg" alt="Full Adder Circuit"/>
<p class="text-sm text-center">Figure 4-6. Full Adder Circuit.</p>
A full-adder can be constructed from two half-adders and an OR gate.
<img src="/lect_4_circuit_full_adder_from_ha.svg" class="p-1 w-95 mx-auto bg-white rounded-lg" alt="HA"/>
<p class="text-sm text-center">Figure 4-7. Full Adder from Half Adders.</p>

</div>
</div>
---

### Quartus(r) Schematic

<img src="/lect_4_schematic_FA_from_HA.png" class="w-200 p-2 mx-auto bg-white rounded-lg" alt="Full Adder Schematic"/>
<p class="text-sm text-center">Figure 4-8. Full Adder from Half Adders Schematic (using Half Adder Symbol File).</p>
<img src="/lect_4_simulation_schematic_FA_from_HA.png" class="w-200 p-2 mx-auto bg-white rounded-lg" alt="Full Adder Simulation"/>
<p class="text-sm text-center">Figure 4-9. Full Adder Simulation (University Program VWF).</p>


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


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_FA.png" class="p-2 w-200 mx-auto"/>
<p class="text-sm text-center">Figure 4-10. RTL Viewer: Full Adder.</p>






---


## Ripple-Carry Adder

To add multi-bit numbers, we can cascade full-adders. The carry-out ($C_{out}$) from one stage "ripples" to become the carry-in ($C_{in}$) of the next stage.



*   This creates a **4-bit ripple-carry adder**.
*   The initial carry-in, $C_0$, is typically set to 0 for standard addition.
*   The main drawback is the delay; the sum bit $S_3$ is not valid until the carry has propagated through all previous stages.

<img src="/lect_4_circuit_ripple_adder.svg" class="w-115 mx-auto bg-white rounded-lg p-4" alt="4-bit Ripple-Carry Adder"/>
<p class="text-sm text-center">Figure 4-11. 4-bit Ripple-Carry Adder.</p>



---


### VHDL Implementation of Ripple-Carry Adder

<div class="grid grid-cols-2 gap-4 ">
<div>

The following code defines the 4-bit adder, receives two 4-bit vectors ($A$ and $B$) and a carry-in ($C_{in}$), and outputs the 4-bit sum ($S$) and the final carry-out ($C_{out}$).

**ripple_adder_4bit.vhd**
```vhdl {*}{maxHeight:'260px',lines:true}
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
</div>

<div>

**ripple_adder_4bit_tb.vhd**
```vhdl{*}{maxHeight:'380px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ripple_adder_4bit_tb IS
END ENTITY ripple_adder_4bit_tb;

ARCHITECTURE behavior OF ripple_adder_4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ripple_adder_4bit
        PORT(
            A : IN  std_logic_vector(3 downto 0);
            B : IN  std_logic_vector(3 downto 0);
            Cin : IN  std_logic;
            S : OUT  std_logic_vector(3 downto 0);
            Cout : OUT  std_logic
        );
    END COMPONENT;

    -- Inputs
    signal A : std_logic_vector(3 downto 0) := (others => '0');
    signal B : std_logic_vector(3 downto 0) := (others => '0');
    signal Cin : std_logic := '0';

    -- Outputs
    signal S : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ripple_adder_4bit PORT MAP (
        A => A,
        B => B,
        Cin => Cin,
        S => S,
        Cout => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;

        -- Test Case 1: 0 + 0 + 0
        A <= "0000"; B <= "0000"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0000" and Cout = '0') report "Error Case 1" severity error;

        -- Test Case 2: 1 + 1 + 0
        A <= "0001"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0010" and Cout = '0') report "Error Case 2" severity error;

        -- Test Case 3: 15 + 1 + 0 (Overflow)
        A <= "1111"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        assert (S = "0000" and Cout = '1') report "Error Case 3" severity error;

        -- Test Case 4: 15 + 15 + 1
        A <= "1111"; B <= "1111"; Cin <= '1';
        wait for 10 ns;
        assert (S = "1111" and Cout = '1') report "Error Case 4" severity error;

        -- Test Case 5: 5 + 3 + 0
        A <= "0101"; B <= "0011"; Cin <= '0';
        wait for 10 ns;
        assert (S = "1000" and Cout = '0') report "Error Case 5" severity error;

        report "Simulation Finished" severity note;
        wait;
    end process;

END;

```
</div>

</div>

---


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_RA.png" class="p-1 w-160 mx-auto"/>
<p class="text-sm text-center">Figure 4-12. RTL Viewer: Ripple Adder.</p>


### Simulation results in ModelSim(r)

<img src="/lect_4_sim_result_RA.png" class="p-1 w-160 mx-auto"/>
<p class="text-sm text-center">Figure 4-13. Simulation Result: Ripple Adder.</p>


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

<img src="/lect_4_circuit_adder_subtractor.svg" class="w-full mx-auto bg-white rounded-lg p-4" alt="Adder/Subtractor Circuit"/>
<p class="text-sm text-center">Figure 4-14. Adder/Subtractor Circuit.</p>

---


### VHDL Implementation

<div class="grid grid-cols-2 gap-4">
<div>

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
</div>

<div>

**adder_subtractor_4bit_tb.vhd**
```vhdl{*}{maxHeight:'360px',lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_subtractor_4bit_tb IS
END ENTITY adder_subtractor_4bit_tb;

ARCHITECTURE behavior OF adder_subtractor_4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT adder_subtractor_4bit
        PORT(
            A       : IN  std_logic_vector(3 downto 0);
            B       : IN  std_logic_vector(3 downto 0);
            add_sub : IN  std_logic;
            S       : OUT std_logic_vector(3 downto 0);
            Cout    : OUT std_logic
        );
    END COMPONENT;

    -- Inputs
    signal A       : std_logic_vector(3 downto 0) := (others => '0');
    signal B       : std_logic_vector(3 downto 0) := (others => '0');
    signal add_sub : std_logic := '0';

    -- Outputs
    signal S    : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: adder_subtractor_4bit PORT MAP (
        A       => A,
        B       => B,
        add_sub => add_sub,
        S       => S,
        Cout    => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;

        -- Test Case 1: Addition 5 + 3 = 8
        -- 0101 + 0011 = 1000 (-8 in signed, 8 in unsigned)
        A <= "0101"; B <= "0011"; add_sub <= '0';
        wait for 10 ns;
        assert (S = "1000") report "Error Case 1: 5+3" severity error;

        -- Test Case 2: Subtraction 5 - 3 = 2
        -- 0101 - 0011 = 0010
        A <= "0101"; B <= "0011"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "0010") report "Error Case 2: 5-3" severity error;

        -- Test Case 3: Subtraction 3 - 5 = -2
        -- 0011 - 0101 = 1110 (-2 in 2's complement)
        A <= "0011"; B <= "0101"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "1110") report "Error Case 3: 3-5" severity error;

        -- Test Case 4: Addition 7 + 2 = 9 (Overflow)
        -- 0111 + 0010 = 1001 (-7 in signed, overflow occurred)
        A <= "0111"; B <= "0010"; add_sub <= '0';
        wait for 10 ns;
        assert (S = "1001") report "Error Case 4: 7+2" severity error;

        -- Test Case 5: Subtraction -8 - 1 = -9 (Underflow/Overflow)
        -- 1000 - 0001 = 0111 (+7 in signed, overflow occurred)
        A <= "1000"; B <= "0001"; add_sub <= '1';
        wait for 10 ns;
        assert (S = "0111") report "Error Case 5: -8-1" severity error;

        report "Simulation Finished" severity note;
        wait;
    end process;

END;

```
</div>

</div>

---


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_AS.png" class="p-1 w-190 mx-auto"/>
<p class="text-sm text-center">Figure 4-15. RTL Viewer: Adder/Subtractor.</p>


### Simulation results in ModelSim(r)

<img src="/lect_4_sim_result_AS.png" class="p-1 w-full mx-auto"/>
<p class="text-sm text-center">Figure 4-16. Simulation Result: Adder/Subtractor.</p>
---

## Problem of Delay in Ripple Carry Adder

The critical path (worst-case delay) in a ripple-carry adder occurs when a carry signal must propagate, or "ripple," through every full-adder in the chain.

*   **Example:** `1111 + 0001`. The carry generated by the first stage must travel all the way to the last stage.
*   For an n-bit adder, the total delay is proportional to *n*. For a 16-bit adder, this could be **32 gate delays** or more.
*   This linear scaling of delay is unacceptable for modern high-speed processors.

<img src="/lect_4_ripple_carry_delay.svg" class="w-145 mx-auto bg-white rounded-lg mt-4 p-1" alt="Ripple Carry Delay Illustration"/>
<p class="text-sm text-center">Figure 4-17. Ripple Carry Delay Illustration.</p>



---

## Carry Lookahead Adder

* A **Carry Lookahead Adder (CLA)** solves this by computing all the carry signals in parallel, directly from the input bits. This breaks the dependency chain and makes the adder significantly faster.

<img src="/lect_4_circuit_cla_4bit.svg" class="w-200 mx-auto mt-4 bg-white rounded-lg p-4" alt="Carry Lookahead Adder Block Diagram"/>
<p class="text-sm text-center">Figure 4-18. Carry Lookahead Adder Block Diagram.</p>


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

    -- Internal Signals for correct Carry-in for each bit i=0 to 3 (C0, C1, C2, C3)
    SIGNAL C_in_sum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
BEGIN

    -- Map C0 (Cin) and C1-C3 (from C_vec) to the correct carry-in signals for the Sum Logic
    -- C_in_sum(0) must be C0, and C_in_sum(1 to 3) must be C_vec(1 to 3)
    C_in_sum(0) <= Cin;
    C_in_sum(3 DOWNTO 1) <= C_vec(3 DOWNTO 1); 

    -- 1. Generate P and G Signals (4 instances of PG_Unit)
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
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in => P_vec(i),
                -- Use the pre-calculated C_in_sum(i)
                C_in => C_in_sum(i),
                S_out => S(i)
            );
    END GENERATE;

END ARCHITECTURE structural;
```
</div>
</div>

---


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_cla_4bit.png" class="p-4 w-full mx-auto"/>
<p class="text-sm text-center">Figure 4-19. RTL Viewer: 4-bit CLA.</p>


---

### Hierarchical Carry Lookahead
* A single-level carry-lookahead unit for a large adder (e.g., 16-bit) is impractical due to the massive fan-in required for the gates. The solution is a **hierarchical** or **cascaded** approach. We can build a 16-bit adder by connecting four 4-bit CLA adders.


**16-bit Adder with Cascaded CLAs**

<img src="/lect_4_16-bit_cla.svg" class="w-180 mx-auto mt-4 bg-white rounded-lg p-4" alt="Placeholder: 16-bit Cascaded Carry Lookahead Adder diagram"/>
<p class="text-sm text-center">Figure 4-20. 16-bit Cascaded Carry Lookahead Adder.</p>




---

* A second-level Carry Lookahead Unit computes carries *between* the blocks. It uses "super" Propagate ($P^*$) and Generate ($G^*$) signals from each 4-bit block.
* A second-level CLA unit uses the P* and G* signals from each 4-bit block to generate the carries between them ($C_4, C_8, C_{12}$) in parallel.

<div class="text-base">

$$
\begin{aligned}
P_0^* &= P_3 \cdot P_2 \cdot P_1 \cdot P_0 \\
P_1^* &= P_7 \cdot P_6 \cdot P_5 \cdot P_4 \\
P_2^* &= P_{11} \cdot P_{10} \cdot P_9 \cdot P_8 \\
P_3^* &= P_{15} \cdot P_{14} \cdot P_{13} \cdot P_{12} \\
G_0^* &= G_3 + (P_3 \cdot G_2) + (P_3 \cdot P_2 \cdot G_1) + (P_3 \cdot P_2 \cdot P_1 \cdot G_0) \\
G_1^* &= G_7 + (P_7 \cdot G_6) + (P_7 \cdot P_6 \cdot G_5) + (P_7 \cdot P_6 \cdot P_5 \cdot G_4) \\
G_2^* &= G_{11} + (P_{11} \cdot G_{10}) + (P_{11} \cdot P_{10} \cdot G_9) + (P_{11} \cdot P_{10} \cdot P_9 \cdot G_8) \\
G_3^* &= G_{15} + (P_{15} \cdot G_{14}) + (P_{15} \cdot P_{14} \cdot G_{13}) + (P_{15} \cdot P_{14} \cdot P_{13} \cdot G_{12}) \\
\\
c_4 &= G_0^* + P_0^* \cdot c_0 \\
c_8 &= G_1^* + P_1^* \cdot G_0^* + P_1^* \cdot P_0^* \cdot c_0 \\
c_{12} &= G_2^* + P_2^* \cdot G_1^* + P_2^* \cdot P_1^* \cdot G_0^* + P_2^* \cdot P_1^* \cdot P_0^* \cdot c_0
\end{aligned}
$$
</div>

---


### Delay Analysis: Ripple vs. Hierarchical CLA
Let's compare a 16-bit adder, assuming 1 gate delay is `t`.
*   **16-bit Ripple-Carry Adder:**
    *   The carry must ripple through 15 full adders after the first. Each FA has a 2-gate delay for carry.
    *   Total Delay for $C_{16}$: $\approx 16 \times 2t = \textbf{32t}$.
*   **16-bit Hierarchical CLA:**
1.  **$1t$:** Calculate all $P_i$ and $G_i$ signals in parallel.
2.  **$2t$:** Calculate block $P^*$ and $G^*$ signals for all blocks.
3.  **$2t$:** The second-level CLA calculates the block carries ($C_4, C_8, C_{12}$).
4.  **$2t$:** The carries *within* each block (e.g., $C_1, C_2, C_3$) are calculated.
5.  **$1t$:** The final sum bits ($S_i = P_i \oplus C_i$) are calculated.
*   Total Delay for the final sum bit: $1t+2t+2t+2t+1t = \textbf{8t}$.
The hierarchical CLA is significantly faster, showing a **4x improvement** in this case.
---
layout: two-cols
---


### VHDL Implementation
This code relies on the three component files defined previously (**pg_unit.vhd**, **cla_logic.vhd**, and **sum_logic.vhd**).

**1. cla_4bit_block.vhd (The 4-bit Building Block)**

```vhdl {*}{maxHeight:'300px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_4bit_block IS
PORT (
    A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    Cin     : IN  STD_LOGIC;      -- C0
    S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Pg_out  : OUT STD_LOGIC;      -- Group Propagate (P^G)
    Gg_out  : OUT STD_LOGIC;      -- Group Generate (G^G)
    Cout    : OUT STD_LOGIC       -- Local Cout (C4)
);
END ENTITY cla_4bit_block;

ARCHITECTURE structural OF cla_4bit_block IS

    -- Component Declarations
    COMPONENT pg_unit PORT ( A, B : IN STD_LOGIC; P_out, G_out : OUT STD_LOGIC ); END COMPONENT;
    COMPONENT sum_logic PORT ( P_in, C_in : IN STD_LOGIC; S_out : OUT STD_LOGIC ); END COMPONENT;

    -- Internal Signals
    SIGNAL P_vec, G_vec : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Individual P and G
    SIGNAL C_vec : STD_LOGIC_VECTOR(4 DOWNTO 1);        -- C1, C2, C3, C4 (The calculated carries)
    SIGNAL C_in_sum : STD_LOGIC_VECTOR(3 DOWNTO 0);     -- C0, C1, C2, C3 (Carry inputs for Sum Logic)

BEGIN

    -- 1. Instantiate 4x P/G Units (Calculates Pi and Gi)
    PG_GEN: FOR i IN 0 TO 3 GENERATE
        PG_I: pg_unit PORT MAP (A => A(i), B => B(i), P_out => P_vec(i), G_out => G_vec(i));
    END GENERATE;

    -- 2. Two-Level Carry Lookahead Logic (Calculates C1, C2, C3, C4 concurrently)
    -- C1 = G0 + P0*C0
    C_vec(1) <= G_vec(0) OR (P_vec(0) AND Cin); 

    -- C2 = G1 + P1*G0 + P1*P0*C0
    C_vec(2) <= G_vec(1) OR (P_vec(1) AND G_vec(0)) OR (P_vec(1) AND P_vec(0) AND Cin);

    -- C3 = G2 + P2*G1 + P2*P1*G0 + P2*P1*P0*C0
    C_vec(3) <= G_vec(2) OR 
                (P_vec(2) AND G_vec(1)) OR 
                (P_vec(2) AND P_vec(1) AND G_vec(0)) OR 
                (P_vec(2) AND P_vec(1) AND P_vec(0) AND Cin);

    -- C4 (Group Carry-out) = G3 + P3*G2 + P3*P2*G1 + P3*P2*P1*G0 + P3*P2*P1*P0*C0
    C_vec(4) <= G_vec(3) OR 
                (P_vec(3) AND G_vec(2)) OR 
                (P_vec(3) AND P_vec(2) AND G_vec(1)) OR 
                (P_vec(3) AND P_vec(2) AND P_vec(1) AND G_vec(0)) OR
                (P_vec(3) AND P_vec(2) AND P_vec(1) AND P_vec(0) AND Cin);

    -- 3. Group Signals (P^G and G^G)
    -- Group Propagate (P^G)
    Pg_out <= P_vec(3) AND P_vec(2) AND P_vec(1) AND P_vec(0); 

    -- Group Generate (G^G) (This is the C4 term without the Cin component)
    Gg_out <= G_vec(3) OR 
              (P_vec(3) AND G_vec(2)) OR 
              (P_vec(3) AND P_vec(2) AND G_vec(1)) OR 
              (P_vec(3) AND P_vec(2) AND P_vec(1) AND G_vec(0));

    -- 4. Map the final C4 to the external Cout
    Cout <= C_vec(4);

    -- 5. Route Carry Signals for Sum Logic
    C_in_sum(0) <= Cin;
    C_in_sum(3 DOWNTO 1) <= C_vec(3 DOWNTO 1); 

    -- 6. Instantiate 4x Sum Logic Units (Calculates Si)
    SUM_GEN: FOR i IN 0 TO 3 GENERATE
        SUM_I: sum_logic
            PORT MAP (
                P_in  => P_vec(i),
                C_in  => C_in_sum(i),
                S_out => S(i)
            );
    END GENERATE;

END ARCHITECTURE structural;
```

:: right ::

<div class="pl-4">

**2. cla_group_logic.vhd (Global Carry Lookahead)**

* This block calculates the block-level carries ($C_4, C_8, C_{12}, C_{16}$)


```vhdl{*}{maxHeight:'335px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_group_logic IS
    PORT (
        Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G and G^G from 4 groups
        C0           : IN  STD_LOGIC;                    -- Global Cin (C0)
        C_out        : OUT STD_LOGIC_VECTOR(3 DOWNTO 1)  -- Group Carries C4, C8, C12
    );
END ENTITY cla_group_logic;

ARCHITECTURE two_level_carry OF cla_group_logic IS
    -- Carries C_out(1) = C4, C_out(2) = C8, C_out(3) = C12
BEGIN
    -- C4 = G^G0 + P^G0 * C0
    C_out(1) <= Gg_in(0) OR (Pg_in(0) AND C0);

    -- C8 = G^G1 + P^G1 * C4
    C_out(2) <= Gg_in(1) OR 
                (Pg_in(1) AND Gg_in(0)) OR 
                (Pg_in(1) AND Pg_in(0) AND C0);

    -- C12 = G^G2 + P^G2 * C8
    C_out(3) <= Gg_in(2) OR 
                (Pg_in(2) AND Gg_in(1)) OR 
                (Pg_in(2) AND Pg_in(1) AND Gg_in(0)) OR 
                (Pg_in(2) AND Pg_in(1) AND Pg_in(0) AND C0);

END ARCHITECTURE two_level_carry;
```
</div>
---
layout: two-cols
---

**3. cla_16bit_adder.vhd**
* This is the top-level VHDL code for the 16-bit Carry Lookahead Adder (CLA)

```vhdl {*}{maxHeight:'350px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla_16bit_adder IS
    PORT (
        A, B    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0); -- 16-bit inputs
        Cin     : IN  STD_LOGIC;                    -- Global Carry-in (C0)
        S       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);-- 16-bit Sum output
        Cout    : OUT STD_LOGIC                     -- Final Carry-out (C16)
    );
END ENTITY cla_16bit_adder;

ARCHITECTURE hierarchical OF cla_16bit_adder IS

    -- Component Declarations
    COMPONENT cla_4bit_block
        PORT (
            A, B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin     : IN  STD_LOGIC;
            S       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Pg_out  : OUT STD_LOGIC; -- Group Propagate (P^G)
            Gg_out  : OUT STD_LOGIC; -- Group Generate (G^G)
            Cout    : OUT STD_LOGIC  -- Local Cout (C4, C8, C12, C16)
        );
    END COMPONENT;

    COMPONENT cla_group_logic
        PORT (
            Pg_in, Gg_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            C0           : IN  STD_LOGIC;
            C_out        : OUT STD_LOGIC_VECTOR(3 DOWNTO 1) -- Group Carries C4, C8, C12
        );
    END COMPONENT;


    -- Internal Signals
    SIGNAL Pg_vec, Gg_vec : STD_LOGIC_VECTOR(3 DOWNTO 0); -- P^G and G^G from 4 blocks
    SIGNAL C_group : STD_LOGIC_VECTOR(3 DOWNTO 1);        -- Group Carry outputs (C4, C8, C12)
    SIGNAL C_in_vec : STD_LOGIC_VECTOR(3 DOWNTO 0);       -- Carry-in signals for 4 blocks (C0, C4, C8, C12)
    SIGNAL C_block_out : STD_LOGIC_VECTOR(3 DOWNTO 0);    -- Carry-out from each 4-bit block

BEGIN

    -- 1. Route the Carry-in signals to the 4-bit blocks
    C_in_vec(0) <= Cin;
    C_in_vec(3 DOWNTO 1) <= C_group(3 DOWNTO 1); -- C_in_vec(1)=C4, C_in_vec(2)=C8, C_in_vec(3)=C12

    -- 2. Instantiate the 4-bit CLA Blocks (4 instances)
    BLOCK_GEN: FOR i IN 0 TO 3 GENERATE
        BLOCK_I: cla_4bit_block
            PORT MAP (
                A       => A(i*4+3 DOWNTO i*4),
                B       => B(i*4+3 DOWNTO i*4),
                Cin     => C_in_vec(i),       -- C0 or group carry
                S       => S(i*4+3 DOWNTO i*4),
                Pg_out  => Pg_vec(i),         -- Capture P^G
                Gg_out  => Gg_vec(i),         -- Capture G^G
                Cout    => C_block_out(i)     -- Capture C4, C8, C12, C16
            );
    END GENERATE;


    -- 3. Instantiate the Group Carry-Lookahead Unit (CLU)
    CLU_BLOCK: cla_group_logic
        PORT MAP (
            Pg_in  => Pg_vec,
            Gg_in  => Gg_vec,
            C0     => Cin,
            C_out  => C_group
        );


    -- 4. Map the Final Cout
    Cout <= C_block_out(3); -- Final Cout is C16

END ARCHITECTURE hierarchical;
```

:: right ::

<div class="pl-4">

**4. tb_cla_16bit_adder.vhd**
* This is the testbench for the 16-bit Carry Lookahead Adder (CLA)
```vhdl {*}{maxHeight:'350px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- For converting STD_LOGIC_VECTOR to integers for verification

ENTITY tb_cla_16bit_adder IS
END ENTITY tb_cla_16bit_adder;

ARCHITECTURE behavioral OF tb_cla_16bit_adder IS

    -- 1. Component Declaration for the Unit Under Test (UUT)
    COMPONENT cla_16bit_adder
        PORT (
            A, B    : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cin     : IN  STD_LOGIC;
            S       : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cout    : OUT STD_LOGIC
        );
    END COMPONENT;

    -- 2. Signals for UUT Ports
    SIGNAL A_in, B_in : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Cin_in     : STD_LOGIC := '0';
    SIGNAL S_out      : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Cout_out   : STD_LOGIC;

    -- 3. Constants and Helpers
    CONSTANT c_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    UUT: cla_16bit_adder
        PORT MAP (
            A    => A_in,
            B    => B_in,
            Cin  => Cin_in,
            S    => S_out,
            Cout => Cout_out
        );

    -- Test Process
    PROCESS
        -- Function to convert standard logic vectors to unsigned integers for easy calculation
        FUNCTION to_uint(V : STD_LOGIC_VECTOR) RETURN NATURAL IS
            VARIABLE result : NATURAL := 0;
        BEGIN
            FOR i IN V'RANGE LOOP
                IF V(i) = '1' THEN
                    result := result + 2**(i);
                END IF;
            END LOOP;
            RETURN result;
        END FUNCTION to_uint;

        -- Procedure to perform a test and report results
        PROCEDURE run_test (
            A_val    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            B_val    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Cin_val  : IN STD_LOGIC
        ) IS
            VARIABLE expected_sum    : NATURAL;
            VARIABLE expected_cout   : STD_LOGIC;
            VARIABLE actual_sum      : NATURAL;
            VARIABLE actual_cout     : STD_LOGIC;
            VARIABLE total_sum       : NATURAL;
            VARIABLE test_passed     : BOOLEAN;
				VARIABLE Cin_int         : NATURAL;
        BEGIN
            -- Apply inputs
            A_in <= A_val;
            B_in <= B_val;
            Cin_in <= Cin_val;

            WAIT FOR c_period; -- Wait for combinational delay

            -- Convert single-bit Cin_val to an integer (0 or 1)
            IF Cin_val = '1' THEN
                Cin_int := 1;
            ELSE
                Cin_int := 0;
            END IF;

            -- Calculate expected values (A + B + Cin)
            -- Use Cin_int (NATURAL) instead of Cin_val (STD_LOGIC)
            total_sum := to_uint(A_val) + to_uint(B_val) + Cin_int;
				
            -- Expected Sum is the lower 16 bits of total_sum
            expected_sum := total_sum MOD 65536; 
            
            -- Expected Cout is '1' if the sum exceeds 16 bits (65535)
            IF total_sum > 65535 THEN
                expected_cout := '1';
            ELSE
                expected_cout := '0';
            END IF;

            -- Read actual outputs
            actual_sum := to_uint(S_out);
            actual_cout := Cout_out;

           
            -- Verification
            test_passed := (actual_sum = expected_sum) AND (actual_cout = expected_cout);
            
            IF test_passed THEN
                REPORT "Result: PASSED" SEVERITY NOTE;
            ELSE
                REPORT "Result: FAILED" SEVERITY ERROR;
            END IF;
            
            WAIT FOR c_period;

        END PROCEDURE run_test;

    BEGIN
        REPORT "Starting 16-bit CLA Testbench..." SEVERITY NOTE;

        -- === Test Cases ===

        -- 1. Simple Addition: 10 + 20 + 0 = 30
        run_test(
            A_val   => X"000A", 
            B_val   => X"0014",
            Cin_val => '0'
        );

        -- 2. Basic Carry-in: FFFF + 0 + 1 = 10000 (S=0, Cout=1)
        run_test(
            A_val   => X"FFFF", 
            B_val   => X"0000",
            Cin_val => '1'
        );

        -- 3. Half Max Value: 7FFF + 7FFF + 0 = FFFE (65534)
        run_test(
            A_val   => X"7FFF", 
            B_val   => X"7FFF",
            Cin_val => '0'
        );
        
        -- 4. Maximum Carry-out: FFFF + FFFF + 1 = 1FFFD (S=FFFD, Cout=1)
        run_test(
            A_val   => X"FFFF", 
            B_val   => X"FFFF",
            Cin_val => '1'
        );
        
        -- 5. Carry Propagation Test (Across a group boundary, e.g., 000F + 0001)
        run_test(
            A_val   => X"000F", 
            B_val   => X"0001",
            Cin_val => '0'
        );

        -- 6. Carry Propagation across all 4 groups (0000 + 0001 propagates)
        run_test(
            A_val   => X"0000",
            B_val   => X"0001",
            Cin_val => '0'
        );
        
        -- 7. Carry Propagation across all 16 bits (FF00 + 0100 = 0000, Cout=1)
        run_test(
            A_val   => X"FF00",
            B_val   => X"0100",
            Cin_val => '0'
        );

        REPORT "All tests complete. Simulation halting." SEVERITY NOTE;
        WAIT; 

    END PROCESS;

END ARCHITECTURE behavioral;

```
</div>

---


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_cla_16bit.png" class="p-1 w-120 mx-auto"/>
<p class="text-sm text-center">Figure 4-21. RTL Viewer: 16-bit CLA.</p>


### Simulation results in ModelSim(r)

<img src="/lect_4_sim_result_cla_16bit.png" class="p-1 w-140 mx-auto"/>
<p class="text-sm text-center">Figure 4-22. Simulation Result: 16-bit CLA.</p>




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
       1101        (Partial Product 0)
      1101         (Partial Product 1)
     0000          (Partial Product 2)
    1101           (Partial Product 3)
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


---

### 4x4 multiplier
*   16 AND gates to form partial products.
*   12 adders (a mix of HA and FA) to sum them.

<img src="/lect_4_multiplier_4x4.svg" class="p-4 w-145 mx-auto bg-white rounded-lg"/>
<p class="text-sm text-center">Figure 4-23. 4x4 Array Multiplier.</p>


---
layout: two-cols
---

### VHDL Implementation

**multiplier_4x4.vhd**
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

    COMPONENT half_adder
        PORT ( X, Y : IN STD_LOGIC; S, C : OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT full_adder
        PORT ( A, B, Cin : IN STD_LOGIC; S, Cout : OUT STD_LOGIC );
    END COMPONENT;

    -- Internal Signals
    TYPE pp_matrix IS ARRAY (3 DOWNTO 0, 3 DOWNTO 0) OF STD_LOGIC;
    SIGNAL PP : pp_matrix;

    -- Row 1 Signals (Sum of A*B0 and A*B1)
    SIGNAL S1 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S1(0) is P(1), others pass to Row 2
    SIGNAL C1 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Row 2 Signals (Sum of Row 1 and A*B2)
    SIGNAL S2 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S2(0) is P(2), others pass to Row 3
    SIGNAL C2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Row 3 Signals (Sum of Row 2 and A*B3)
    SIGNAL S3 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- S3(0) is P(3), S3(1) is P(4)...
    SIGNAL C3 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Carry out

BEGIN
    -- --- Stage 1: Partial Product Generation ---
    PP_GEN: FOR i IN 0 TO 3 GENERATE
        PP_ROW: FOR j IN 0 TO 3 GENERATE
            PP(i, j) <= A(i) AND B(j);
        END GENERATE PP_ROW;
    END GENERATE PP_GEN;

    -- --- Stage 2: Adder Array ---

    -- P(0)
    P(0) <= PP(0, 0);

    -- Row 1: Add (A*B0 PPs shifted) and (A*B1 PPs)
    -- Operands:
    -- B0: PP(1,0), PP(2,0), PP(3,0), '0'
    -- B1: PP(0,1), PP(1,1), PP(2,1), PP(3,1)

    -- Adder 1.0 (Bit 1)
    HA10: half_adder PORT MAP (X => PP(1, 0), Y => PP(0, 1), S => S1(0), C => C1(0));
    P(1) <= S1(0);

    -- Adder 1.1 (Bit 2)
    FA11: full_adder PORT MAP (A => PP(2, 0), B => PP(1, 1), Cin => C1(0), S => S1(1), Cout => C1(1));

    -- Adder 1.2 (Bit 3)
    FA12: full_adder PORT MAP (A => PP(3, 0), B => PP(2, 1), Cin => C1(1), S => S1(2), Cout => C1(2));

    -- Adder 1.3 (Bit 4)
    FA13: full_adder PORT MAP (A => '0',      B => PP(3, 1), Cin => C1(2), S => S1(3), Cout => C1(3));


    -- Row 2: Add Result 1 and (A*B2 PPs)
    -- Operands:
    -- Res1: S1(1),   S1(2),   S1(3),   C1(3)
    -- B2:   PP(0,2), PP(1,2), PP(2,2), PP(3,2)

    -- Adder 2.0 (Bit 2)
    HA20: half_adder PORT MAP (X => S1(1), Y => PP(0, 2), S => S2(0), C => C2(0));
    P(2) <= S2(0);

    -- Adder 2.1 (Bit 3)
    FA21: full_adder PORT MAP (A => S1(2), B => PP(1, 2), Cin => C2(0), S => S2(1), Cout => C2(1));

    -- Adder 2.2 (Bit 4)
    FA22: full_adder PORT MAP (A => S1(3), B => PP(2, 2), Cin => C2(1), S => S2(2), Cout => C2(2));

    -- Adder 2.3 (Bit 5)
    FA23: full_adder PORT MAP (A => C1(3), B => PP(3, 2), Cin => C2(2), S => S2(3), Cout => C2(3));


    -- Row 3: Add Result 2 and (A*B3 PPs)
    -- Operands:
    -- Res2: S2(1),   S2(2),   S2(3),   C2(3)
    -- B3:   PP(0,3), PP(1,3), PP(2,3), PP(3,3)

    -- Adder 3.0 (Bit 3)
    HA30: half_adder PORT MAP (X => S2(1), Y => PP(0, 3), S => S3(0), C => C3(0));
    P(3) <= S3(0);

    -- Adder 3.1 (Bit 4)
    FA31: full_adder PORT MAP (A => S2(2), B => PP(1, 3), Cin => C3(0), S => S3(1), Cout => C3(1));
    P(4) <= S3(1);

    -- Adder 3.2 (Bit 5)
    FA32: full_adder PORT MAP (A => S2(3), B => PP(2, 3), Cin => C3(1), S => S3(2), Cout => C3(2));
    P(5) <= S3(2);

    -- Adder 3.3 (Bit 6)
    FA33: full_adder PORT MAP (A => C2(3), B => PP(3, 3), Cin => C3(2), S => S3(3), Cout => C3(3));
    P(6) <= S3(3);
    
    -- P(7) is the final carry out
    P(7) <= C3(3);

END ARCHITECTURE structural;

```

:: right ::

<div class="pl-4">

**multiplier_4x4_tb.vhd**

```vhdl {*}{maxHeight:'380px', lines:true}
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY multiplier_4x4_tb IS
END ENTITY multiplier_4x4_tb;

ARCHITECTURE behavior OF multiplier_4x4_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT multiplier_4x4
        PORT (
            A, B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            P    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Inputs
    SIGNAL A_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    -- Outputs
    SIGNAL P_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: multiplier_4x4 PORT MAP (
        A => A_tb,
        B => B_tb,
        P => P_tb
    );

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Test Case 1: 0 * 0
        A_tb <= "0000"; B_tb <= "0000";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000000") REPORT "Error: 0*0 failed" SEVERITY ERROR;

        -- Test Case 2: 1 * 1
        A_tb <= "0001"; B_tb <= "0001";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000001") REPORT "Error: 1*1 failed" SEVERITY ERROR;

        -- Test Case 3: 15 * 1 (Max 4-bit unsigned * identity)
        A_tb <= "1111"; B_tb <= "0001";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00001111") REPORT "Error: 15*1 failed" SEVERITY ERROR;

        -- Test Case 4: 15 * 15 (Max * Max)
        A_tb <= "1111"; B_tb <= "1111";
        WAIT FOR 10 ns;
        -- 15 * 15 = 225 = 0xE1 = 11100001
        ASSERT (P_tb = "11100001") REPORT "Error: 15*15 failed" SEVERITY ERROR;

        -- Test Case 5: 3 * 2
        A_tb <= "0011"; B_tb <= "0010";
        WAIT FOR 10 ns;
        ASSERT (P_tb = "00000110") REPORT "Error: 3*2 failed" SEVERITY ERROR;
        
        -- Test Case 6: 7 * 9 (Arbitrary)
        A_tb <= "0111"; B_tb <= "1001";
        WAIT FOR 10 ns;
        -- 7 * 9 = 63 = 00111111
        ASSERT (P_tb = "00111111") REPORT "Error: 7*9 failed" SEVERITY ERROR;

        REPORT "Simulation Finished Successfully" SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;

```
</div>

---


### RTL Viewer in Quartus(r)


<img src="/lect_4_rtl_viewer_mul_4x4.png" class="p-2 w-160 mx-auto"/>
<p class="text-sm text-center">Figure 4-24. RTL Viewer: 4x4 Multiplier.</p>


### Simulation results in ModelSim(r)

<img src="/lect_4_sim_result_mul_4x4.png" class="p-2 w-190 mx-auto"/>
<p class="text-sm text-center">Figure 4-25. Simulation Result: 4x4 Multiplier.</p>


---
layout: two-cols-header
---

## Fixed-Point Numbers

:: left ::
<div class="text-base">

Fixed-point is a simple way to represent fractional numbers using a fixed number of bits for the integer and fractional parts.
*   **Format:** The position of the radix point (binary point) is implicitly fixed. A common notation is $Qn.m$, where $n$ is the number of integer bits and $m$ is the number of fractional bits.
*   **Conversion:** The integer part is converted as a standard unsigned binary number. The fractional part is converted by repeatedly multiplying by 2.
*   Much simpler and faster hardware than floating-point.
*   Lower power consumption.
*   Limited range and precision. The programmer must choose the format carefully to avoid overflow or loss of precision.

</div>

:: right ::

<div class="text-base">

**Example: Represent (6.75)₁₀ in Q4.4 format**

An 8-bit number with 4 integer bits and 4 fractional bits.

1.  **Integer Part:** $(6)₁₀ = (0110)₂$
2.  **Fractional Part:** $(0.75)₁₀$
    *   $0.75 × 2 = 1.50$ &rarr; $1$
    *   $0.50 × 2 = 1.00$ &rarr; $1$
    *   $0.00 × 2 = 0.00$ &rarr; $0$
    *   $0.00 × 2 = 0.00$ &rarr; $0$
    *   Fractional part is $(.1100)₂$

**Result:**
The Q4.4 representation is $0110 1100$.

* Value = $(0 \cdot 2^3 + 1 \cdot 2^2 + 1 \cdot 2^1 + 0 \cdot 2^0) + (1 \cdot 2^{-1} + 1 \cdot 2^{-2} + 0 \cdot 2^{-3} + 0 \cdot 2^{-4})$
* Value = $(4 + 2) + (0.5 + 0.25) = 6.75$

</div>


---

## Floating-Point Numbers (IEEE 754 Single Precision)

<div class="grid grid-cols-2 gap-4 text-base">
<div>

A 32-bit format for floating-point values.
<div class="text-sm">

*   **Sign (S):** 1 bit (0 for positive, 1 for negative).
*   **Exponent (E):** 8 bits (excess-127 format).
    *   True exponent = E - 127.
*   **Mantissa (M):** 23 bits.

**Value = $\bm{(-1)^S × (1.M) × 2^{(E-127)}}$**

</div>

The standard calls for a normalized mantissa, where the most significant bit is always 1. This "hidden bit" is not stored, providing an extra bit of precision.

</div>
<div>

**Convert (3.5)₁₀ to IEEE 754 single precision.**

<div class="text-sm">

1.  Convert to binary: $(3.5)₁₀ = (11.1)₂$
2.  Normalize: $(11.1)₂ = (1.11)₂ × 2¹$
3.  **Sign (S):** 0 (positive)
4.  **Exponent (E):** True exponent is 1. `E = 1 + 127 = 128`. In binary, `128 = 10000000₂`.
5.  **Mantissa (M):** The fractional part is `.11`. We pad with zeros to 23 bits: `11000000000000000000000`.

**Result:**
`0 10000000 11000000000000000000000`

</div>
</div>
</div>

<img src="/lect_4_floating_point_32bit.svg" class="w-130 mx-auto bg-white rounded-lg p-2" alt="IEEE 754 32-bit Floating Point Format"/>
<p class="text-sm text-center">Figure 4-26. IEEE 754 32-bit Floating Point Format.</p>

---

## Binary-Coded-Decimal (BCD)
<div class="grid grid-cols-2 gap-4">
<div>

*   Represents decimal numbers by encoding each decimal digit in a 4-bit binary form.
*   Uses 4 bits per digit, for digits 0-9.
    *   `0 = 0000`, `1 = 0001`, ..., `9 = 1001`.
    *   The binary codes `1010` through `1111` are unused.
*   **Example:** $(78)₁₀ = (0111 1000)_{BCD}$
*   Convenient for applications that interface with humans, like calculators or digital clocks, as it simplifies displaying numbers.


</div>
<div>
<img src="/lect_4_bcd_clock.svg" class="w-full mx-auto mt-4 p-5 mb-4 bg-white rounded-lg" alt="BCD to Digital Clock Interface"/>
<p class="text-sm text-center">Figure 4-27. BCD to Digital Clock Interface.</p>

</div>
</div>




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
\small
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

### Number Systems
*   **Signed Integers:** **Two's Complement** is the standard for its simple arithmetic and single zero.
*   **Real Numbers:**
    *   **Fixed-Point:** Efficient for fractions (`Qn.m`), used in low-power apps.
    *   **Floating-Point (IEEE 754):** Large dynamic range (Sign, Exponent, Mantissa).
*   **Human Interface:** **BCD** & **ASCII** for displays and text communication.

::right::

### Arithmetic Circuits
*   **Basic Adders:** **Ripple-Carry** chains Full Adders; simple but suffers from linear delay.
*   **Fast Adders:** **CLA** computes carries in parallel using Propagate/Generate logic.
*   **Unified:** **Adder/Subtractor** uses XOR gates to perform both operations.
*   **Multipliers:** **Array Multiplier** generates and sums partial products.



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


