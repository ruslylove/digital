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

## Outline

*   Review of Number Systems
*   Adders
    *   Ripple carry
    *   Carry Lookahead (fast adders)
    *   Carry Select
*   Combinational Multipliers
*   Arithmetic and Logic Unit (ALU)
*   General Logic Function Units
*   **READING**: Brown's 5.1-5.4, 5.6-5.8

---

## Numbers in Different Radix Systems

<div class="grid grid-cols-2 gap-20 text-center text-xs">

| **Decimal** | **Binary** | **Octal** | **Hexadecimal** |
|:-------:|:------:|:-----:|:-----------:|
| 00      | 00000  | 00    | 00          |
| 01      | 00001  | 01    | 01          |
| 02      | 00010  | 02    | 02          |
| 03      | 00011  | 03    | 03          |
| 04      | 00100  | 04    | 04          |
| 05      | 00101  | 05    | 05          |
| 06      | 00110  | 06    | 06          |
| 07      | 00111  | 07    | 07          |
| 08      | 01000  | 10    | 08          |

| **Decimal** | **Binary** | **Octal** | **Hexadecimal** |
|:-------:|:------:|:-----:|:-----------:|
| 09      | 01001  | 11    | 09          |
| 10      | 01010  | 12    | 0A          |
| 11      | 01011  | 13    | 0B          |
| 12      | 01100  | 14    | 0C          |
| 13      | 01101  | 15    | 0D          |
| 14      | 01110  | 16    | 0E          |
| 15      | 01111  | 17    | 0F          |
| 16      | 10000  | 20    | 10          |
| 17      | 10001  | 21    | 11          |
| 18      | 10010  | 22    | 12          |

</div>

---

## Review of Number Systems

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

## Sign Magnitude/One's Complement Representation

:: left ::
*   High order bit is sign: 0 = positive (or zero), 1 = negative.
*   The other bits represent the magnitude.
    *   e.g., for 4 bits, 3 bits for magnitude: 0 (000) thru 7 (111).
*   Number range for n bits = $\pm(2^{(n-1)} - 1)$.
*   Two representations for 0 (+0 and -0).
*   Cumbersome addition/subtraction.
*   Must compare magnitudes to determine the sign of the result.

:: right ::

<img src="/table_sm_oc.svg" class="p-4 w-120" alt="Sign Magnitude Representation"/>


---
layout: two-cols-header
---

## Two's Complement Representation

:: left ::
*   Has only one representation for 0 (`0000`), unlike One's Complement which has two (`0000` and `1111`).
*   The range of numbers is not symmetric. For n bits, the range is from $-2^{(n-1)}$ to $+2^{(n-1)} - 1$.
*   For 4 bits, this means the range is from -8 to +7. There is one more negative number than positive numbers.

:: right ::

<img src="/table_oc_tc.svg" class="p-4 w-120" alt="Sign Magnitude Representation"/>


---

## Two's Complement Number System

**Formula:** `N* = 2^n - N`

**Example: Two's complement of 7 (n=4)**
`2^4 = 10000`
`sub 7 = 0111`
Result: `1001` (-7)

**Example: Two's complement of -7 (n=4)**
`2^4 = 10000`
`sub -7 = 1001`
Result: `0111` (7)

**Shortcut method:**
Two's complement = bitwise complement + 1
*   `0111` -> `1000` + 1 -> `1001` (representation of -7)
*   `1001` -> `0110` + 1 -> `0111` (representation of 7)

---

## Addition and Subtraction of Numbers

### Sign Magnitude

*   **When signs are the same**, the result sign bit is the same as the operands' sign.
    *   `4 + 3 = 7` -> `0100 + 0011 = 0111`
    *   `-4 + (-3) = -7` -> `1100 + 1011 = 1111`
*   **When signs differ**, the operation is subtraction. The sign of the result depends on the sign of the number with the larger magnitude.
    *   `4 - 3 = 1` -> `0100 - 0011 = 0001`
    *   `-4 + 3 = -1` -> `1100 + 0011 = 1001`

---

### One's Complement

*   **Addition Rule:** Add the numbers. If there is a carry out of the most significant bit (an "end-around carry"), add it to the result.
    *   `4 + 3 = 7` -> `0100 + 0011 = 0111`
    *   `-4 + (-3) = -7` -> `1011 + 1100 = 10111`. Add end-around carry: `0111 + 1 = 1000` (-7).
*   **Subtraction** is performed by adding the one's complement of the subtrahend.
    *   `4 - 3 = 1` -> `4 + (-3)` -> `0100 + 1100 = 10000`. Add end-around carry: `0000 + 1 = 0001` (1).
    *   `-4 + 3 = -1` -> `1011 + 0011 = 1110` (-1).
*   The need for the end-around carry makes the hardware more complex than Two's Complement.

---

## Two's Complement Addition and Subtraction

A simpler addition scheme makes two's complement the most common choice for integer number systems within digital systems.

*   `4 + 3 = 7`
    `0100 + 0011 = 0111`
*   `-4 + (-3) = -7`
    `1100 + 1101 = 11001` (discard carry) -> `1001`
*   `4 - 3 = 1`
    `0100 + 1101 = 10001` (discard carry) -> `0001`
*   `-4 + 3 = -1`
    `1100 + 0011 = 1111`

---

## Arithmetic Overflow

*   The result of addition or subtraction is supposed to fit within the significant bits used to represent the numbers.
*   If *n* bits are used for signed numbers, the result must be in the range `-2^(n-1)` to `+2^(n-1) - 1`.
*   If the result does not fit in this range, we say that **arithmetic overflow** has occurred.
*   It is important to be able to detect the occurrence of overflow to ensure the correct operation of an arithmetic circuit.

---

## Arithmetic Overflow Detection

For 4-bit numbers, there are 3 significant bits and the sign bit.

*   `(+7) + (+2) = +9` -> `0111 + 0010 = 1001` (Incorrect, looks like -7)
    *   `c4=0`, `c3=1` -> **Overflow**
*   `(-7) + (-2) = -9` -> `1001 + 1110 = 10111` (Incorrect, looks like +7)
    *   `c4=1`, `c3=0` -> **Overflow**

**Rule:** Overflow occurs if the carry into the sign bit (`c(n-1)`) is not equal to the carry out of the sign bit (`cn`).
`overflow = c(n-1) XOR cn`

*If the numbers have different signs, no overflow can occur.*

---

## Circuits for Binary Half-Adder

With two's complement numbers, addition is sufficient.

A **Half Adder** adds two single binary digits (A and B).

*   **Sum** = A ⊕ B
*   **Carry** = A ⋅ B

It can be implemented with an XOR gate for the Sum and an AND gate for the Carry.

---

## Full Adder

We are usually interested in adding more than two bits. This motivates the need for the **full adder**.

A **Full Adder** adds three bits: two input bits (A, B) and a carry-in (CI).

A multi-bit adder (like a 4-bit adder) can be constructed by cascading full adders. The carry-out (CO) of one stage is connected to the carry-in (CI) of the next higher-order stage.

---

## Full Adder Logic

*   **S = A ⊕ B ⊕ CI**
*   **CO = (A ⋅ B) + (CI ⋅ (A ⊕ B))**

A full adder can be implemented with two half-adders and an OR gate.
1.  The first half-adder adds A and B.
2.  The second half-adder adds the sum from the first HA to the CI.
3.  The CO is the OR of the carry-outs from both half-adders.

---

## Adder/Subtractor Circuit

A single circuit can perform both addition and subtraction using two's complement arithmetic.

**A - B = A + (-B) = A + B' + 1**

*   An `Add/Subtract` control signal is used.
*   When `Add/Subtract = 0` (for addition), B passes through unchanged and the initial carry-in is 0. The circuit performs `A + B`.
*   When `Add/Subtract = 1` (for subtraction), B is inverted (B') and the initial carry-in is 1. The circuit performs `A + B' + 1`.
*   An XOR gate can be used as a controlled inverter for each bit of B.

---

## Delay Analysis of Ripple Adder

*   The carry-out of a single stage can be implemented in 2 gate delays.
*   For a 16-bit adder, the 16th bit carry is generated after `16 * 2 = 32` gate delays.
*   This takes too long - we need to investigate **FASTER** adders!

---

## Carry Lookahead Adder

The critical delay in a ripple-carry adder is the propagation of carry from low to high order stages.

A **Carry Lookahead Adder** computes the carry signals in advance, based on the input signals, reducing the carry propagation delay.

The worst-case for a ripple-carry adder is when a carry must propagate through all stages, e.g., `1111 + 0001`.

---

## Carry Lookahead Logic

Sum and Carry can be re-expressed in terms of **generate/propagate**:

*   **Carry Generate (Gi) = Ai ⋅ Bi**
    *   A carry is generated when both Ai and Bi are 1.
*   **Carry Propagate (Pi) = Ai ⊕ Bi**
    *   A carry-in will be propagated to the carry-out.

The equations become:
*   **Si = Pi ⊕ Ci**
*   **Ci+1 = Gi + Pi ⋅ Ci**

---

## Carry Lookahead Logic (Expanded)

We can re-express the carry logic to depend only on the inputs (A, B) and the initial carry `C0`.

*   `C1 = G0 + P0⋅C0`
*   `C2 = G1 + P1⋅C1 = G1 + P1⋅G0 + P1⋅P0⋅C0`
*   `C3 = G2 + P2⋅C2 = G2 + P2⋅G1 + P2⋅P1⋅G0 + P2⋅P1⋅P0⋅C0`
*   `C4 = G3 + P3⋅C3 = G3 + P3⋅G2 + P3⋅P2⋅G1 + P3⋅P2⋅P1⋅G0 + P3⋅P2⋅P1⋅P0⋅C0`

Each of these carry equations can be implemented in a two-level logic network.

---

## Cascaded Carry Lookahead

*   We can build larger adders (e.g., 16-bit) using smaller carry-lookahead adders (e.g., 4-bit).
*   A second-level carry lookahead unit takes the `P` (propagate) and `G` (generate) signals from each 4-bit block to quickly compute the carries between the blocks.
*   This extends the lookahead principle to a larger number of bits.

---

## Delay Analysis of Carry Lookahead

*   Consider a 16-bit adder implemented with four stages of 4-bit adders using carry lookahead.
*   Carry-in to the highest stage is available after **5 gate delays**.
*   Sum from the highest stage is available at **8 gate delays**.
*   This is a significant improvement over the **32 gate delays** for a 16-bit ripple-carry adder.

---

## Theory of Multiplication

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

---

## Combinational Multiplier

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

## Floating-Point Numbers (IEEE 754 Single Precision)

A 32-bit format for floating-point values.

*   **Sign (S):** 1 bit (0 for positive, 1 for negative).
*   **Exponent (E):** 8 bits (excess-127 format).
    *   True exponent = E - 127.
*   **Mantissa (M):** 23 bits.

**Value = (-1)^S × (1.M) × 2^(E-127)**

The standard calls for a normalized mantissa, where the most significant bit is always 1. This "hidden bit" is not stored, providing an extra bit of precision.

---

## Floating-Point Example

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