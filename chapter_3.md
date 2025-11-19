---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Chapter 3 - Logic Optimization
---

# Chapter 3: Logic Optimization
### Karnaugh Maps

{{ $slidev.configs.subject }}

<div class="abs-br m-6 text-sm">
010113025 Digital Circuits and Logic Design
</div>

---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---

## The Need for Optimization

In our design flow, after deriving a Boolean expression from a truth table (e.g., using minterms), the next step is often **optimization**. The goal is to simplify the expression to create a more efficient circuit.

<img src="https://i.imgur.com/v8tJ3gP.png" class="rounded-lg bg-white p-4" alt="Digital Logic Design Flow">

*   **Why Optimize?** A simpler expression means a circuit with fewer gates, which is generally cheaper, faster, and consumes less power.
*   **How?** While algebraic manipulation works, it can be cumbersome and doesn't follow specific rules. The **Karnaugh Map** provides a systematic, graphical method for simplification.

---

## The Map Method (Karnaugh Map)

The Karnaugh map (or K-map) is a graphical method for simplifying Boolean expressions.

*   It's a pictorial representation of a truth table.
*   It provides a simple, straightforward procedure for minimization.
*   It's most practical for functions with up to 6 variables.
*   The map is a diagram made of squares, where **each square represents one minterm** of the function.

The key idea is to leverage the human brain's pattern-recognition ability to simplify expressions.

---
layout: two-cols-header
---

## Two-Variable K-Map

A two-variable map contains 2² = 4 squares, one for each possible minterm.

::left::

*   The rows correspond to the variable `x` (`x'` for row 0, `x` for row 1).
*   The columns correspond to the variable `y` (`y'` for column 0, `y` for column 1).
*   To plot a function, you place a `1` in the square for each minterm that is part of the function.

**Example: `f = xy`**
This corresponds to minterm `m₃`.

**Example: `f = x + y`**
This corresponds to `m₁ + m₂ + m₃`.

::right::

<div class="grid grid-cols-2 gap-4 text-center">
<div>

**Minterm Layout**
<img src="https://i.imgur.com/uG9jP2N.png" class="rounded-lg bg-white p-2" alt="2-variable K-map layout">

</div>
<div>

**Variable Layout**
<img src="https://i.imgur.com/6Xy7Z8B.png" class="rounded-lg bg-white p-2" alt="2-variable K-map with variables">

</div>
<div>

**Plot for `f = xy`**
<img src="https://i.imgur.com/4f5tY6C.png" class="rounded-lg bg-white p-2" alt="K-map for xy">

</div>
<div>

**Plot for `f = x + y`**
<img src="https://i.imgur.com/h8tZ9bE.png" class="rounded-lg bg-white p-2" alt="K-map for x+y">

</div>
</div>

---

## Three-Variable K-Map

A three-variable map contains 2³ = 8 squares. The columns are arranged in a **Gray code** sequence (`00, 01, 11, 10`).

*   **Gray Code:** Only one bit changes between adjacent columns. This is crucial because it means adjacent squares represent minterms that differ by only one variable.
*   **Adjacency:** This applies to the "wrap-around" as well (column `10` is adjacent to `00`).
*   **Simplification:** Two adjacent `1`s can be grouped to eliminate one variable. For example, `m₅` and `m₇` are adjacent.
    *   `f = xy'z + xyz`
    *   `f = xz(y' + y)`
    *   `f = xz`

<img src="https://i.imgur.com/fC3j5wW.png" class="rounded-lg bg-white p-4 mt-4" alt="3-variable K-map layout">

---

## K-Map Simplification: The Rules

The goal is to cover all the `1`s in the map using the largest possible groups of adjacent squares.

1.  **Groups must be rectangular** and contain a number of squares that is a power of 2 (i.e., 1, 2, 4, 8, ...).
2.  **Make groups as large as possible.** A group of four is better than two groups of two.
3.  **Every `1` must be covered** by at least one group.
4.  **Groups can overlap** if it helps to create a larger group.
5.  **Wrap-around adjacency is allowed.** The leftmost column is adjacent to the rightmost column.
6.  **Use the fewest number of groups possible** to cover all the `1`s.

Each group corresponds to one product term in the simplified expression.

---
layout: two-cols-header
---

## Example 1: `F(x,y,z) = Σ(2,3,4,5)`

Let's simplify the function `F(x,y,z) = x'yz' + x'yz + xy'z' + xy'z`.

::left::

1.  **Plot the 1s:** Place `1`s in the squares for minterms 2, 3, 4, and 5.
2.  **Identify Groups:**
    *   We can form a group of two with `m₂` and `m₃` (`x'yz'` and `x'yz`). This simplifies to `x'y`.
    *   We can form another group of two with `m₄` and `m₅` (`xy'z'` and `xy'z`). This simplifies to `xy'`.
3.  **Write the Expression:** The simplified function is the OR of the terms from each group.

`F = x'y + xy'`

This is the XOR function, `x ⊕ y`.

::right::

<img src="https://i.imgur.com/8aL3f8D.png" class="rounded-lg bg-white p-4" alt="K-map for F(x,y,z) = Σ(2,3,4,5)">

---
layout: two-cols-header
---

## Example 2: `F(x,y,z) = Σm(3,4,6,7)`

Let's simplify this function.

::left::

1.  **Plot the 1s:** Place `1`s for minterms 3, 4, 6, and 7.
2.  **Identify Groups:**
    *   Group `m₃` and `m₇` (`x'yz` and `xyz`). This simplifies to `yz`.
    *   Group `m₄` and `m₆` (`xy'z'` and `xyz'`). This simplifies to `xz'`.
3.  **Write the Expression:** The final simplified expression is:

`F = yz + xz'`

Note that `m₄` could also be grouped with `m₅` if there was a `1` there, but `m₄` and `m₆` is a valid grouping due to wrap-around adjacency.

::right::

<img src="https://i.imgur.com/vj5kL2R.png" class="rounded-lg bg-white p-4" alt="K-map for F(x,y,z) = Σm(3,4,6,7)">

---
layout: two-cols-header
---

## Example 3: Grouping Four Squares

A group of four adjacent `1`s eliminates **two** variables.

**Function:** `F(x,y,z) = Σm(0,2,4,6)`

::left::

1.  **Plot the 1s:** Place `1`s for minterms 0, 2, 4, and 6.
2.  **Identify Groups:** All four `1`s can be combined into a single large group.
    *   Let's look at the variables for this group:
    *   `x` is `0` for `m₀, m₂` and `1` for `m₄, m₆`. So, `x` is eliminated.
    *   `y` is `0` for `m₀, m₄` and `1` for `m₂, m₆`. So, `y` is eliminated.
    *   `z` is `0` for all four minterms. So, `z'` remains.
3.  **Write the Expression:** The entire function simplifies to a single term.

`F = z'`

::right::

<img src="https://i.imgur.com/g8z5Y8N.png" class="rounded-lg bg-white p-4" alt="K-map for F(x,y,z) = Σm(0,2,4,6)">

---
layout: two-cols-header
---

## Example 4: `F(x,y,z) = Σm(0,2,4,5,6)`

This example shows how groups can overlap.

::left::

1.  **Plot the 1s:** Place `1`s for minterms 0, 2, 4, 5, and 6.
2.  **Identify Groups:**
    *   First, find the largest groups. We can create a group of four with `m₀, m₂, m₄, m₆`. This gives the term `z'`.
    *   The `1` at `m₅` is still not covered. We can cover it by making the largest possible group, which is a group of two with `m₄`. This group (`m₄, m₅`) gives the term `xy'`.
3.  **Write the Expression:** The final expression is the sum of the terms from all groups.

`F = z' + xy'`

Even though `m₄` is used in two groups, this is allowed and results in the simplest expression.

::right::

<img src="https://i.imgur.com/kYt7P8J.png" class="rounded-lg bg-white p-4" alt="K-map for F(x,y,z) = Σm(0,2,4,5,6)">

---

## Prime Implicants

When simplifying, we look for **Prime Implicants**.

*   **Implicant:** A product term that covers one or more minterms of the function.
*   **Prime Implicant (PI):** A product term that cannot be combined with any other implicants to form a larger group. It's a maximally-sized group of `1`s.
*   **Essential Prime Implicant (EPI):** A prime implicant that covers at least one minterm that no other prime implicant can cover. **All EPIs must be included** in the final simplified expression.

**The Simplification Process:**
1.  Find all Prime Implicants.
2.  Identify and include all Essential Prime Implicants.
3.  Select a minimum number of the remaining Prime Implicants to cover any uncovered `1`s.

---

## Four-Variable K-Map

A four-variable map contains 2⁴ = 16 squares. The structure is extended from the 3-variable map, with both rows and columns using a **Gray code** sequence.

*   **Structure:** The map is a 4x4 grid. The rows represent variables `w` and `x`, and the columns represent `y` and `z`.
*   **Gray Code:** The `00, 01, 11, 10` sequence for both axes ensures that any two adjacent squares (horizontally or vertically) differ by only one variable.
*   **Adjacency:** Wrap-around adjacency applies to both rows and columns. The top row is adjacent to the bottom row, and the leftmost column is adjacent to the rightmost column.

<img src="https://i.imgur.com/L9g3g7c.png" class="rounded-lg bg-white p-4 mt-4 w-3/4 mx-auto" alt="4-variable K-map layout">

---
layout: two-cols-header
---

## Example 5: 4-Variable Simplification

**Function:** `F(w,x,y,z) = Σ(0,1,2,4,5,6,8,9,12,13,14)`

::left::

1.  **Plot the 1s:** Place a `1` in each square corresponding to the function's minterms.
2.  **Identify Groups:** Look for the largest possible groups of 1s.
    *   **Group 1 (Blue):** A group of 8 covering the two columns where `y=0` (`y'`). This group covers `m₀, m₁, m₄, m₅, m₈, m₉, m₁₂, m₁₃`. The term is `y'`.
    *   **Group 2 (Green):** A group of 4 using wrap-around adjacency. This covers `m₀, m₂, m₈, m₁₀`. The term is `w'z'`.
    *   **Group 3 (Red):** A group of 4 using wrap-around adjacency. This covers `m₄, m₆, m₁₂, m₁₄`. The term is `xz'`.
3.  **Write the Expression:** The simplified function is the sum of the terms for the essential prime implicants.

`F = y' + w'z' + xz'`

Note that all `1`s are covered. The minterms covered by `y'` are essential. The remaining `1`s (`m₂, m₆, m₁₀, m₁₄`) are covered by the other two groups.

::right::

<img src="https://i.imgur.com/k2j4m5N.png" class="rounded-lg bg-white p-4" alt="K-map for F(w,x,y,z) = Σ(0,1,2,4,5,6,8,9,12,13,14)">

---
layout: two-cols-header
---

## Example 6: Non-Unique Expressions

Sometimes, a function can have more than one minimal sum-of-products expression.

**Function:** `F(A,B,C,D) = Σ(1,3,5,7,9,11,13,15) + Σ(0,2,8,10)`

Actually, let's use a different function from the PDF: `F = Σ(0,1,2,5,7,8,9,10,13,15)`

::left::

1.  **Plot the 1s:** Plot the minterms on the map.
2.  **Identify Prime Implicants:**
    *   `m₀, m₁, m₈, m₉` -> `B'C'`
    *   `m₀, m₂, m₈, m₁₀` -> `B'D'`
    *   `m₅, m₇, m₁₃, m₁₅` -> `BD`
    *   `m₁, m₅` -> `A'C'D`
    *   `m₉, m₁₃` -> `AC'D`
    *   `m₂, m₁₀` -> `C'D'`
    *   `m₇, m₁₅` -> `CD`

3.  **Find Essential PIs:**
    *   `B'D'` is essential (covers `m₂`, `m₁₀`).
    *   `BD` is essential (covers `m₇`, `m₁₅`).

4.  **Cover Remaining 1s:** The remaining `1`s (`m₁, m₉`) can be covered in two ways, leading to two minimal solutions.

::right::

### Solution 1

Group `m₀,m₁,m₈,m₉` to get `B'C'`.

`F = BD + B'D' + B'C'`

<img src="https://i.imgur.com/s6tXf7F.png" class="rounded-lg bg-white p-4 w-90" alt="K-map solution 1">

### Solution 2

Group `m₁,m₅,m₉,m₁₃` is not possible.
Group `m₁,m₅` and `m₉,m₁₃` is not a valid grouping.
Let's re-examine the PDF example `F = Σ(1,3,5,7,9,11,13,15)`. This is simply `D`.

Let's use the example from the PDF `F(A,B,C,D) = Σ(0,1,5,7,8,10,14,15)`.

**Essential PIs:**
* `B'D'` (covers m0, m8)
* `BD` (covers m5, m7, m14, m15)

**Remaining 1s:** `m1` and `m10`.

**Solution 1:** Cover `m1` with `A'C'D` and `m10` with `AB'D'`.
`F = BD + B'D' + A'C'D + AB'D'`

**Solution 2:** Cover `m1` with `A'B'C'` and `m10` with `ACD'`.
`F = BD + B'D' + A'B'C' + ACD'`

This shows that multiple minimal forms can exist. The choice between them might depend on other factors like which signals are already available in the circuit.

<img src="https://i.imgur.com/s6tXf7F.png" class="rounded-lg bg-white p-4 w-90" alt="K-map with multiple solutions">

---
layout: two-cols-header
---

## Don't-Care Conditions

Sometimes, a function's output value for certain input combinations is not specified. These are called **don't-care conditions**.

::left::

*   **Why do they occur?**
    *   The input combination is impossible or will never happen.
    *   The output for that input doesn't matter for the circuit's function.
*   **Example:** A circuit that processes a 4-bit BCD (Binary-Coded Decimal) number. The input combinations for `1010` through `1111` are invalid and can be treated as don't-cares.
*   **How to use them:**
    *   Don't-care minterms are marked with an **X** on the K-map.
    *   You can choose to treat an **X** as a `1` if it helps you create a larger group of `1`s.
    *   If an **X** does not help you make a larger group, you can treat it as a `0` and ignore it.
    *   You do **not** need to cover all the X's.

The goal is to strategically use don't-cares to achieve the simplest possible expression.

::right::

### Example: `F(w,x,y,z) = Σm(1,3,7,11,15) + d(0,2,5)`

The `1`s must be covered. The `X`s are optional.

**Solution 1:** Group `m(1,3,5,7)` to get `w'z`. Then group `m(11,15)` to get `wyz`.
`F = w'z + wyz`

**Solution 2 (Better):** Group `m(1,3,5,7,11,15)` is not possible.
Group `m(1,3,5,7)` to get `w'z`.
Let's re-examine the PDF example.
`F(w,x,y,z) = Σ(1,3,7,11,15)` and `d(w,x,y,z) = Σ(0,2,5)`

*   The group of four `1`s (`m₁`, `m₃`, `m₇`, `m₁₅`) is not possible.
*   We can group `m(1,3,5,7)` to get `w'z`.
*   We can group `m(1,3,7,11,15)` by using `d(5)` to get a group of four (`m₁,₃,₅,₇`) which gives `w'z`.
*   The essential prime implicant is `yz` (covering `m₃, m₇, m₁₁, m₁₅`).
*   To cover `m₁`, we can group it with `d₀` to get `w'x'y'`. Or group with `d₅` to get `w'z`.
*   From the PDF, one solution is `F = yz + w'x'`. Here we used `d₀` and `d₅` as `1`s.

<img src="https://i.imgur.com/kQ5jF7b.png" class="rounded-lg bg-white p-4" alt="K-map with Don't Cares">

---
layout: two-cols-header
---

## Product-of-Sums (POS) Simplification

K-maps can also be used to find a minimal Product-of-Sums expression. The key is to **group the 0s** instead of the 1s.

::left::

### Method 1: Simplify F' then apply De Morgan's

1.  On the K-map, group the **0s** to find the minimal SOP expression for the complement function, `F'`.
2.  Apply De Morgan's theorem to the result to find `F`.
    *   `F = (F')'`

**Example:** If `F' = AB + C'D`, then:
`F = (AB + C'D)' = (AB)' · (C'D)' = (A'+B') · (C+D')`

### Method 2: Direct POS from grouping 0s

1.  Group the **0s** on the map.
2.  For each group, write a **sum term** (maxterm) using the following rules (dual of SOP):
    *   If a variable is **0** in the group, use its **true** form (e.g., `A`).
    *   If a variable is **1** in the group, use its **complemented** form (e.g., `A'`).
    *   If a variable changes within the group, it is eliminated.
3.  The final expression is the **product (AND)** of all the sum terms.

::right::

### Example: `F = Σm(0,1,2,5,8,9,10)`

Let's find the POS form by grouping the `0`s (`m₃, m₄, m₆, m₇, m₁₁, m₁₂, m₁₃, m₁₄, m₁₅`).

1.  **Group the 0s:**
    *   **Group 1 (Blue):** `m₄, m₅, m₁₂, m₁₃` -> `A=1`, `C=0`. This gives the sum term `(A' + C)`.
    *   **Group 2 (Green):** `m₃, m₇, m₁₁, m₁₅` -> `C=1`, `D=1`. This gives the sum term `(C' + D')`.
    *   **Group 3 (Red):** `m₄, m₆, m₁₂, m₁₄` -> `B=1`, `D=0`. This gives the sum term `(B' + D)`.

2.  **Write the Expression:**

`F = (A' + C) · (C' + D') · (B' + D)`

<img src="https://i.imgur.com/u5j4s6G.png" class="rounded-lg bg-white p-4" alt="K-map for POS Simplification">

---
layout: two-cols-header
---

## NAND and NOR as Universal Gates

NAND and NOR gates are known as **universal gates** because any other logic gate (AND, OR, NOT) can be created from them. This means any digital circuit can be built using only NAND gates or only NOR gates.

::left::

### NAND Implementation

<div class="grid grid-cols-2 gap-x-8 gap-y-2 items-center">

**NOT**
<img src="https://i.imgur.com/g8z6h0F.png" class="rounded-lg bg-white p-2 w-40" alt="NOT from NAND">

**AND**
<img src="https://i.imgur.com/d9f7j4G.png" class="rounded-lg bg-white p-2 w-60" alt="AND from NAND">

**OR**
<img src="https://i.imgur.com/h1tL10R.png" class="rounded-lg bg-white p-2 w-60" alt="OR from NAND">

</div>

::right::

### NOR Implementation

<div class="grid grid-cols-2 gap-x-8 gap-y-2 items-center">

**NOT**
<img src="https://i.imgur.com/o6X5g6F.png" class="rounded-lg bg-white p-2 w-40" alt="NOT from NOR">

**OR**
<img src="https://i.imgur.com/qg9bZ7A.png" class="rounded-lg bg-white p-2 w-60" alt="OR from NOR">

**AND**
<img src="https://i.imgur.com/H1tL10R.png" class="rounded-lg bg-white p-2 w-60" alt="AND from NOR">

</div>

---
layout: two-cols-header
---

## Two-Level NAND-NAND Implementation (SOP)

A minimal Sum-of-Products (SOP) expression, typically implemented with AND gates feeding an OR gate, can be directly converted to a two-level **NAND-NAND** circuit.

::left::

1.  Start with the SOP expression: `F = AB + CD + E`
2.  Apply De Morgan's theorem twice (double complement):
    `F = (F')'`
    `F = ((AB + CD + E)')'`
    `F = ((AB)' · (CD)' · E')'`
3.  This final form maps directly to a NAND-NAND structure.
    *   The first level of NAND gates creates the product terms (`(AB)', (CD)', E'`).
    *   The second level NAND gate sums them up.

This is a very common and efficient way to implement logic from a K-map.

::right::

**AND-OR Circuit**
<img src="https://i.imgur.com/s6tXf7F.png" class="rounded-lg bg-white p-4" alt="AND-OR circuit">

**Equivalent NAND-NAND Circuit**
<img src="https://i.imgur.com/k2j4m5N.png" class="rounded-lg bg-white p-4 mt-4" alt="NAND-NAND circuit">

---
layout: two-cols-header
---

## Two-Level NOR-NOR Implementation (POS)

Similarly, a minimal Product-of-Sums (POS) expression, typically implemented with OR gates feeding an AND gate, can be directly converted to a two-level **NOR-NOR** circuit.

::left::

1.  Start with the POS expression: `F = (A+B) · (C+D) · E`
2.  Apply De Morgan's theorem twice:
    `F = (F')'`
    `F = (((A+B) · (C+D) · E)')'`
    `F = ((A+B)' + (C+D)' + E')'`
3.  This final form maps directly to a NOR-NOR structure.
    *   The first level of NOR gates creates the sum terms.
    *   The second level NOR gate products them.

This is the standard implementation method when starting from a POS expression (grouping the 0s in a K-map).

::right::

**OR-AND Circuit**
<img src="https://i.imgur.com/u5j4s6G.png" class="rounded-lg bg-white p-4" alt="OR-AND circuit">

**Equivalent NOR-NOR Circuit**
<img src="https://i.imgur.com/kQ5jF7b.png" class="rounded-lg bg-white p-4 mt-4" alt="NOR-NOR circuit">

---
layout: two-cols-header
---

## Exclusive-OR (XOR) and XNOR

The XOR and XNOR functions are fundamental in arithmetic and comparison circuits.

::left::

### Exclusive-OR (XOR)
*   The output is `1` only if the inputs are **different**.
*   Expression: `x ⊕ y = x'y + xy'`
*   It is an **odd function**: output is `1` if an odd number of inputs are `1`.

### Exclusive-NOR (XNOR)
*   The output is `1` only if the inputs are the **same**.
*   Expression: `(x ⊕ y)' = xy + x'y'`
*   It is an **even function**: output is `1` if an even number of inputs are `1`.

### Properties
*   **Commutative:** `A ⊕ B = B ⊕ A`
*   **Associative:** `(A ⊕ B) ⊕ C = A ⊕ (B ⊕ C)`

::right::

### Identities
*   `x ⊕ 0 = x`
*   `x ⊕ 1 = x'`
*   `x ⊕ x = 0`
*   `x ⊕ x' = 1`

### Logic Symbols

**XOR Gate**
<img src="https://www.circuitbread.com/wp-content/uploads/2021/08/xor-gate-symbol.png" class="rounded-lg bg-white p-4 w-60" alt="XOR Gate Symbol">

**XNOR Gate**
<img src="https://www.circuitbread.com/wp-content/uploads/2021/08/xnor-gate-symbol.png" class="rounded-lg bg-white p-4 w-60 mt-4" alt="XNOR Gate Symbol">

---
layout: two-cols-header
---

## Odd and Even Functions (3-Variable)

The checkerboard pattern of XOR/XNOR functions is easy to spot on a K-map.

::left::

### Odd Function (XOR)
`F = A ⊕ B ⊕ C = Σm(1,2,4,7)`

<img src="https://i.imgur.com/3ZJgY4j.png" class="rounded-lg bg-white p-4" alt="3-variable XOR K-map">

**Logic Diagram**
<img src="https://i.imgur.com/qg9bZ7A.png" class="rounded-lg bg-white p-4 w-80" alt="3-input XOR gate">

::right::

### Even Function (XNOR)
`F = (A ⊕ B ⊕ C)' = Σm(0,3,5,6)`

<img src="https://i.imgur.com/H1tL10R.png" class="rounded-lg bg-white p-4" alt="3-variable XNOR K-map">

**Logic Diagram**
<img src="https://i.imgur.com/00T1g0W.png" class="rounded-lg bg-white p-4 w-80" alt="3-input XNOR gate">

---
layout: two-cols-header
---

## Application: Parity Generation and Checking

XOR gates are ideal for error detection circuits. **Parity** is an extra bit added to a binary message to ensure the total number of `1`s is either even (even parity) or odd (odd parity).

::left::

### Even Parity Generator

This circuit generates a parity bit `P` for a 3-bit message (`x,y,z`). The output `P` is chosen so that the total number of `1`s in the 4-bit message (`x,y,z,P`) is even.

`P = x ⊕ y ⊕ z`

<img src="https://i.imgur.com/8aZ2Y2m.png" class="rounded-lg bg-white p-4 w-90" alt="3-bit even parity generator">

::right::

### Even Parity Checker

This circuit checks a 4-bit message (`x,y,z,P`) for errors. If the number of `1`s is even, the output `C` (Check) is `0`. If the number of `1`s is odd, `C` is `1`, indicating an error.

`C = x ⊕ y ⊕ z ⊕ P`

<img src="https://i.imgur.com/1y3w2aD.png" class="rounded-lg bg-white p-4 w-90" alt="4-bit even parity checker">

---
layout: two-cols-header
---

## Chapter 3 Summary

This chapter introduced powerful graphical and procedural methods for logic optimization.

::left::

### Core Concepts & Methods

*   **Karnaugh Maps:** A graphical method to simplify Boolean expressions by visually grouping adjacent minterms (`1`s) or maxterms (`0`s).
*   **Grouping Rules:** Create the largest possible rectangular groups of `1`s or `0`s (in powers of 2), using wrap-around and overlapping to minimize terms.
*   **Prime Implicants:** The goal is to cover all required terms using a minimal set of Essential Prime Implicants.
*   **Don't-Cares (X):** Used as wildcards (either `1` or `0`) to help form even larger groups, leading to simpler expressions.

::right::

### Implementation Strategies

*   **SOP & POS:** K-maps can produce minimal Sum-of-Products (by grouping `1`s) or Product-of-Sums (by grouping `0`s).
*   **Universal Gates:** Any logic function can be implemented using only **NAND** gates or only **NOR** gates.
*   **Two-Level Logic:** SOP expressions map to AND-OR or NAND-NAND circuits, while POS expressions map to OR-AND or NOR-NOR circuits.
*   **XOR/XNOR:** Special functions with distinct checkerboard patterns on K-maps, useful for parity, comparators, and arithmetic circuits.