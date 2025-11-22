---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 2 - Logic Circuits
---

# Lecture 2: Logic Circuits

{{ $slidev.configs.subject }}

{{ $slidev.configs.presenter}}


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

:: right ::
<img src="https://cs50.harvard.edu/college/2020/fall/test/logical/Q3.png" class="rounded-lg bg-white p-4 w-90" alt="Logic Circuit" />
<img src="https://images.squarespace-cdn.com/content/v1/52711462e4b0932c24aa05ae/1557396856263-LNTTWGAQ3BGEKPIXZ8K9/LogicGates_spot.jpg?format=1500w" />


---
layout: two-cols-header
---

## The Fathers of Information Theory
The theoretical foundation of all modern digital computing was laid by George Boole and Claude Shannon.
::left::
### George Boole (1815-1864)


<img src="https://upload.wikimedia.org/wikipedia/commons/c/ce/George_Boole_color.jpg" style="float: left; margin-right: 35px; width: 150px;" class="rounded-lg w-38 mt-2" alt="George Boole">

*   Developed **Boolean algebra** in the mid-1800s.
*   His intent was not to build circuits, but to create an algebraic system to formalize human logic and thought.

::right::

### Claude Shannon (1916-2001)

<img src="https://upload.wikimedia.org/wikipedia/commons/9/98/C.E._Shannon._Tekniska_museet_43069_%28cropped%29.jpg" style="float: left; margin-right: 35px; width: 150px;" class="rounded-lg w-40 mt-2" alt="Claude Shannon">

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
The light $L$ is ON ($1$) only if **both** switch $x1$ AND switch $x2$ are closed ($1$).

$L(x1, x2) = x1 · x2$

<img src="/AND.png" class="rounded-lg bg-white p-4 mt-4" alt="AND function with series switches">

::right::

### OR Function (Parallel)
The light $L$ is ON ($1$) if switch $x1$ OR switch $x2$ (or both) are closed ($1$).

$L(x1, x2) = x1 + x2$

<img src="/OR.png" class="rounded-lg bg-white p-4 mt-4" alt="OR function with parallel switches">

---
layout: two-cols-header
---

## The NOT Function (Inversion)

What if we want an action to occur when a switch is *opened* instead of closed? This is called inversion or the NOT function.

::left::

*   The output $L$ is the **inverse** (or complement) of the input $x$.
*   If $x = 0$ (open), then $L = 1$ (on).
*   If $x = 1$ (closed), then $L = 0$ (off).
*   This is written as $L(x) = x'$ or $L(x) = \bar{x}$.
*   The circuit on the right implements a logical NOT function. When the switch $S$ is open ($x=0$), current flows through the resistor $R$ to the light $L$. When $S$ is closed ($x=1$), it creates a short circuit to ground, diverting current away from $L$.

::right::

<img src="/NOT.png" class="rounded-lg bg-white p-4" alt="NOT function with a switch">

---

## Truth Tables

A **truth table** is a tabular listing that fully describes a logic function by showing the output value for all possible input combinations.

<div class="grid grid-cols-3 gap-8 text-center">
<div>

### AND


| $x1$ | $x2$ | $x1·x2$ |
|:--:|:--:|:-----:|
| 0  | 0  |   0   |
| 0  | 1  |   0   |
| 1  | 0  |   0   |
| 1  | 1  |   1   |

</div>
<div>

### OR

| $x1$ | $x2$ | $x1+x2$ |
|:--:|:--:|:-----:|
| 0  | 0  |   0   |
| 0  | 1  |   1   |
| 1  | 0  |   1   |
| 1  | 1  |   1   |

</div>
<div>

### NOT

| $x1$ | $x1'$ |
|:--:|:---:|
| 0  |  1  |
| 1  |  0  |

</div>
</div>


---

## Basic Logic Gates

These are the standard symbols for the fundamental logic gates.

<div class="grid grid-cols-3 gap-8 text-center">
<div>

### AND Gate
<img src="/and_logic.png" class="rounded-lg bg-white p-4" alt="AND Gate Symbol">

</div>
<div>

### OR Gate
<img src="/or_logic.png" class="rounded-lg bg-white p-4" alt="OR Gate Symbol">

</div>
<div>

### NOT Gate (Inverter)
<img src="/not_logic.png" class="rounded-lg bg-white p-4" alt="NOT Gate Symbol">

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
*   The diagram shows how the Boolean expression $f = (x1 + x2) · x3$ is implemented as a network of an OR gate and an AND gate.

::right::

<img src="/logic_network.png" class="rounded-lg bg-white p-4" alt="Logic Network Diagram">

---
layout: two-cols-header
---

## Boolean Algebra: Axioms & Theorems

Boolean algebra is based on a set of axioms (basic assumptions) from which we can derive many useful theorems.

::left::

### Axioms

*   $0 · 0 = 0$
*   $1 + 1 = 1$
*   $1 · 1 = 1$
*   $0 + 0 = 0$
*   $0 · 1 = 1 · 0 = 0$
*   $1 + 0 = 0 + 1 = 1$
*   If $x = 0$, then $x' = 1$
*   If $x = 1$, then $x' = 0$

::right::

### Single-Variable Theorems

*   $x · 0 = 0$
*   $x + 1 = 1$
*   $x · 1 = x$
*   $x + 0 = x$
*   $x · x = x$
*   $x + x = x$
*   $x · x' = 0$
*   $x + x' = 1$
*   $(x')' = x$

---
layout: two-cols-header
---

## Boolean Algebra: Properties

These multi-variable properties are fundamental for manipulating and simplifying Boolean expressions.

::left::

### Commutative
$x · y = y · x$
$x + y = y + x$

### Associative
$x · (y · z) = (x · y) · z$
$x + (y + z) = (x + y) + z$

### Absorption
$x + x · y = x$
$x · (x + y) = x$

::right::

### Distributive
$x · (y + z) = x · y + x · z$
$x + y · z = (x + y) · (x + z)$

### Combining
$x · y + x · y' = x$
$(x + y) · (x + y') = x$

### Consensus
$x·y + y·z + x'·z = x·y + x'·z$
$(x+y)·(y+z)·(x'+z) = (x+y)·(x'+z)$

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

The expression: $x + 0 = x$

Its dual is: $x · 1 = x$

Notice how the theorems on the previous slides are often listed in dual pairs.

---
layout: two-cols-header
---

## De Morgan's Theorem

De Morgan's theorem provides a way to find the complement of a complex expression. It's essential for simplifying circuits and converting between Sum-of-Products and Product-of-Sums forms.

::left::

### Theorem

1.  $(x · y)' = x' + y'$
    *   The complement of a product is the sum of the complements.

2.  $(x + y)' = x' · y'$
    *   The complement of a sum is the product of the complements.

:: right ::

### Proof for $(x · y)' = x' + y'$

| $x$ | $y$ | $x·y$ | **$\bm{(x·y)'}$** | $x'$ | $y'$ | **$\bm{x'+y'}$** |
|:-:|:-:|:---:|:----------:|:--:|:--:|:-------:|
| 0 | 0 |  0  |     **1**      | 1  | 1  |   **1**   |
| 0 | 1 |  0  |     **1**      | 1  | 0  |   **1**   |
| 1 | 0 |  0  |     **1**      | 0  | 1  |   **1**   |
| 1 | 1 |  1  |     **0**      | 0  | 0  |   **0**   |

<style>
/* Target the table on this specific slide */
table {
  border-collapse: collapse; /* Merges adjacent borders */
}

/* Add a right border to all table headers and data cells */
/* The value '1px solid #AAA' uses your KMUTNB red color */
th, td {
  border-right: 1px solid #AAA; 
}

/* Optional: Remove the border from the very last column */
th:last-child, td:last-child {
  border-right: none;
}

</style>

---

## Venn Diagram Visualization

De Morgan's law can be visualized using Venn diagrams. The shaded area represents the result of the expression.

<div class="grid grid-cols-2 gap-4 text-center">


**$(A · B)'$** 
<img src="https://adacomputerscience.org/images/content/computer_science/computer_systems/boolean_logic/figures/ada_cs_boolean_venn_not_a_and_b.svg" class="rounded-lg bg-white p-2 w-60" alt="Venn Diagram for (x+y)'">

**$A' + B'$** 
<img src="https://adacomputerscience.org/images/content/computer_science/computer_systems/boolean_logic/figures/ada_cs_boolean_venn_not_a_or_not_b.svg" class="rounded-lg bg-white p-2 w-60" alt="Venn Diagram for x'y'">

</div>

The resulting area is identical, proving the equivalence.

---

## Logic Synthesis

**Logic synthesis** is the process of generating a logic circuit from a desired functional behavior, often described by a *truth table* or *Boolean expression*.

*   **Goal:** Create a circuit that correctly implements the function.
*   **Secondary Goal:** Optimize the circuit to be simpler, faster, smaller, or use less power.
*   We can synthesize a function by focusing on either the rows where the output is `1` or the rows where the output is `0`.

This leads to two standard forms:
1.  **Sum-of-Products (SOP)**
2.  **Product-of-Sums (POS)**

---
layout: two-cols
---

## Sum-of-Products (SOP) using Minterms
A **minterm** is a product (AND) term that includes every input variable, either in its true or complemented form. Each minterm corresponds to a single row in a truth table where the output is `1`.

### Synthesis Steps
1.  Identify all rows in the truth table where the function's output $f$ is **1**.
2.  For each of these rows, write a **minterm** product term. A variable is complemented if its value in the row is `0`, and true if its value is `1`.
3.  The final expression is the **sum (OR)** of all the minterms.

<div class="text-sm">

This is also known as the **canonical sum-of-products** form.
</div>

::right::

### Example
<div class="grid grid-cols-2 gap-2">

<div class="text-sm">

| $a$ | $b$ | $c$ | $f$ | $\text{Minterm}$ |
|:-:|:-:|:-:|:-:|:--------|
| 0 | 0 | 0 | 0 |         |
| 0 | 0 | 1 | **1** | $a'b'c$   |
| 0 | 1 | 0 | 0 |         |
| 0 | 1 | 1 | **1** | $a'bc$    |
| 1 | 0 | 0 | 0 |         |
| 1 | 0 | 1 | **1** | $ab'c$    |
| 1 | 1 | 0 | 0 |         |
| 1 | 1 | 1 | **1** | $abc$     |
</div>

<div>
<div class="p-4 border-1 border-solid border-black rounded-lg">

$f(a,b,c) = a'b'c + a'bc + ab'c + abc$
</div>

This can also be written using $m$ notation:
<div class="p-4 border-1 border-solid border-black rounded-lg">

$f(a,b,c) = m₁ + m₃ + m₅ + m₇ = Σm(1,3,5,7)$

</div>
</div>
</div>

<style>
/* Target the table on this specific slide */
table {
  border-collapse: collapse; /* Merges adjacent borders */
}

/* Add a right border to all table headers and data cells */
/* The value '1px solid #AC3520' uses your KMUTNB red color */
th, td {
  border-right: 1px solid #AAA; 
}

/* Optional: Remove the border from the very last column */
th:last-child, td:last-child {
  border-right: none;
}
</style>

---
layout: two-cols
---

## Product-of-Sums (POS) using Maxterms

A **maxterm** is a sum (OR) term that includes every input variable, either in its true or complemented form. Each maxterm corresponds to a single row in a truth table where the output is $0$.

### Synthesis Steps
1.  Identify all rows in the truth table where the function's output $f$ is **0**.
2.  For each of these rows, write a **maxterm** sum term. A variable is true if its value in the row is `0`, and complemented if its value is `1`.
3.  The final expression is the **product (AND)** of all the maxterms.

<div class="text-sm">

This is also known as the **canonical product-of-sums** form.
</div>

::right::

### Example

<div class="grid grid-cols-2 gap-1">
<div class="text-sm">

| $a$ | $b$ | $c$ | $f$ | $\text{Maxterm}$ |
|:-:|:-:|:-:|:-:|:--------|
| 0 | 0 | 0 | **0** | $a+b+c$   |
| 0 | 0 | 1 | 1 |         |
| 0 | 1 | 0 | **0** | $a+b'+c$  |
| 0 | 1 | 1 | 1 |         |
| 1 | 0 | 0 | **0** | $a'+b+c$  |
| 1 | 0 | 1 | 1 |         |
| 1 | 1 | 0 | **0** | $a'+b'+c$ |
| 1 | 1 | 1 | 1 |         |
</div>

<div>
<div class="p-4 border-1 border-solid border-black rounded-lg">

$f(a,b,c) = (a+b+c)·(a+b'+c)·(a'+b+c)·(a'+b'+c)$
</div>

This can also be written using $M$ notation:

<div class="p-4 border-1 border-solid border-black rounded-lg">

$f(a,b,c) = M₀ · M₂ · M₄ · M₆ = ΠM(0,2,4,6)$
</div>

</div>

</div>

<style>
/* Target the table on this specific slide */
table {
  border-collapse: collapse; /* Merges adjacent borders */
}

/* Add a right border to all table headers and data cells */
/* The value '1px solid #AC3520' uses your KMUTNB red color */
th, td {
  border-right: 1px solid #AAA; 
}

/* Optional: Remove the border from the very last column */
th:last-child, td:last-child {
  border-right: none;
}
</style>

---

## Minimality and Simplification

A function in its canonical Sum-of-Products form may not be minimal. It's often possible to simplify the expression, which leads to a simpler, cheaper, and faster circuit.

<div class="grid grid-cols-5 gap-2">
<div class="col-span-3">

### Example
Consider the function represented by the truth table.

**Canonical SOP:**
$f(x1,x2) = x1'x2' + x1'x2 + x1x2$

**Simplification:**
1. $f = x1'(x2' + x2) + x1x2$
2. $f = x1'(1) + x1x2$
3. $f = x1' + x1x2$
4. $f = (x1' + x1)(x1' + x2)$
5. $f = 1 · (x1' + x2)$
6. $f = x1' + x2$

</div>
<div class="col-span-2">


### Truth Table

| $x1$ | $x2$ | $f$ |
|:-:|:-:|:-:|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

</div>
</div>

---
layout: two-cols
---

The simplified form $x1' + x2$ requires far fewer gates.

**Original Circuit for $x1'x2' + x1'x2 + x1x2$**
<img src="/sop.png" class="rounded-lg bg-white p-2 w-80" alt="Complex circuit for unsimplified function">

**Simplified Circuit for $x1' + x2$**
<img src="/simplified.png" class="rounded-lg bg-white p-2 mt-4 w-70" alt="Simple circuit for simplified function">

:: right ::

<iframe src="https://circuitverse.org/simulator/embed/minimal?theme=&display_title=false&clock_time=false&fullscreen=true&zoom_in_out=true" style="border-width:; border-style: solid; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="400" width="500" allowFullScreen></iframe>


---
layout: two-cols-header
---

## Design Example: Three-Way Light Control
::left::
**Problem:** A room has three doors, each with a switch ($x_1$, $x_2$, $x_3$) to control a single light. The light should toggle its state whenever any switch is flipped. Assume the light is OFF when all switches are open (0).

*   Light is ON if **one** switch is closed.
*   Light is OFF if **two** switches are closed.
*   Light is ON if **three** switches are closed.

<img src="/room.png" class="rounded-lg bg-white p-2 mt-4 w-90"/>

::right::

### Truth Table

<div class="text-sm">


| $\bm{x_1}$ | $\bm{x_2}$ | $\bm{x_3}$ | $\bm{f}$ |
|:-:|:-:|:-:|:-:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | **1** |
| 0 | 1 | 0 | **1** |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | **1** |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | **1** |

</div>

<style>
/* Target the table on this specific slide */
table {
  border-collapse: collapse; /* Merges adjacent borders */
}

/* Add a right border to all table headers and data cells */
/* The value '1px solid #AC3520' uses your KMUTNB red color */
th, td {
  border-right: 1px solid #CCC; 
}

/* Optional: Remove the border from the very last column */
th:last-child, td:last-child {
  border-right: none;
}
</style>

---
layout: two-cols
---

### Sum-of-Products

From the truth table, we can write the SOP expression:

$f = x_1'x_2'x_3 + x_1'x_2x_3' + x_1x_2'x_3' + x_1x_2x_3$

This is the simplest SOP form for this function (also known as the XOR function).

### Circuit Implementation

<img src="/three_way_light.png" class="mt-4 w-100"/>

:: right ::
<<iframe src="https://circuitverse.org/simulator/embed/three-way-light-control?theme=default&display_title=false&clock_time=false&fullscreen=true&zoom_in_out=true" style="border-width:; border-style: hidden; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="400" width="500" allowFullScreen></iframe>

---

### VHDL implementation
<div class="grid grid-cols-2 gap-2" >
<div>

**three_way_light.vhd**
```vhdl {*}{lines:'true',maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity three_way_light is
    Port ( 
        x1 : in  STD_LOGIC;
        x2 : in  STD_LOGIC;
        x3 : in  STD_LOGIC;
        f  : out STD_LOGIC
    );
end three_way_light;

-- ARCHITECTURE 1: Direct Sum of Products (SOP) Implementation
-- This matches your prompt exactly.
architecture Arch_SOP of three_way_light is
begin
    f <= (not x1 and not x2 and x3) or
         (not x1 and x2 and not x3) or
         (x1 and not x2 and not x3) or
         (x1 and x2 and x3);
end Arch_SOP;

-- ARCHITECTURE 2: Simplified Implementation
-- This does the exact same thing but is more efficient.
architecture Arch_Simplified of three_way_light is
begin
    f <= x1 xor x2 xor x3;
end Arch_Simplified;
```
</div>

<div>

**fun_tb.vhd**
```vhdl {*}{lines:'true',maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity func_tb is
-- Testbenches do not have ports
end func_tb;

architecture behavior of func_tb is
    -- Component Declaration
    component func_implementation
    Port(
        x1 : in STD_LOGIC;
        x2 : in STD_LOGIC;
        x3 : in STD_LOGIC;
        f  : out STD_LOGIC
    );
    end component;

    -- Inputs
    signal x1 : std_logic := '0';
    signal x2 : std_logic := '0';
    signal x3 : std_logic := '0';

    -- Outputs
    signal f : std_logic;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: func_implementation port map (
        x1 => x1,
        x2 => x2,
        x3 => x3,
        f  => f
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset state for 100 ns.
        wait for 100 ns;	

        -- 000 -> f=0
        x1 <= '0'; x2 <= '0'; x3 <= '0'; wait for 10 ns;
        
        -- 001 -> f=1
        x1 <= '0'; x2 <= '0'; x3 <= '1'; wait for 10 ns;
        
        -- 010 -> f=1
        x1 <= '0'; x2 <= '1'; x3 <= '0'; wait for 10 ns;
        
        -- 011 -> f=0
        x1 <= '0'; x2 <= '1'; x3 <= '1'; wait for 10 ns;
        
        -- 100 -> f=1
        x1 <= '1'; x2 <= '0'; x3 <= '0'; wait for 10 ns;
        
        -- 101 -> f=0
        x1 <= '1'; x2 <= '0'; x3 <= '1'; wait for 10 ns;
        
        -- 110 -> f=0
        x1 <= '1'; x2 <= '1'; x3 <= '0'; wait for 10 ns;
        
        -- 111 -> f=1
        x1 <= '1'; x2 <= '1'; x3 <= '1'; wait for 10 ns;

        wait;
    end process;

end behavior;
```
</div>
</div>


---
layout: two-cols-header
---

## Design Example: Multiplexer (MUX)

<div class="grid grid-cols-7 gap-4">
<div class="col-span-2">

**Problem:** Design a circuit that chooses between two data inputs, $x_1$ and $x_2$, based on a control signal $s$. This is a 2-to-1 Multiplexer.

*   If $s = 0$, the output $f$ should be equal to $x_1$.
*   If $s = 1$, the output $f$ should be equal to $x_2$.

</div>




<div class="text-sm col-span-2">

### Truth Table 

| $\bm{s}$ | $\bm{x_1}$ | $\bm{x_2}$ | $\bm{f}$ |
|:-:|:-:|:-:|:-:|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | **1** |
| 0 | 1 | 1 | **1** |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | **1** |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | **1** |
</div>
<div class="col-span-3">

### Expression

**SOP:** 

$f = s'x_1x_2' + s'x_1x_2 + sx_1'x_2 + sx_1x_2$

**Simplified:**

$f = s'x_1(x_2' + x_2) + sx_2(x_1' + x_1)$

$f = s'x_1(1) + sx_2(1)$

$f = s'x_1 + sx_2$
</div>

</div>

<style>
/* Target the table on this specific slide */
table {
  border-collapse: collapse; /* Merges adjacent borders */
}

/* Add a right border to all table headers and data cells */
/* The value '1px solid #AC3520' uses your KMUTNB red color */
th, td {
  border-right: 1px solid #CCC; 
}

/* Optional: Remove the border from the very last column */
th:last-child, td:last-child {
  border-right: none;
}
</style>

---
layout: two-cols
---

### Circuit and Symbol

**Circuit for $f = s'x_1 + sx_2$**
<img src="/mux_circuit.png" class="rounded-lg bg-white p-4 w-80" alt="Circuit for 2-to-1 Multiplexer">

**Graphical Symbol**
<img src="/mux_symbol.png" class="rounded-lg bg-white p-4 w-48 mt-4" alt="Symbol for 2-to-1 Multiplexer">

:: right ::

<iframe src="https://circuitverse.org/simulator/embed/mux_2_to_1?theme=&display_title=false&clock_time=false&fullscreen=true&zoom_in_out=false" style="border-width:; border-style: ; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="450" width="400" allowFullScreen></iframe>

---


## Design Example: Car Safety Alarm

<div class="grid grid-cols-2 gap-4">

<div>

**Problem:** Design a car safety alarm `A` that sounds if:
1.  The key is in (`K=1`) and the door is not closed (`D=0`), OR
2.  The door is closed (`D=1`), the key is in (`K=1`), the driver is in the seat (`S=1`), and the seat belt is not closed (`B=0`).

<img src="/car.png" class="w-90 rounded-lg bg-white p-4"/>

</div>

<div>

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

</div>
</div>

---

### Circuit Implementation

The circuit is built from the simplified expression `A = K · (D' + S·B')`, which is much simpler than a circuit for the original expression.

<img src="/car_alarm.png" class="rounded-lg bg-white p-2 w-130" alt="Circuit for Car Safety Alarm">

---

### VHDL Implementation

This difference is also clear when implemented in VHDL.

**Unsimplified Expression:** `A = K·D' + D·K·S·B'`
```vhdl
-- Unsimplified architecture
architecture unsimplified of car_alarm is
begin
    A <= (K and not D) or (D and K and S and not B);
end unsimplified;
```

**Simplified Expression:** `A = K · (D' + S·B')`
```vhdl
-- Simplified architecture
architecture simplified of car_alarm is
begin
    A <= K and (not D or (S and not B));
end simplified;
```
While a synthesizer might optimize both to the same logic, the simplified version is more readable and directly maps to a more efficient circuit structure.

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

### VHDL Implementation

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port ( x, y : in  std_logic;
           s, c : out std_logic );
end half_adder;

architecture dataflow of half_adder is
begin
    s <= x xor y;
    c <= x and y;
end dataflow;
```

---
layout: two-cols-header
---

## Lecture 2 Summary

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