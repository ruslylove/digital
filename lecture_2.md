---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 2 - Logic Circuits
---

# Lecture 2: Logic Circuits

{{ $slidev.configs.subject }}

{{ $slidev.configs.author }}


---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---


## Logic Circuits

*   **Logic circuits** perform operations on digital signals.
*   They are implemented as electronic circuits where signal values are restricted to a few discrete values.
*   In **binary logic circuits**, there are only two values: **0** and **1**.
*   The general form of a logic circuit is a **switching network**, which takes a set of discrete inputs and produces a set of discrete outputs.


<img src="/switching_network.svg" class="rounded-lg bg-white pt-8 w-100 mx-auto" alt="Logic Circuit" />
<p class="text-sm text-center">Figure 2-1. Diagram of a Switching Network.</p>


---
layout: two-cols-header
---

## The Fathers of Information Theory
The theoretical foundation of all modern digital computing was laid by George Boole and Claude Shannon.
::left::
### George Boole (1815-1864)


<img src="https://upload.wikimedia.org/wikipedia/commons/c/ce/George_Boole_color.jpg" style="float: left; margin-right: 35px; width: 150px;" class="rounded-lg mt-2 h-46" alt="George Boole">

*   Developed **Boolean algebra** in the mid-1800s.
*   His intent was not to build circuits, but to create an algebraic system to formalize human logic and thought.

::right::

### Claude Shannon (1916-2001)

<img src="https://upload.wikimedia.org/wikipedia/commons/9/98/C.E._Shannon._Tekniska_museet_43069_%28cropped%29.jpg" style="float: left; margin-right: 35px; width: 150px;" class="rounded-lg w-40 mt-2" alt="Claude Shannon">

*   In his 1938 Master's thesis, he showed how Boolean algebra could be applied to switch-based circuits.
*   He demonstrated that an "on" switch could be treated as $1$ (true) and an "off" switch as $0$ (false).
*   This insight proved that **we can build digital circuits by doing math**.

<style>
.two-cols-header {
  column-gap: 50px; /* Adjust the gap size as needed */
}
</style>

---

## Boolean Algebra

<div class="grid grid-cols-8 gap-6">

<div class="col-span-4">

* Provides the mathematical foundation for designing and analyzing digital logic circuits.
* It's a 2-valued algebra that works with devices that have two states (e.g., on/off, high/low).
* We use **Boolean variables** (like $A$, $B$, $x$, $y$) to represent the inputs and outputs of a circuit.
* A variable can only take one of two values: $\bm{0}$ or $\bm{1}$.
* These symbols represent the two possible states of the variable, not numerical values. They commonly refer to low or high voltage levels in a circuit.
* Boolean algebra is based on a set of axioms (basic assumptions) from which we can derive many useful theorems.


</div>

<div class="col-span-2">

### Axioms
<div class="p-4 border-1 border-solid border-black rounded-lg">

*   $0 · 0 = 0$
*   $1 + 1 = 1$
*   $1 · 1 = 1$
*   $0 + 0 = 0$
*   $0 · 1 = 1 · 0 = 0$
*   $1 + 0 = 0 + 1 = 1$
*   If $x = 0$, then $x' = 1$
*   If $x = 1$, then $x' = 0$
</div>
</div>
<div class="col-span-2">

### Single-Variable Theorems
<div class="p-4 border-1 border-solid border-black rounded-lg">

*   $x · 0 = 0$
*   $x + 1 = 1$
*   $x · 1 = x$
*   $x + 0 = x$
*   $x · x = x$
*   $x + x = x$
*   $x · x' = 0$
*   $x + x' = 1$
*   $(x')' = x$
</div>
</div>
</div>

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
1.  Replace all **AND** operators ($·$) with **OR** operators ($+$).
2.  Replace all **OR** operators ($+$) with **AND** operators ($·$).
3.  Replace all **0s** with **1s**.
4.  Replace all **1s** with **0s**.
<br>
**Example:**
* The expression: $x + 0 = x$
* Its dual is: $x · 1 = x$
* Notice how the theorems on the previous slides are often listed in dual pairs.

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

<img src="/venn.svg" class="mx-auto"/>
<p class="text-sm text-center">Figure 2-2. De Morgan's law is proved by Venn diagrams.</p>

The resulting area is identical, proving the equivalence.


---
layout: two-cols-header
---

## Switches to Logic Functions

The simplest binary element is a switch. We can combine switches to create basic logic functions.

::left::

### AND Function (Series)
The light $L$ is ON ($1$) only if **both** switch $x1$ AND switch $x2$ are closed ($1$).

$L(x1, x2) = x1 · x2$

<img src="/AND.png" class="rounded-lg bg-white p-4 mt-4 w-90 mx-auto" alt="AND function with series switches">
<p class="text-sm text-center">Figure 2-3. Switching circuit as AND function.</p>
::right::

### OR Function (Parallel)
The light $L$ is ON ($1$) if switch $x1$ OR switch $x2$ (or both) are closed ($1$).

$L(x1, x2) = x1 + x2$

<img src="/OR.png" class="rounded-lg bg-white p-1 mt-1 w-83 mx-auto" alt="OR function with parallel switches">
<p class="text-sm text-center">Figure 2-4. Switching circuit as OR function.</p>

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

<img src="/NOT.png" class="rounded-lg bg-white p-4 w-90 mx-auto" alt="NOT function with a switch">
<p class="text-sm text-center">Figure 2-5. Switching circuit as NOT function.</p>

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

## Basic Logic Gates

These are the standard symbols for the fundamental logic gates.

<div class="grid grid-cols-3 gap-8">

<div>

### AND Gate

<img src="/and_symbol.svg" class="rounded-lg bg-white p-4 w-80" alt="AND Gate Symbol"/>

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    Port ( x1, x2 : in  STD_LOGIC;
           Y    : out STD_LOGIC);
end and_gate;

architecture Behavioral of and_gate is
begin
    Y <= x1 AND x2;
end Behavioral;
```
</div>

<div>

### OR Gate

<img src="/or_symbol.svg" class="rounded-lg bg-white p-4 w-100" alt="OR Gate Symbol"/>

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    Port ( x1, x2 : in  STD_LOGIC;
           Y    : out STD_LOGIC);
end or_gate;

architecture Behavioral of or_gate is
begin
    Y <= x1 OR x2;
end Behavioral;
```

</div>

<div>

### NOT Gate (Inverter)

<img src="/not_symbol.svg" class="rounded-lg bg-white p-3 w-100 mx-auto" alt="NOT Gate Symbol"/>

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate is
    Port ( x : in  STD_LOGIC;
           Y : out STD_LOGIC);
end not_gate;

architecture Behavioral of not_gate is
begin
    Y <= NOT x;
end Behavioral;
```

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

<img src="/logic_network.png" class="rounded-lg bg-white mx-auto" alt="Logic Network Diagram">
<div class="text-sm text-center">

Figure 2-6. A logic gate network of $f=(x_1+x_2) \cdot x_3$.

</div> 

<div class="pl-2">

```vhdl {4-12}{maxHeight:'190px',lines:true}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_function is
    Port ( x1,x2,x3 : in  STD_LOGIC;
           f        : out STD_LOGIC);
end logic_function;

architecture Behavioral of logic_function is
begin
    f <= (x1 OR x2) AND x3;
end Behavioral;
```

</div>

<style>
.two-cols-header {
  column-gap: 40px; /* Adjust the gap size as needed */
}
</style>

---

## Logic Synthesis

**Logic synthesis** is the process of generating a logic circuit from a desired functional behavior, often described by a *truth table* or *Boolean expression*.

*   **Goal:** Create a circuit that correctly implements the function.
*   **Secondary Goal:** Optimize the circuit to be simpler, faster, smaller, or use less power.
*   We can synthesize a function by focusing on either the rows where the output is $1$ or the rows where the output is $0$.

This leads to two standard forms:
1.  **Sum-of-Products (SOP)**
2.  **Product-of-Sums (POS)**

---
layout: two-cols
---

## Sum-of-Products (SOP) using Minterms
A **minterm** is a product (AND) term that includes every input variable, either in its true or complemented form. Each minterm corresponds to a single row in a truth table where the output is $1$.

### Synthesis Steps
1.  Identify all rows in the truth table where the function's output $f$ is **1**.
2.  For each of these rows, write a **minterm** product term. A variable is complemented if its value in the row is $0$, and true if its value is $1$.
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
| 0 | 0 | 0 | 0 | $m_0: a'b'c'$ |
| 0 | 0 | 1 | **1** | $\bm{m_1: a'b'c}$   |
| 0 | 1 | 0 | 0 | $m_2: a'bc'$       |
| 0 | 1 | 1 | **1** | $\bm{m_3: a'bc}$    |
| 1 | 0 | 0 | 0 | $m_4: ab'c'$       |
| 1 | 0 | 1 | **1** | $\bm{m_5: ab'c}$    |
| 1 | 1 | 0 | 0 | $m_6: abc'$       |
| 1 | 1 | 1 | **1** | $\bm{m_7: abc}$     |
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
2.  For each of these rows, write a **maxterm** sum term. A variable is true if its value in the row is $0$, and complemented if its value is $1$.
3.  The final expression is the **product (AND)** of all the maxterms.

<div class="text-sm">

This is also known as the **canonical product-of-sums** form.
</div>

::right::

### Example

<div class="grid grid-cols-2 gap-16">
<div class="text-sm">

| $a$ | $b$ | $c$ | $f$ | $\text{Maxterm}$ |
|:-:|:-:|:-:|:-:|:--------|
| 0 | 0 | 0 | **0** | $\bm{M_0:a+b+c}$   |
| 0 | 0 | 1 | 1 | $M_1:a+b+c'$        |
| 0 | 1 | 0 | **0** | $\bm{M_2:a+b'+c}$  |
| 0 | 1 | 1 | 1 | $M_3:a+b'+c'$       |
| 1 | 0 | 0 | **0** | $\bm{M_4:a'+b+c}$  |
| 1 | 0 | 1 | 1 | $M_5: a'+b+c'$      |
| 1 | 1 | 0 | **0** | $\bm{M_6:a'+b'+c}$ |
| 1 | 1 | 1 | 1 | $M_7: a'+b'+c'$     |
</div>

<div>
<div class="p-2 border-1 border-solid border-black rounded-lg">

$f(a,b,c) = (a+b+c)·(a+b'+c)·(a'+b+c)·(a'+b'+c)$
</div>

This can also be written using $M$ notation:

<div class="p-2 border-1 border-solid border-black rounded-lg">

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

The simplified form $x1' + x2$ requires far fewer gates.

**Original Circuit for $x1'x2' + x1'x2 + x1x2$**
<img src="/sop.png" class="rounded-lg bg-white p-2 w-80" alt="Complex circuit for unsimplified function">
<div class="text-sm text-center">Figure 2-7. Original circuit. </div>

**Simplified Circuit for $x1' + x2$**
<img src="/simplified.png" class="rounded-lg bg-white p-2 mt-4 w-70" alt="Simple circuit for simplified function">
<div class="text-sm text-center">Figure 2-8. Simplified circuit.</div>

:: right ::
### VHDL Implementation
```vhdl {*}{maxHeight:'240px',lines:true}
-- Standard Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Defines the external interface (x1, x2 inputs, f output)
---------------------------------------------------------------------
ENTITY Logic_Function IS
    PORT (
        x1 : IN  STD_LOGIC;
        x2 : IN  STD_LOGIC;
        f  : OUT STD_LOGIC
    );
END ENTITY Logic_Function;

---------------------------------------------------------------------
-- ARCHITECTURE 1: Implementation using the Canonical Sum-of-Products
-- F = x1'x2' + x1'x2 + x1x2  (The unsimplified form)
---------------------------------------------------------------------
ARCHITECTURE RTL_Canonical OF Logic_Function IS
BEGIN
    -- Concurrent signal assignment using Boolean operators
    f <= (NOT x1 AND NOT x2) OR 
         (NOT x1 AND x2)     OR 
         (x1 AND x2);
         
END ARCHITECTURE RTL_Canonical;

---------------------------------------------------------------------
-- ARCHITECTURE 2: Implementation using the Simplified Form
-- F = x1' + x2
---------------------------------------------------------------------
ARCHITECTURE RTL_Simplified OF Logic_Function IS
BEGIN
    -- Concurrent signal assignment using the minimal Boolean expression
    f <= NOT x1 OR x2;
    
END ARCHITECTURE RTL_Simplified;
```

To use a specific architecture in a top-level design, you would employ a **Configuration** statement or use **direct entity instantiation** by specifying the architecture name:

```vhdl {*}{maxHeight:'250px',lines:true}
-- Example of Direct Instantiation:
UUT : ENTITY work.Logic_Function(RTL_Simplified)
    PORT MAP (x1 => sig_a, x2 => sig_b, f => sig_out);
```

---

### Logisim Simulation

<img src="/logisim_result.png" class="w-170 mx-auto pt-4"/>
<p class="text-sm text-center">Figure 2-9. Timing Simulation result in Logisim Evolution.</p>




---
layout: two-cols-header
---

## Design Example: Three-Way Light Control
::left::

<div class="text-base">

**Problem:** A room has three doors, each with a switch ($x_1$, $x_2$, $x_3$) to control a single light. The light should toggle its state whenever any switch is flipped. Assume the light is OFF when all switches are open (0).

*   Light is ON if **one** switch is closed.
*   Light is OFF if **two** switches are closed.
*   Light is ON if **three** switches are closed.

<img src="/doors.svg" class="w-60 mx-auto pt-5"/>

<p class="text-sm text-center">Figure 2-10. Three-way light control logic circuit.</p>

</div>

::right::
**Truth Table:**
<div class="text-xs">

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

<style>
.two-cols-header {
  column-gap: 50px; /* Adjust the gap size as needed */
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

<img src="/three_way_light.png" class="mt-4 w-90"/>
<p class="text-sm text-center">Figure 2-11. Three-way light control logic circuit.</p>

:: right ::
**CircuitVerse Simulation**
<a href="https://circuitverse.org/simulator/embed/three-way-light-control?theme=&display_title=false&clock_time=true&fullscreen=true&zoom_in_out=true" target="_blank" style="border-width:; border-style: ; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="450" width="400" allowFullScreen>
  <img src="/Main.png" alt="Click to view full image" style="width: 400px; cursor: pointer;">
</a>


---

### VHDL implementation
<div class="grid grid-cols-2 gap-8" >
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

**three_way_light_tb.vhd**
```vhdl {*}{lines:'true',maxHeight:'380px'}
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity three_way_light_tb is
-- Testbenches do not have ports
end three_way_light_tb;

architecture behavior of three_way_light_tb is
    -- Component Declaration
    component three_way_light
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
    uut: ENTITY work.three_way_light(Arch_Simplified) port map (
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
hide: false
---

## The VHDL Testbench

A **testbench** is a VHDL entity used to simulate and verify the correctness of another VHDL entity, known as the **Unit Under Test (UUT)**. It's a crucial part of the design process, allowing you to test your logic in a simulated environment before programming it onto actual hardware.

<div class="grid grid-cols-2 gap-8">
<div class="text-sm">

### The Process

1.  **Instantiate the UUT:** The testbench declares the design you want to test as a `component` and creates an instance of it.
2.  **Generate Stimulus:** Internal signals are created to connect to the UUT's ports. A `process` is written to change the values of the input signals over time, simulating real-world scenarios.
3.  **Observe Outputs:** You run the simulation in a tool like Questa(r) or GHDL. The tool generates waveforms showing how the UUT's output signals respond to the input stimulus.
4.  **Verify Correctness:** You check the waveforms to ensure the outputs are correct. For automated checking, VHDL's `assert` statement can be used to report errors if an output does not match its expected value.
</div>
<div>
<img src="/test_bench.svg" class="w-100 mx-auto"/>
<p class="text-sm text-center">Figure 2-12. The relationship between the Entity and its Testbench.</p>

</div>
</div>


---

### Questa(r) Simulation Result

<img src="/three_way_light_sim.png" class="w-180 pt-4 mx-auto" />
<p class="text-sm text-center">Figure 2-13. Timing Simulation result in Intel (Altera) Questa.</p>


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
<img src="/mux_circuit.png" class="rounded-lg bg-white w-70 mx-auto" alt="Circuit for 2-to-1 Multiplexer">
<p class="text-sm text-center">Figure 2-14. Multiplexter 2-to-1 circuit.</p>

**Graphical Symbol**
<img src="/mux_symbol.png" class="rounded-lg bg-white w-35 mx-auto" alt="Symbol for 2-to-1 Multiplexer">
<p class="text-sm text-center">Figure 2-15. Multiplexer 2-to-1 symbol.</p>

:: right ::
**CircuitVerse Simulation**
<a href="https://circuitverse.org/simulator/embed/mux_2_to_1?theme=&display_title=false&clock_time=false&fullscreen=true&zoom_in_out=false" target="_blank" style="border-width:; border-style: ; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="450" width="400" allowFullScreen>
  <img src="/mux_2_to_1_cv.png" alt="Click to view full image" style="width: 400px; cursor: pointer;">
</a>

---

## Design Example: Car Safety Alarm

<div class="grid grid-cols-2 gap-5">

<div>

**Problem:** Design a car safety alarm $A$ that sounds if:
1.  The key is in ($K=1$) and the door is not closed ($D=0$), OR
2.  The door is closed ($D=1$), the key is in ($K=1$), the driver is in the seat ($S=1$), and the seat belt is not closed ($B=0$).
<img src="/car_alarm_sketch.svg" class="w-55 mx-auto"/>
<p class="text-sm text-center">Figure 2-16. A Car Alarm System.</p>


</div>

<div>

### Boolean Expression

Translating the conditions into a Boolean expression:

*   Condition 1: $K · D'$
*   Condition 2: $D · K · S · B'$

The final alarm function $A$ is the OR of these two conditions:
$A = K·D' + D·K·S·B'$

This can be simplified slightly by factoring out $K$:
$A = K · (D' + D·S·B')$

Using the property $X + X'Y = X + Y$:
Let $X = D'$, then $X' = D$.
$D' + D·S·B' = D' + S·B'$

So, the final simplified expression is:

$A = K · (D' + S·B')$

</div>
</div>

---
layout: two-cols
---

### Circuit Implementation

The circuit is built from the simplified expression $A = K · (D' + S·B')$, which is much simpler than a circuit for the original expression.

<img src="/car_alarm.svg" class="rounded-lg bg-white p-2" alt="Circuit for Car Safety Alarm">
<p class="text-sm text-center">Figure 2-17. Circuit for Car Safety Alarm.</p>

:: right ::

### VHDL Implementation

```vhdl {*}{maxHeight:'430px',lines:true}
-- Standard Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Defines the interface with four inputs and one output
---------------------------------------------------------------------
ENTITY Car_Alarm_Logic IS
    PORT (
        K, D, S, B : IN  STD_LOGIC;  -- Inputs
        A          : OUT STD_LOGIC   -- Output
    );
END ENTITY Car_Alarm_Logic;

---------------------------------------------------------------------
-- ARCHITECTURE: Implementation using the Simplified Boolean Expression
-- A = K AND (NOT D OR (S AND NOT B))
---------------------------------------------------------------------
ARCHITECTURE RTL OF Car_Alarm_Logic IS
BEGIN
    -- Concurrent signal assignment based on the simplified equation:
    -- A = K · (D' + S · B')
    A <= K AND (NOT D OR (S AND NOT B));
    
END ARCHITECTURE RTL;
```

---


## Design Example: Half-Adder

**Problem:** Design a circuit that adds two single bits, $x$ and $y$, and produces two outputs: a **sum** bit $s$ and a **carry** bit $c$. This is a fundamental arithmetic circuit.

### Truth Table & Expressions

<div class="grid grid-cols-5 gap-4">

<div class="col-span-2">

We can define the behavior for both outputs in a single truth table.
<div class="text-sm">

| $x$ | $y$ | $Sum (s)$ | $Carry (c)$ |
|:-:|:-:|:---------:|:-------:|
| 0 | 0 |     0     |    0    |
| 0 | 1 |     1     |    0    |
| 1 | 0 |     1     |    0    |
| 1 | 1 |     0     |    1    |
</div>
</div>
<div class="col-span-3">

**Sum bit ($s$):**
The sum is $1$ only if the inputs are different. This is the **XOR** function.
$s = x'y + xy' = x ⊕ y$

**Carry bit ($c$):**
The carry is $1$ only if both inputs are $1$. This is the **AND** function.
$c = xy$

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

The circuit combines an XOR gate for the sum and an AND gate for the carry.

**Circuit Implementation**
<img src="/half_adder.svg" class="rounded-lg bg-white w-70 mx-auto mt-2" alt="Circuit for a Half-Adder">
<p class="text-sm text-center">Figure 2-18. Circuit for a Half-Adder.</p>

**Block Diagram**
<img src="/half_adder_block.svg" class="rounded-lg bg-white w-60 mx-auto mt-2" alt="Block Diagram for a Half-Adder">
<p class="text-sm text-center">Figure 2-19. Block Diagram for a Half-Adder.</p>

:: right ::

### VHDL Implementation

```vhdl {*}{maxHeight:'430px',lines:true}
-- Load standard IEEE libraries
LIBRARY ieee;
-- Use the package that defines standard logic types (STD_LOGIC)
USE ieee.std_logic_1164.ALL;

---------------------------------------------------------------------
-- ENTITY: Defines the external interface of the half adder
---------------------------------------------------------------------
ENTITY half_adder IS
    -- Define the ports (inputs and outputs) of the circuit
    PORT ( 
        x, y : IN  STD_LOGIC;  -- Two single-bit inputs (augend and addend)
        s, c : OUT STD_LOGIC   -- Sum (s) and Carry-out (c) single-bit outputs
    );
END ENTITY half_adder;

---------------------------------------------------------------------
-- ARCHITECTURE: Defines the internal behavior and logic
---------------------------------------------------------------------
-- The 'dataflow' architecture uses concurrent signal assignments
ARCHITECTURE dataflow OF half_adder IS
BEGIN
    -- Sum output: Calculated using the Exclusive OR (XOR) function
    -- S = X XOR Y
    s <= x XOR y;
    
    -- Carry output: Calculated using the AND function
    -- C = X AND Y
    c <= x AND y;
END ARCHITECTURE dataflow;
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

<style>
.two-cols-header {
  column-gap: 50px; /* Adjust the gap size as needed */
}
</style>
---
layout: section
---

## Lecture 2 Exercises

---

### Exercise 2-1: Majority Function

A majority function is a Boolean function that is true when more than half of its inputs are true. Design a logic circuit for a 3-input majority function.

#### **Tasks:**
1.  **Truth Table:** Create a truth table for a 3-input function `f(x, y, z)` that outputs `1` when two or more inputs are `1`.
2.  **SOP Expression:** Write the canonical Sum-of-Products (SOP) expression from the truth table.
3.  **Simplification:** Simplify the SOP expression using Boolean algebra.
4.  **Circuit Diagram:** Draw the logic circuit for the simplified expression using AND, OR, and NOT gates.
5.  **Simulation:** Implement your simplified circuit or write VHDL code in a simulator (e.g, Quartus or Logisim), apply all 8 input combinations, and show the simulation waveform confirming your truth table.

---

### Exercise 2-2: Simple Home Alarm System

Design a simplified home alarm system with the following behavior:

The alarm `A` should sound (`A=1`) if the system is armed (`S=1`) **AND** either the front door is opened (`D=1`) **OR** the window is opened (`W=1`). The system should not sound if it is not armed.

#### **Tasks:**
1.  **Truth Table:** Construct a truth table for the alarm function `A(S, D, W)`.
2.  **Boolean Expression:** Write the Boolean expression for the function `A`.
3.  **Circuit Diagram:** Draw the logic circuit that implements this expression.
4.  **Simulation:** Use a simulator to build and test your circuit (Schematic or VHDL code). Provide a screenshot of your working simulation for the case where the system is armed and the front door is opened.


---


### Exercise 2-3: Line-Following Robot


<div>

A robot uses three sensors (`L`, `C`, `R`) to follow a black line (`sensor=0`) on a white surface (`sensor=1`). It has two motors, `ML` (Left) and `MR` (Right).
<div class="grid grid-cols-7 gap-4">
<div class="text-sm col-span-4">
<img src="/line_following_robot.svg" class="w-45 mx-auto" />
<p class="text-sm text-center">Figure 2-20. A Line-Following Robot.</p>

*   **Go Forward (`ML=1, MR=1`):** When the robot is centered (`L=1, C=0, R=1`).
*   **Turn Right (`ML=1, MR=0`):** When it drifts left (`L=1, C=1, R=0`).
*   **Turn Left (`ML=0, MR=1`):** When it drifts right (`L=0, C=1, R=1`).
*   **Stop (`ML=0, MR=0`):** For all other cases, including being completely off the line (`L=1, C=1, R=1`).
</div>

<div class="text-sm col-span-3">

#### **Tasks:**
1.  **Truth Table:** Create a truth table with inputs `L`, `C`, `R` and outputs `ML` and `MR`.
2.  **Boolean Expressions:** Write the Sum-of-Products (SOP) expressions for `ML` and `MR`.
3.  **Circuit Diagram:** Draw the two logic circuits for the simplified `ML` and `MR` expressions.
4.  **Simulation:** Use a simulator to build and test your circuit (Schematic or VHDL code). Provide a screenshot of your working simulation for the case where the robot is to go forward, turn right, turn left and stop.
</div>
</div>
</div>

<style>

.two-cols-header {

  column-gap: 30px; /* Adjust the gap size as needed */

}

</style>



---


### Exercise 2-4: Binary to 7-Segment Display

<div class="grid grid-cols-2 gap-8">

<div class="text-sm pt-5">
A 7-segment display is a common device for displaying decimal digits. It consists of seven LEDs (segments) arranged in a figure-eight pattern. Each segment can be individually turned on or off to form different characters.



<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/7_Segment_Display_with_Labeled_Segments.svg/150px-7_Segment_Display_with_Labeled_Segments.svg.png" class="mx-auto w-25" />
<p class="text-sm text-center">Figure 2-21. A Seven Segment LEDs.</p>

Your task is to design a decoder that takes a 4-bit binary-coded decimal (BCD) input (`b3`, `b2`, `b1`, `b0`) and outputs the signals to control the seven segments (`a`, `b`, `c`, `d`, `e`, `f`, `g`) to display the corresponding decimal digit (0-9). For this exercise, assume the display is **common anode**, meaning a segment lights up when its control signal is **LOW (0)**.
</div>

<div class="text-sm pt-4">

#### **Tasks:**
1.  **Truth Table:** Create a truth table with the 4-bit BCD input and the 7-segment outputs. For BCD values from 10 to 15, the outputs can be treated as "don't cares" (X).
2.  **Boolean Expressions:** Write the simplified Sum-of-Products (SOP) Boolean expression for the seven segments: segment **`a`** to segment **`g`**. You will need to use Karnaugh maps (K-maps) to simplify these expressions.<br> *Hint: Using don't cares will significantly simplify your logic.*
3.  **Circuit Diagram:** Draw the logic circuit for just the **`a`** segment based on your simplified expression.
4.  **Simulation:** Implement your circuit for the **`a`** segment to **`g`** segment in a simulator. Provide a screenshot showing that the circuit correctly outputs the digit `0` to `9`.
</div>
</div>