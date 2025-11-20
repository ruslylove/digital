---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 2 - Logic Circuits
---

# Lecture 2: Logic Circuits

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
layout: two-cols
---

## Logic Circuits

*   **Logic circuits** perform operations on digital signals.
*   They are implemented as electronic circuits where signal values are restricted to a few discrete values.
*   In **binary logic circuits**, there are only two values: **0** and **1**.
*   The general form of a logic circuit is a **switching network**, which takes a set of discrete inputs and produces a set of discrete outputs.

::right::

<img src="https://i.imgur.com/3ZJgY4j.png" class="rounded-lg bg-white p-4" alt="Switching Network Diagram">
<p class="text-sm text-center mt-2">A switching network with 'm' inputs and 'n' outputs.</p>

---
layout: two-cols-header
---

## The Fathers of Information Theory

The theoretical foundation of all modern digital computing was laid by George Boole and Claude Shannon.

::left::

### George Boole (1815-1864)

<img src="https://upload.wikimedia.org/wikipedia/commons/c/ce/George_Boole_color.jpg" class="rounded-lg w-40" alt="George Boole">

*   Developed **Boolean algebra** in the mid-1800s.
*   His intent was not to build circuits, but to create an algebraic system to formalize human logic and thought.

::right::

### Claude Shannon (1916-2001)

<img src="https://www.discovermagazine.com/~/media/Images/Issues/2017/May/shannon.jpg" class="rounded-lg w-40" alt="Claude Shannon">

*   In his 1938 Master's thesis, he showed how Boolean algebra could be applied to switch-based circuits.
*   He demonstrated that an "on" switch could be treated as `1` (true) and an "off" switch as `0` (false).
*   This insight proved that **we can build digital circuits by doing math**.

---

## Boolean Algebra

*   Provides the mathematical foundation for designing and analyzing digital logic circuits.
*   It's a 2-valued algebra that works with devices that have two states (e.g., on/off, high/low).
*   We use **Boolean variables** (like `A`, `B`, `x`, `y`) to represent the inputs and outputs of a circuit.
*   A variable can only take one of two values: **0** or **1**.
*   These symbols represent the two possible states of the variable, not numerical values. They commonly refer to low or high voltage levels in a circuit.

---
layout: two-cols-header
---

## Switches to Logic Functions

The simplest binary element is a switch. We can combine switches to create basic logic functions.

::left::

### AND Function (Series)
The light `L` is ON (`1`) only if **both** switch `x1` AND switch `x2` are closed (`1`).

`L(x1, x2) = x1 · x2`

<img src="https://i.imgur.com/H1tL10R.png" class="rounded-lg bg-white p-4 mt-4" alt="AND function with series switches">

::right::

### OR Function (Parallel)
The light `L` is ON (`1`) if switch `x1` OR switch `x2` (or both) are closed (`1`).

`L(x1, x2) = x1 + x2`

<img src="https://i.imgur.com/qg9bZ7A.png" class="rounded-lg bg-white p-4 mt-4" alt="OR function with parallel switches">

---
layout: two-cols-header
---

## The NOT Function (Inversion)

What if we want an action to occur when a switch is *opened* instead of closed? This is called inversion or the NOT function.

::left::

*   The output `L` is the **inverse** (or complement) of the input `x`.
*   If `x = 0` (open), then `L = 1` (on).
*   If `x = 1` (closed), then `L = 0` (off).
*   This is written as `L(x) = x'` or `L(x) = ¬x`.
*   The circuit on the right implements a logical NOT function. When the switch `S` is open (`x=0`), current flows through the resistor `R` to the light `L`. When `S` is closed (`x=1`), it creates a short circuit to ground, diverting current away from `L`.

::right::

<img src="https://i.imgur.com/00T1g0W.png" class="rounded-lg bg-white p-4" alt="NOT function with a switch">

---

## Truth Tables

A **truth table** is a tabular listing that fully describes a logic function by showing the output value for all possible input combinations.

<div class="grid grid-cols-3 gap-8 text-center">
<div>

### AND

| x1 | x2 | x1·x2 |
|:--:|:--:|:-----:|
| 0  | 0  |   0   |
| 0  | 1  |   0   |
| 1  | 0  |   0   |
| 1  | 1  |   1   |

</div>
<div>

### OR

| x1 | x2 | x1+x2 |
|:--:|:--:|:-----:|
| 0  | 0  |   0   |
| 0  | 1  |   1   |
| 1  | 0  |   1   |
| 1  | 1  |   1   |

</div>
<div>

### NOT

| x1 | x1' |
|:--:|:---:|
| 0  |  1  |
| 1  |  0  |

</div>
</div>

---
layout: two-cols-header
---

## Logic Gates and Networks

Each basic logic operation (AND, OR, NOT) is implemented by a physical circuit element called a **logic gate**.

::left::

*   A logic gate has one or more inputs and a single output.
*   Larger, more complex circuits are built by connecting multiple gates together into a **logic network**.
*   The diagram shows how the Boolean expression `f = (x1 + x2) · x3` is implemented as a network of an OR gate and an AND gate.

::right::

<img src="https://i.imgur.com/8aZ2Y2m.png" class="rounded-lg bg-white p-4" alt="Logic Network Diagram">

---

## Basic Logic Gates

These are the standard symbols for the fundamental logic gates.

<div class="grid grid-cols-3 gap-8 text-center">
<div>

### AND Gate
<img src="https://i.imgur.com/1y3w2aD.png" class="rounded-lg bg-white p-4" alt="AND Gate Symbol">

</div>
<div>

### OR Gate
<img src="https://i.imgur.com/qL3b5iE.png" class="rounded-lg bg-white p-4" alt="OR Gate Symbol">

</div>
<div>

### NOT Gate (Inverter)
<img src="https://i.imgur.com/o6X5g6F.png" class="rounded-lg bg-white p-4" alt="NOT Gate Symbol">

</div>
</div>

---
layout: two-cols-header
---

## Boolean Algebra: Axioms & Theorems

Boolean algebra is based on a set of axioms (basic assumptions) from which we can derive many useful theorems.

::left::

### Axioms

*   `0 · 0 = 0`
*   `1 + 1 = 1`
*   `1 · 1 = 1`
*   `0 + 0 = 0`
*   `0 · 1 = 1 · 0 = 0`
*   `1 + 0 = 0 + 1 = 1`
*   If `x = 0`, then `x' = 1`
*   If `x = 1`, then `x' = 0`

::right::

### Single-Variable Theorems

*   `x · 0 = 0`
*   `x + 1 = 1`
*   `x · 1 = x`
*   `x + 0 = x`
*   `x · x = x`
*   `x + x = x`
*   `x · x' = 0`
*   `x + x' = 1`
*   `(x')' = x`

---
layout: two-cols-header
---

## Boolean Algebra: Properties

These multi-variable properties are fundamental for manipulating and simplifying Boolean expressions.

::left::

### Commutative
`x · y = y · x`
`x + y = y + x`

### Associative
`x · (y · z) = (x · y) · z`
`x + (y + z) = (x + y) + z`

### Absorption
`x + x · y = x`
`x · (x + y) = x`

::right::

### Distributive
`x · (y + z) = x · y + x · z`
`x + y · z = (x + y) · (x + z)`

### Combining
`x · y + x · y' = x`
`(x + y) · (x + y') = x`

### Consensus
`x·y + y·z + x'·z = x·y + x'·z`
`(x+y)·(y+z)·(x'+z) = (x+y)·(x'+z)`

---

## Duality

The principle of **duality** is a powerful concept in Boolean algebra. Given any true statement (theorem or expression), its dual is also true.

To form the dual of an expression:
1.  Replace all **AND** operators (`·`) with **OR** operators (`+`).
2.  Replace all **OR** operators (`+`) with **AND** operators (`·`).
3.  Replace all **0s** with **1s**.
4.  Replace all **1s** with **0s**.

<br>

**Example:**

The expression: `x + 0 = x`

Its dual is: `x · 1 = x`

Notice how the theorems on the previous slides are often listed in dual pairs.

---
layout: two-cols-header
---

## De Morgan's Theorem

De Morgan's theorem provides a way to find the complement of a complex expression. It's essential for simplifying circuits and converting between Sum-of-Products and Product-of-Sums forms.

::left::

### Theorem

1.  `(x · y)' = x' + y'`
    *   The complement of a product is the sum of the complements.

2.  `(x + y)' = x' · y'`
    *   The complement of a sum is the product of the complements.

### Proof by Truth Table for `(x · y)' = x' + y'`

| x | y | x·y | **(x·y)'** | x' | y' | **x'+y'** |
|:-:|:-:|:---:|:----------:|:--:|:--:|:-------:|
| 0 | 0 |  0  |     **1**      | 1  | 1  |   **1**   |
| 0 | 1 |  0  |     **1**      | 1  | 0  |   **1**   |
| 1 | 0 |  0  |     **1**      | 0  | 1  |   **1**   |
| 1 | 1 |  1  |     **0**      | 0  | 0  |   **0**   |

::right::

### Venn Diagram Visualization

De Morgan's law can be visualized using Venn diagrams. The shaded area represents the result of the expression.

**`(x + y)'`** (Everything outside of X and Y)
<img src="https://i.imgur.com/gK96e7g.png" class="rounded-lg bg-white p-2 w-60" alt="Venn Diagram for (x+y)'">

**`x' · y'`** (The intersection of "not X" and "not Y")
<img src="https://i.imgur.com/2Xy1W1G.png" class="rounded-lg bg-white p-2 w-60" alt="Venn Diagram for x'y'">

The resulting area is identical, proving the equivalence.

---

## Logic Synthesis

**Logic synthesis** is the process of generating a logic circuit from a desired functional behavior, often described by a truth table or Boolean expression.

*   **Goal:** Create a circuit that correctly implements the function.
*   **Secondary Goal:** Optimize the circuit to be simpler, faster, smaller, or use less power.
*   We can synthesize a function by focusing on either the rows where the output is `1` or the rows where the output is `0`.

This leads to two standard forms:
1.  **Sum-of-Products (SOP)**
2.  **Product-of-Sums (POS)**

---
layout: two-cols-header
---

## Sum-of-Products (SOP) using Minterms

A **minterm** is a product (AND) term that includes every input variable, either in its true or complemented form. Each minterm corresponds to a single row in a truth table where the output is `1`.

::left::

### Synthesis Steps
1.  Identify all rows in the truth table where the function's output `f` is **1**.
2.  For each of these rows, write a **minterm** product term. A variable is complemented if its value in the row is `0`, and true if its value is `1`.
3.  The final expression is the **sum (OR)** of all the minterms.

This is also known as the **canonical sum-of-products** form.

::right::

### Example

| a | b | c | f | Minterm |
|:-:|:-:|:-:|:-:|:--------|
| 0 | 0 | 0 | 0 |         |
| 0 | 0 | 1 | **1** | a'b'c   |
| 0 | 1 | 0 | 0 |         |
| 0 | 1 | 1 | **1** | a'bc    |
| 1 | 0 | 0 | 0 |         |
| 1 | 0 | 1 | **1** | ab'c    |
| 1 | 1 | 0 | 0 |         |
| 1 | 1 | 1 | **1** | abc     |

`f(a,b,c) = a'b'c + a'bc + ab'c + abc`

This can also be written using 'm' notation:
`f(a,b,c) = m₁ + m₃ + m₅ + m₇ = Σm(1,3,5,7)`

---
layout: two-cols-header
---

## Product-of-Sums (POS) using Maxterms

A **maxterm** is a sum (OR) term that includes every input variable, either in its true or complemented form. Each maxterm corresponds to a single row in a truth table where the output is `0`.

::left::

### Synthesis Steps
1.  Identify all rows in the truth table where the function's output `f` is **0**.
2.  For each of these rows, write a **maxterm** sum term. A variable is true if its value in the row is `0`, and complemented if its value is `1`. (This is the opposite of minterms).
3.  The final expression is the **product (AND)** of all the maxterms.

This is also known as the **canonical product-of-sums** form.

::right::

### Example

| a | b | c | f | Maxterm |
|:-:|:-:|:-:|:-:|:--------|
| 0 | 0 | 0 | **0** | a+b+c   |
| 0 | 0 | 1 | 1 |         |
| 0 | 1 | 0 | **0** | a+b'+c  |
| 0 | 1 | 1 | 1 |         |
| 1 | 0 | 0 | **0** | a'+b+c  |
| 1 | 0 | 1 | 1 |         |
| 1 | 1 | 0 | **0** | a'+b'+c |
| 1 | 1 | 1 | 1 |         |

`f(a,b,c) = (a+b+c)·(a+b'+c)·(a'+b+c)·(a'+b'+c)`

This can also be written using 'M' notation:
`f(a,b,c) = M₀ · M₂ · M₄ · M₆ = ΠM(0,2,4,6)`

---
layout: two-cols-header
---

## Minimality and Simplification

A function in its canonical Sum-of-Products form may not be minimal. It's often possible to simplify the expression, which leads to a simpler, cheaper, and faster circuit.

::left::

### Example

Consider the function represented by the truth table.

**Canonical SOP:**
`f(a,b) = a'b' + a'b + ab`

**Simplification:**
1. `f = a'(b' + b) + ab`
2. `f = a'(1) + ab`
3. `f = a' + ab`
4. `f = (a' + a)(a' + b)`
5. `f = 1 · (a' + b)`
6. `f = a' + b`

The simplified form `a' + b` requires far fewer gates.

::right::

### Truth Table & Circuits

| a | b | f |
|:-:|:-:|:-:|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

**Original Circuit for `a'b' + a'b + ab`**
<img src="https://i.imgur.com/u0j8fXF.png" class="rounded-lg bg-white p-2 w-80" alt="Complex circuit for unsimplified function">

**Simplified Circuit for `a' + b`**
<img src="https://i.imgur.com/v8tY3aG.png" class="rounded-lg bg-white p-2 w-40 mt-4" alt="Simple circuit for simplified function">

---
layout: two-cols-header
---

## Design Example: Three-Way Light Control

**Problem:** A room has three doors, each with a switch (x, y, z) to control a single light. The light should toggle its state whenever any switch is flipped. Assume the light is OFF when all switches are open (0).

*   Light is ON if **one** switch is closed.
*   Light is OFF if **two** switches are closed.
*   Light is ON if **three** switches are closed.

::left::

### Truth Table

| x | y | z | f |
|:-:|:-:|:-:|:-:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | **1** |
| 0 | 1 | 0 | **1** |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | **1** |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | **1** |

### Sum-of-Products

From the truth table, we can write the SOP expression:

`f = x'y'z + x'yz' + xy'z' + xyz`

This is the simplest SOP form for this function (also known as the XOR function).

::right::

### Circuit Implementation

<img src="https://i.imgur.com/t9y2L3c.png" class="rounded-lg bg-white p-4" alt="Circuit for 3-way light control">

---
layout: two-cols-header
---

## Design Example: Multiplexer (MUX)

**Problem:** Design a circuit that chooses between two data inputs, `x` and `y`, based on a control signal `s`. This is a 2-to-1 Multiplexer.

*   If `s = 0`, the output `f` should be equal to `x`.
*   If `s = 1`, the output `f` should be equal to `y`.

::left::

### Truth Table & Expression

| s | x | y | f |
|:-:|:-:|:-:|:-:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | **1** |
| 0 | 1 | 1 | **1** |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | **1** |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | **1** |

**SOP:** `f = s'xy' + s'xy + sx'y + sxy`

**Simplified:**
`f = s'x(y' + y) + sy(x' + x)`
`f = s'x(1) + sy(1)`
`f = s'x + sy`

::right::

### Circuit and Symbol

**Circuit for `f = s'x + sy`**
<img src="https://i.imgur.com/WbZ6g5c.png" class="rounded-lg bg-white p-4 w-80" alt="Circuit for 2-to-1 Multiplexer">

**Graphical Symbol**
<img src="https://i.imgur.com/d7y7g4E.png" class="rounded-lg bg-white p-4 w-48 mt-4" alt="Symbol for 2-to-1 Multiplexer">

---
layout: two-cols-header
---

## Design Example: Car Safety Alarm

**Problem:** Design a car safety alarm `A` that sounds if:
1.  The key is in (`K=1`) and the door is not closed (`D=0`), OR
2.  The door is closed (`D=1`), the key is in (`K=1`), the driver is in the seat (`S=1`), and the seat belt is not closed (`B=0`).

::left::

### Boolean Expression

Translating the conditions into a Boolean expression:

*   Condition 1: `K · D'`
*   Condition 2: `D · K · S · B'`

The final alarm function `A` is the OR of these two conditions:

`A = K·D' + D·K·S·B'`

This can be simplified slightly by factoring out `K`:

`A = K · (D' + D·S·B')`

Using the property `X + X'Y = X + Y`:
Let `X = D'`, then `X' = D`.
`D' + D·S·B' = D' + S·B'`

So, the final simplified expression is:

`A = K · (D' + S·B')`

::right::

### Circuit Implementation

The circuit is built from the simplified expression `A = K · (D' + S·B')`.

<div class="grid grid-cols-2 gap-4">
<div>

<img src="https://i.imgur.com/39wYg7R.png" class="rounded-lg bg-white p-4" alt="Circuit for Car Safety Alarm">

</div>
</div>

This implementation is much simpler than one built directly from the full truth table, demonstrating the value of algebraic simplification.

---
layout: two-cols-header
---

## Design Example: Half-Adder

**Problem:** Design a circuit that adds two single bits, `x` and `y`, and produces two outputs: a **sum** bit `s` and a **carry** bit `c`. This is a fundamental arithmetic circuit.

::left::

### Truth Table & Expressions

We can define the behavior for both outputs in a single truth table.

| x | y | c (carry) | s (sum) |
|:-:|:-:|:---------:|:-------:|
| 0 | 0 |     0     |    0    |
| 0 | 1 |     0     |    1    |
| 1 | 0 |     0     |    1    |
| 1 | 1 |     1     |    0    |

**Sum bit (s):**
The sum is `1` only if the inputs are different. This is the **XOR** function.
`s = x'y + xy' = x ⊕ y`

**Carry bit (c):**
The carry is `1` only if both inputs are `1`. This is the **AND** function.
`c = xy`

::right::

### Circuit and Symbol

The circuit combines an XOR gate for the sum and an AND gate for the carry.

**Circuit Implementation**
<img src="https://i.imgur.com/2s3P0sC.png" class="rounded-lg bg-white p-4 w-80" alt="Circuit for a Half-Adder">

**Block Diagram**
<img src="https://i.imgur.com/e5g4f3D.png" class="rounded-lg bg-white p-4 w-48 mt-4" alt="Block Diagram for a Half-Adder">

---
layout: two-cols-header
---

## Chapter 2 Summary

This chapter covered the bridge from theory to practice in digital logic design.

::left::

### Core Concepts

*   **Boolean Algebra:** The mathematical language used to describe and manipulate logic functions.
*   **Logic Gates:** The basic physical building blocks (AND, OR, NOT) that implement Boolean operations.
*   **Truth Tables:** A complete, tabular representation of a logic function's behavior.
*   **Theorems:** Key properties like Duality and De Morgan's theorem are essential tools for simplification.

::right::

### Design & Implementation

*   **Logic Synthesis:** The process of converting a functional description into a logic circuit.
*   **Canonical Forms:** We can represent any function as a Sum-of-Products (from minterms) or a Product-of-Sums (from maxterms).
*   **Simplification:** Reducing complex expressions leads to simpler, faster, and more efficient circuits.
*   **Design Process:** We can systematically move from a problem statement to a truth table, to a Boolean expression, and finally to a logic circuit.