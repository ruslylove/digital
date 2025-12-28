---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 8 - Finite State Machines
---

# Lecture 8: Finite State Machines
{{ $slidev.configs.subject }}


{{ $slidev.configs.author }}
---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---


## Finite State Machine (FSM): Recall

<div class="grid grid-cols-2 gap-8 text-base">

<div>

A **Finite State Machine (FSM)** is a computation model used to design sequential circuits.
*   It consists of a finite number of **states**.
*   It transitions between states based on **inputs** and the **current state**.
*   It produces **outputs** based on the state (and potentially inputs).




</div>

<div>


An FSM consists of three main parts:
1.  **Next State Logic:** Combinational logic that determines the next state.
2.  **State Memory:** Flip-flops that store the current state.
3.  **Output Logic:** Combinational logic that generates outputs.



</div>

</div>

<img src="/fsm_general_block_diagram.svg" class="rounded-lg bg-white p-4 w-180 mx-auto mt-4" alt="FSM General Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-1: General Block Diagram of an FSM</div>

---

## FSM Models: Moore vs. Mealy

There are two primary types of FSMs, distinguished by how their outputs are generated.

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### Moore Machine
Output depends **only on the current state**.
*   $Output = f(Current\_State)$
*   Outputs change synchronously with state transitions.
*   **Pros:** Simpler output logic, safer glitch-free outputs.

<img src="/moore_block.svg" class="rounded-lg bg-white p-2 mt-2 w-full" alt="Moore Machine Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-2: Moore Machine Diagram</div>

</div>

<div>

### Mealy Machine
Output depends on **current state AND current inputs**.
*   $Output = f(Current\_State, Inputs)$
*   Outputs can change immediately when inputs change.
*   **Pros:** Fewer states often needed, faster response.

<img src="/mealy_block.svg" class="rounded-lg bg-white p-2 mt-2 w-full" alt="Mealy Machine Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-3: Mealy Machine Diagram</div>

</div>
</div>

---
layout: two-cols-header
---

## FSM Analysis Procedure

**Analysis** is determining the behavior of a given sequential circuit.

:: left ::

### Steps:
1.  **Determine Logic Equations:**
    *   Find Next State equations ($D_i, J_i, K_i, T_i$) from the circuit.
    *   Find Output equations ($Z$).
2.  **Construct State Transition Table:**
    *   List all possible Present States and Inputs.
    *   Calculate Next States and Outputs.
3.  **Draw State Diagram:**
    *   Represent states as nodes.
    *   Represent transitions as directed edges labeled with `Input / Output`.

:: right ::

<img src="/analysis_example_fsm.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Sequential Circuit for Analysis">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-2: Example Circuit</div>

**Equations:**
*   $D_A = A \oplus x \oplus y$
*   $z = A \cdot x$



---

**State Table:**

<div class="text-sm">

$$
\begin{array}{|c|c|c|c|c|}
\hline
\text{PS } (A) & \text{Inputs } (x \ y) & D_A = A \oplus x \oplus y & \text{NS } (A_{next}) & \text{Output } (z = A \cdot x) \\
\hline
0 & 0 \quad 0 & 0 & 0 & 0 \\
0 & 0 \quad 1 & 1 & 1 & 0 \\
0 & 1 \quad 0 & 1 & 1 & 0 \\
0 & 1 \quad 1 & 0 & 0 & 0 \\
1 & 0 \quad 0 & 1 & 1 & 0 \\
1 & 0 \quad 1 & 0 & 0 & 0 \\
1 & 1 \quad 0 & 0 & 0 & 1 \\
1 & 1 \quad 1 & 1 & 1 & 1 \\
\hline
\end{array}
$$

</div>

**State Diagram:**

<img src="/analysis_example_state_diagram.svg" class="rounded-lg bg-white p-4 w-90 mx-auto" alt="Analysis Example State Diagram">



---

## FSM Synthesis (Design) Procedure

**Synthesis** is the process of creating a circuit from a description of its behavior.

1.  **Understand specifications:** Define inputs, outputs, and start state.
2.  **Create State Diagram:** Model the behavior.
3.  **create State Table:** Tabulate transitions.
4.  **State Minimization (Optional):** Remove redundant states to simplify logic.
5.  **State Assignment:** Assign binary codes to states.
6.  **Flip-Flop Selection:** Choose D, JK, or T flip-flops.
7.  **Derive Logic Equations:** Use K-maps to find equations for flip-flop inputs and FSM outputs.
8.  **Draw Logic Diagram.**

---
hide: true
---

## Design Example

**Problem:** Design a generic FSM.

<div class="grid grid-cols-2 gap-8 text-base">

<div>

### 1. State Diagram
Let's assume a design requirement leads to this diagram:

<img src="/fsm_example_1.svg" class="rounded-lg bg-white p-4 w-50 mx-auto" alt="State Diagram Example">

### 2. State Table

$$
\begin{array}{|c|c|c|}
\hline
\text{Present State} & \text{Input} & \text{Next State} \\
\hline
S_0 & 0 & S_0 \\
S_0 & 1 & S_1 \\
S_1 & 0 & S_0 \\
S_1 & 1 & S_1 \\
\hline
\end{array}
$$

</div>

<div>

### 3. State Equations

*   Assume State Encoding: $S_0 = 0, S_1 = 1$. Let $A$ be the state variable.
*   From the table: $A_{next} = 1$ when $x=1$; $A_{next} = 0$ when $x=0$.
*   Equation: $D_A = A_{next} = x$

### 4. Logic Diagram

<img src="/fsm_example_1_circuit.svg" class="rounded-lg bg-white p-4 w-50 mx-auto" alt="Design Example Logic Circuit">

</div>

</div>

---

## Design Example 1: 2-Bit Up/Down Counter

**Problem:** Design a synchronous 2-bit counter that counts up when input $x=1$ and down when $x=0$.

<div class="grid grid-cols-2 gap-8 text-sm">
<div>

### 1. State Diagram & Table
*   **States:** 00, 01, 10, 11
*   **Transitions:**
    *   $x=1$: $00 \to 01 \to 10 \to 11 \to 00$
    *   $x=0$: $00 \to 11 \to 10 \to 01 \to 00$



**State Table**


$$
\begin{array}{|c|c|c|cc|cc|}
\hline
\text{PS } (Q_1 Q_0) & \text{Input } (x) & \text{NS } (Q_1^+ Q_0^+) & J_1 & K_1 & J_0 & K_0 \\
\hline
0 \quad 0 & 0 & 1 \quad 1 & 1 & X & 1 & X \\
0 \quad 0 & 1 & 0 \quad 1 & 0 & X & 1 & X \\
0 \quad 1 & 0 & 0 \quad 0 & 0 & X & X & 1 \\
0 \quad 1 & 1 & 1 \quad 0 & 1 & X & X & 1 \\
1 \quad 0 & 0 & 0 \quad 1 & X & 1 & 1 & X \\
1 \quad 0 & 1 & 1 \quad 1 & X & 0 & 1 & X \\
1 \quad 1 & 0 & 1 \quad 0 & X & 0 & X & 1 \\
1 \quad 1 & 1 & 0 \quad 0 & X & 1 & X & 1 \\
\hline
\end{array}
$$

</div>
<div>

**Logic Equations (JK Flip-Flops)**

We use K-maps to solve for $J$ and $K$ inputs:

<img src="/up_down_counter_kmaps.svg" class="rounded-lg bg-white w-100 mx-auto" alt="K-Maps for Up/Down Counter">

</div>

</div>

---

<div class="grid grid-cols-3 gap-8 text-sm">
<div>

From the K-maps:
*   **For $Q_0$:** All entries are 1 or X.
    *   $J_0 = 1, \quad K_0 = 1$
*   **For $Q_1$:**
    *   $J_1 = x \odot Q_0 = \overline{x \oplus Q_0}$
    *   $K_1 = x \odot Q_0 = \overline{x \oplus Q_0}$


### 2. Logic Diagram

Based on the derived equations:
*   $FF_0$: $J=1, K=1$
*   $FF_1$: $J=K= \overline{x \oplus Q_0}$

</div>
<div class="col-span-2">

<img src="/up_down_counter_circuit.svg" class="rounded-lg bg-white p-4 w-full mx-auto mt-4" alt="2-Bit Up/Down Counter Logic Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-3: Logic Diagram of 2-Bit Up/Down Counter</div>

</div>
</div>



---
layout: two-cols-header
---

## Design Example 2: Car Security System
:: left ::
**Problem:** Design a controller for a car security system.
*   **Inputs:** `Master` switch (M), `Door` sensor (D), `Vibration` sensor (V).
*   **Outputs:** `Alarm` (A).
*   **Behavior:**
    *   System is initially **Disarmed** (No Siren).
    *   If M=1, go to **Armed** (Siren OFF).
    *   If Armed (M=1) AND (Door=1 OR Vibration=1), go to **Siren** state.
    *   Once in **Siren** state, stay there until M=0 (Reset).

::right::

### State Diagram

<img src="/car_security_fsm.svg" class="rounded-lg bg-white p-4 w-70 mx-auto" alt="Car Security System State Diagram">



### State Table

$$
\begin{array}{|c|ccc|c|c|}
\hline
\text{State } Q & M & D & V & \text{Next State } Q_{next} & \text{Output } A \\
\hline
0 \text{ (No Siren)} & 0 & X & X & 0 & 0 \\
0 \text{ (No Siren)} & 1 & 0 & 0 & 0 & 0 \\
0 \text{ (No Siren)} & 1 & 1 & X & 1 & 0 \\
0 \text{ (No Siren)} & 1 & X & 1 & 1 & 0 \\
\hline
1 \text{ (Siren)} & 0 & X & X & 0 & 1 \\
1 \text{ (Siren)} & 1 & X & X & 1 & 1 \\
\hline
\end{array}
$$

---
layout: two-cols-header
---

### Logic Synthesis

:: left ::

We derive the Next State equation from Karnaugh maps:

<img src="/car_security_kmaps.svg" class="rounded-lg bg-white p2 w-60 mx-auto" alt="Car Security K-Maps">

**Equation:**
*   $Q_{next} = M \cdot (Q + D + V)$
*   $A = Q$

:: right ::

### Logic Diagram

<img src="/car_security_circuit.svg" class="rounded-lg bg-white p-4 w-120 mx-auto" alt="Car Security Logic Circuit">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-4: Car Security Logic Diagram</div>

---

### VHDL Implementation (Logic)

<div class="grid grid-cols-2 gap-8">

```vhdl{*}{maxHeight:'420px',lines:true}
entity Car_Security is
    Port ( clk, reset : in std_logic;
           M, D, V : in std_logic;
           A : out std_logic);
end Car_Security;

architecture Behavioral of Car_Security is
    type state_type is (No_Siren, Siren);
    signal current_state, next_state : state_type;
begin
    -- State Register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= No_Siren;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State and Output Logic
    process(current_state, M, D, V)
    begin
        -- Default assignments
        next_state <= current_state; 
        A <= '0';
        
        case current_state is
            when No_Siren =>
                if M='1' and (D='1' or V='1') then 
                    next_state <= Siren; 
                end if;
            when Siren =>
                A <= '1';
                if M='0' then 
                    next_state <= No_Siren; 
                end if;
        end case;
    end process;
end Behavioral;
```

<div class="">

*   **Entity:** Defines inputs (`M`, `D`, `V`) and output (`A`).
*   **State Enumeration:** `type state_type` improves readability by naming states (`No_Siren`, `Siren`) instead of finding binary codes manually.
*   **Two-Process Method:**
    1.  **Sequential Process:** Updates `current_state` on clock edges.
    2.  **Combinational Process:** Calculates `next_state` and outputs based on `current_state` and inputs.

</div>

</div>

---

## Design Example 3: Modulo-6 Up-Counter

**Problem:** Design a synchronous count-up counter that counts from 0 to 5 and repeats.

<div class="grid grid-cols-2 gap-8">
<div>

### 1. State Diagram & Table
*   **States:** 000, 001, 010, 011, 100, 101.
*   **Transitions:** $0 \to 1 \to 2 \to 3 \to 4 \to 5 \to 0$.

<img src="/modulo_6_counter.svg" class="rounded-lg bg-white p-4 w-full mx-auto mt-4" alt="Modulo-6 Up-Counter State Diagram">

</div>
<div class="text-sm">

**State Table**
*   **Input:** $C$ (Count Enable)
*   **State:** $Q_2, Q_1, Q_0$
*   **Output:** $Y = 1$ when State = 5 ($101$)

$$
\begin{array}{|c|c|c|c|}
\hline
\text{PS } (Q_2 Q_1 Q_0) & \text{NS } (C=0) & \text{NS } (C=1) & \text{Output } Y \\
\hline
0 \quad 0 \quad 0 & 0 \quad 0 \quad 0 & 0 \quad 0 \quad 1 & 0 \\
0 \quad 0 \quad 1 & 0 \quad 0 \quad 1 & 0 \quad 1 \quad 0 & 0 \\
0 \quad 1 \quad 0 & 0 \quad 1 \quad 0 & 0 \quad 1 \quad 1 & 0 \\
0 \quad 1 \quad 1 & 0 \quad 1 \quad 1 & 1 \quad 0 \quad 0 & 0 \\
1 \quad 0 \quad 0 & 1 \quad 0 \quad 0 & 1 \quad 0 \quad 1 & 0 \\
1 \quad 0 \quad 1 & 1 \quad 0 \quad 1 & 0 \quad 0 \quad 0 & 1 \\
\text{Others} & \text{X X X} & \text{X X X} & \text{X} \\
\hline
\end{array}
$$




</div>
</div>

---
layout: two-cols-header
---

### 2. Logic Synthesis

:: left ::

We assume **D Flip-Flops**.
<img src="/modulo_6_kmaps.svg" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="Modulo-6 K-Maps">

:: right ::

**Equations:**
*   $D_2 = Q_2 Q_0' + Q_2 C' + Q_1 Q_0 C$
*   $D_1 = Q_1 C' + Q_1 Q_0' + \bar{Q_2}\bar{Q_1}Q_0 C$
*   $D_0 = Q_0 \oplus C$
*   $Y = Q_2 Q_1' Q_0$

---

### 3. Logic Diagram

<img src="/modulo_6_circuit.svg" class="rounded-lg bg-white p-4 w-110 mx-auto" alt="Modulo-6 Logic Circuit">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-5: Modulo-6 Counter Logic Diagram</div>

---

**VHDL Implementation**
```vhdl
process(clk, reset)
begin
    if reset='1' then
        count <= "000";
    elsif rising_edge(clk) then
        if C = '1' then
            if count = "101" then
                count <= "000";
            else
                count <= count + 1;
            end if;
        end if;
    end if;
end process;

    -- Output Logic
    Y <= '1' when count = "101" else '0';
```


---

## Design Example 4: One-Shot Circuit

**Problem:** Design a circuit that produces an output pulse $S=1$ for exactly one clock cycle when an input button $B$ is pressed.

*   Debouncing logic is assumed.
*   The circuit waits for $B=1$ to go to a "Pulse" state, then proceeds to a "Wait" state until $B=0$.

<div class="grid grid-cols-2 gap-8 text-base">
<div>

### State Diagram


<img src="/one_shot_fsm.svg" class="rounded-lg bg-white p-4 w-100 mx-auto" alt="One-Shot Circuit State Diagram">



</div>
<div>

*   **S0:** Wait for valid Press ($B=1$).
*   **S1:** Output $S=1$ (Pulse). Immediate transition to S2 on next clock.
*   **S2:** Wait for $B=0$ to transition back to S0.
### State Table

$$
\begin{array}{|c|c|c|c|}
\hline
\text{PS } (Q_1 Q_0) & \text{NS } (B=0) & \text{NS } (B=1) & S (B=1) \\
\hline
\text{S0 (00)} & 00 & 01 & 1 \\
\text{S1 (01)} & 10 & 10 & 0 \\
\text{S2 (10)} & 00 & 10 & 0 \\
\text{Unused (11)} & 00 & 00 & 0 \\
\hline
\end{array}
$$

</div>
</div>

---

### Logic Synthesis

From the Next State table, we derive the K-maps for $D_1, D_0$ and Output $S$. Note that the unused state $11$ resets to $00$.

<img src="/one_shot_kmaps.svg" class="rounded-lg bg-white p-2 w-full mx-auto" alt="One-Shot K-Maps">

**Equations:**
*   $D_1 = Q_1' Q_0 + Q_1 Q_0' B$
*   $D_0 = Q_1' Q_0' B$
*   $S = Q_1' Q_0' B$

---

### Logic Diagram

<img src="/one_shot_circuit.svg" class="rounded-lg bg-white p-4 w-120 mx-auto" alt="One-Shot Logic Circuit">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-6: One-Shot Circuit Logic Diagram</div>

---

### VHDL Implementation

```vhdl {9-29}{maxHeight:'420px',lines:true}
entity One_Shot is
    Port ( clk, reset : in std_logic;
           B : in std_logic;
           S : out std_logic);
end One_Shot;

architecture Behavioral of One_Shot is
    signal Q : std_logic_vector(1 downto 0);
begin
    process(clk, reset)
    begin
        if reset='1' then
            Q <= "00";
        elsif rising_edge(clk) then
            case Q is
                when "00" => -- S0
                    if B='1' then Q <= "01"; end if;
                when "01" => -- S1
                    Q <= "10";
                when "10" => -- S2
                    if B='0' then Q <= "00"; end if;
                when others =>
                    Q <= "00";
            end case;
        end if;
    end process;

    -- Output Logic
    S <= '1' when Q="01" else '0';
end Behavioral;
```


---

## Design Example 5: Simple Microprocessor Control Unit

In this example, we will synthesize an FSM that illustrates what a simple control unit of a microprocessor is like. We start with the state diagram.

<div class="grid grid-cols-2 gap-8 text-base">
<div>

### Specifications
*   **States:** $s_0, s_1, s_2, s_3$
*   **Outputs:** $x, y$
*   **Status Signals:** $Start$, $n=9$

**Transitions:**
*   From $s_0$:
    *   If $Start=1$, take edge $Start$.
    *   Else, take edge $Start'$.
*   From $s_2$:
    *   If $n=9$, take edge $(n=9)$.
    *   Else, take edge $(n=9)'$.

</div>
<div>

<!-- Placeholder for Figure 6.18(a) -->
<img src="/simple_cpu_fsm_example.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Simple CPU FSM">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-7: Control Unit State Diagram</div>

</div>
</div>

---

## Design Example 6: Elevator Controller

**Problem:** Design the FSM controller for a 2-floor elevator.

<div class="grid grid-cols-2 gap-8">
<div>

**Inputs:**
*   $f_1, f_2$: Call buttons (Floor 1, Floor 2). (Combines hall ($f$) and inside ($e$) buttons).
*   $at_1, at_2$: Position sensors (Asserted when elevator is at the respective floor).

**Outputs:**
*   $go_1$: Motor Enable (1 = On, 0 = Off).
*   $go_0$: Direction (0 = Floor 1, 1 = Floor 2).
*   $led_1, led_2$: Floor indicators.



</div>
<div>

<!-- Elevator Setup Illustration -->
<img src="/elevator_setup.svg" class="rounded-lg bg-white p-4 w-full mx-auto mb-4" alt="Elevator System Setup">
<div class="text-center text-sm opacity-50 mt-2 mb-8">Figure 8-8: Elevator System Setup</div>


</div>
</div>

---
layout: two-cols
---


**Operation:**
*   **State 00 (Floor 1):** Idle. If $f_2$ pressed $\to$ State 11.
*   **State 11 (Moving Up):** $go_1=1, go_0=1$. LEDs Off. Wait for $at_2 \to$ State 10.
*   **State 10 (Floor 2):** Idle. If $f_1$ pressed $\to$ State 01.
*   **State 01 (Moving Down):** $go_1=1, go_0=0$. LEDs Off. Wait for $at_1 \to$ State 00.

:: right ::

<!-- Placeholder for Figure 6.19(a) (FSM Diagram) -->
<img src="/elevator_fsm.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Elevator FSM">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-9: Elevator Controller State Diagram</div>

---
layout: two-cols-header
---

### Logic Synthesis

:: left ::

<div class="text-sm pr-2">

**State Table**
$$
\begin{array}{|c|c|c|cc|}
\hline
\text{PS} & \text{Conditions} & \text{NS } (D_1 D_0) & \text{Out } (go_1 go_0 & led_1 led_2) \\
\hline
00 (\text{Flr 1}) & f_2=1 & 11 & 0 \ X & 1 \ 0 \\
 & \text{Others} & 00 & & \\
\hline
11 (\text{Up}) & at_2=1 & 10 & 1 \ 1 & 0 \ 0 \\
 & \text{Others} & 11 & & \\
\hline
10 (\text{Flr 2}) & f_1=1 & 01 & 0 \ X & 0 \ 1 \\
 & \text{Others} & 10 & & \\
\hline
01 (\text{Down}) & at_1=1 & 00 & 1 \ 0 & 0 \ 0 \\
 & \text{Others} & 01 & & \\
\hline
\end{array}
$$
</div>
:: right ::

**Next State K-Maps**
<img src="/elevator_moore_kmaps.svg" class="rounded-lg bg-white p-2 w-full mx-auto" alt="Moore Elevator K-Maps">

**Equations:**
*   $D_1 = Q_1'Q_0' f_2 + Q_1 Q_0 + Q_1 Q_0' f_1'$
*   $D_0 = Q_1'Q_0' f_2 + Q_1 Q_0 at_2' + Q_1 Q_0' f_1 + Q_1' Q_0 at_1'$

---
layout: two-cols-header
---

## Design Example 7: Mealy Elevator Controller

**Problem:** Redesign the elevator controller using a Mealy Machine to reduce the number of states.

:: left ::

### Specifications
*   **States:** Floor 1, Floor 2.
*   **Transitions:** The state only changes when the elevator *arrives* at a floor (`at_x` sensor).
*   **Outputs:** Motor control depends on **Current State** AND **Input Buttons** ($f_x$).

**Advantage:**
*   Reduces states from 4 (Moore) to 2 (Mealy).
*   Simplifies state memory but makes output logic slightly more complex.

:: right ::

### Mealy State Diagram

<img src="/elevator_mealy_fsm.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Mealy Elevator State Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 8-10: Mealy Elevator State Diagram</div>



---
layout: two-cols-header
---

### Logic Synthesis

:: left ::

**State Table (Condensed)**
$$
\begin{array}{|c|c|c|c|}
\hline
\text{PS} & \text{Inputs} & \text{NS } (D) & \text{Out } (led, go) \\
\hline
0 & f_2=1, at_2=1 & 1 & 10, \ 11 (\uparrow) \\
 & \text{Others} & 0 & 10, \ 00 \text{ or } 11 \\
\hline
1 & f_1=1, at_1=1 & 0 & 01, \ 10 (\downarrow) \\
 & \text{Others} & 1 & 01, \ 00 \text{ or } 10 \\
\hline
\end{array}
$$

**Equations:**
*   $D = \overline{Q}(f_2 \cdot at_2) + Q(\overline{f_1 \cdot at_1})$
*   $led_1 = \overline{Q}, \quad led_2 = Q$
*   $go_1 = \overline{Q}f_2 + Q f_1$

:: right ::

**Next State K-Maps**
<img src="/elevator_mealy_kmaps.svg" class="rounded-lg bg-white p-2 w-full mx-auto" alt="Mealy Elevator K-Maps">

---

### VHDL Implementation (Mealy)

```vhdl{*}{maxHeight:'400px',lines:true}
entity Elevator_Mealy is
    Port ( clk, reset : in std_logic;
           f1, f2, at1, at2 : in std_logic;
           go1, go0, led1, led2 : out std_logic);
end Elevator_Mealy;

architecture Behavioral of Elevator_Mealy is
    type state_type is (Floor1, Floor2);
    signal current_state, next_state : state_type;
begin
    -- State Register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= Floor1;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next State and Output Logic
    process(current_state, f1, f2, at1, at2)
    begin
        -- Defaults
        next_state <= current_state;
        go1 <= '0'; go0 <= '0'; -- Motor Off
        led1 <= '0'; led2 <= '0';
        
        case current_state is
            when Floor1 =>
                led1 <= '1';
                if f2 = '1' then
                    go1 <= '1'; go0 <= '1'; -- Move Up
                    if at2 = '1' then
                        next_state <= Floor2;
                    end if;
                end if;
                
            when Floor2 =>
                led2 <= '1';
                if f1 = '1' then
                    go1 <= '1'; go0 <= '0'; -- Move Down
                    if at1 = '1' then
                        next_state <= Floor1;
                    end if;
                end if;
        end case;
    end process;
end Behavioral;
```

---


## VHDL Implementation of FSMs

FSMs are typically implemented in VHDL using **three processes** (or two):

1.  **State Register Process:** Synchronous reset and clock edge detection. Update `current_state` with `next_state`.
2.  **Next State Logic Process:** Combinational process sensitive to `current_state` and inputs. Determines `next_state`.
3.  **Output Logic Process:** Combinational process determining outputs. (Can be merged with Next State logic).

### Template (State Register)

```vhdl
process(clk, reset)
begin
    if reset = '1' then
        current_state <= S0;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;
```

---

### Template (Next State & Output Logic)

```vhdl
process(current_state, input_signal)
begin
    -- Default assignments
    next_state <= current_state;
    output_signal <= '0';
    
    case current_state is
        when S0 =>
            if input_signal = '1' then
                next_state <= S1;
            end if;
        when S1 =>
            -- Logic for S1
            output_signal <= '1'; -- Moore output example
        when others =>
            next_state <= S0;
    end case;
end process;
```


---

## Lecture 8 Summary

*   **Finite State Machines (FSMs)** are accurate models for sequential logic.
*   **Moore vs. Mealy:** Moore outputs depend on state only; Mealy on state and inputs.
*   **Analysis:** Circuit $\to$ State Diagram.
*   **Synthesis:** Specification $\to$ State Diagram $\to$ Logic Circuit.
*   **Optimization:** Reduces hardware cost via state reduction and prudent encoding.
*   **VHDL:** Implemented using standard templates separating sequential (state memory) and combinational (next state/output) logic.


---
layout: section
---

## Lecture 8 Exercises

Here are some exercises to test your understanding of Finite State Machines.

---

### Exercise 8-1: Moore vs. Mealy

**Question:** Identify which of the following block diagrams represents a Moore Machine and which represents a Mealy Machine.

<div class="grid grid-cols-2 gap-8 mt-8">
<div>
<div class="border-2 border-gray-400 p-4 rounded-lg">

Inputs + Present State $\to$ Next State <br>
Present State $\to$ Output
</div>
<div class="mt-2 text-lg font-bold text-center"> (A) </div>
</div>
<div>
<div class="border-2 border-gray-400 p-4 rounded-lg">

Inputs + Present State $\to$ Next State <br>
Inputs + Present State $\to$ Output
</div>
<div class="mt-2 text-lg font-bold text-center"> (B) </div>
</div>
</div>


---

### Exercise 8-2: State Analysis

**Question:** Consider a state machine with one JK Flip-Flop.
*   $J = x$, $K = 1$
*   Current State $Q = 0$
*   Input $x = 1$

What is the Next State ($Q_{next}$)?


---

### Exercise 8-3: Sequence Detection (Overlapping)

**Question:** Draw the State Diagram for a sequence detector that detects the sequence **"110"**.
*   **Overlapping sequences represent valid detection.**
*   Example Input: `0 1 1 0 1 1 0` $\to$ Output: `0 0 0 1 0 0 1`



---

### Exercise 8-4: Sequence Detection (Non-Overlapping)

**Question:** Draw the State Diagram for a sequence detector that detects **"110"** (Non-Overlapping).
*   Example Input: `1 1 0 1 1 0` $\to$ Output: `0 0 1 0 0 1` (Same)
*   Example Input: `1 1 0 1 0`
    *   Overlapping: `...1` at end of first `110` could be start of next.
    *   Non-overlapping: After detection, reset completely to S0.

---

### Exercise 8-5: State Encoding

**Question:** You are designing an FSM with **12 States**.
1.  How many Flip-Flops are needed for **Binary Encoding**?
2.  How many Flip-Flops are needed for **One-Hot Encoding**?


---

### Exercise 8-6: VHDL Syntax

**Question:** Identifying errors. What is missing in the sensitivity list of this VHDL process for a synchronous FSM?

```vhdl
process(clk) -- <== LOOK HERE
begin
    if reset = '1' then
        current_state <= S0;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;
```



---

### Exercise 8-7: State Table Construction

**Question:** Fill in the missing Next State for **State 01** with Input **1** in this counter (Count Up).
*   Sequence: $00 \to 01 \to 10 \to 11 \to 00$

$$
\begin{array}{|c|c|c|}
\hline
\text{PS} & \text{Input} & \text{NS} \\
\hline
01 & 0 \text{ (Hold)} & 01 \\
01 & 1 \text{ (Count)} & \mathbf{?} \\
\hline
\end{array}
$$



---

### Exercise 8-8: Logic Equations

**Question:** From the K-Map below for $D_0$, derive the simplified boolean equation.

<img src="/exercise_8_8_kmap.svg" class="rounded-lg bg-white p-2 w-40 mx-auto" alt="K-Map for Exercise 8-8">




---

### Exercise 8-9: Timing Constraints

**Question:** Which inequality correctly describes the constraint for the maximum fluid clock frequency ($f_{max}$) in an FSM?
1.  $T_{clk} \ge t_{setup} + t_{hold}$
2.  $T_{clk} \ge t_{pcq} + t_{comb} + t_{setup}$
3.  $T_{clk} \ge t_{pcq} + t_{comb} - t_{hold}$



---

### Exercise 8-10: Design Challenge

**Question:** Design a **2-bit Gray Code Counter**.
*   Sequence: $00 \to 01 \to 11 \to 10 \to 00 \dots$
*   Draw the State Diagram on paper.




