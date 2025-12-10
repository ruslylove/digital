---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 7 - Registers and Counters
---

# Lecture 7: Registers and Counters
{{ $slidev.configs.subject }}


{{ $slidev.configs.author }}
---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="2"/>

---

## Registers

A **register** is a group of flip-flops, with each flip-flop capable of storing one bit of information.

*   An *n-bit* register consists of *n* flip-flops and can store an *n-bit* binary word.
*   In addition to the flip-flops, registers may have combinational gates that control how and when new information is transferred into the register.

<img src="/4bit_register_diagram.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="4-bit Register">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-1: 4-bit Register built from D Flip-Flops</div>

---

## Register with Parallel Load

Loading a register means transferring new information into it. If all bits are transferred simultaneously, it's a **parallel load**.

*   A `Load` control input determines the register's operation.
*   **If `Load = 1`:** The data from the input lines `I₀-I₃` is transferred into the flip-flops on the next clock edge.
*   **If `Load = 0`:** The inputs are blocked, and the flip-flops retain their current value (feedback path).

<img src="/4bit_register_parallel_load.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="4-bit Register with Parallel Load">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-2: 4-bit Register with Parallel Load</div>


---

## Shift Registers

A **shift register** is a register capable of shifting its stored binary information in one or both directions.

*   The simplest shift register consists of a chain of flip-flops, where the output of one is connected to the input of the next.
*   All flip-flops share a common clock.
*   On each clock pulse, data is shifted one position down the line.

<img src="/4bit_shift_register.svg" class="rounded-lg bg-white p-4 w-full" alt="4-bit Shift Register">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-3: 4-bit Shift Register</div>


---

## Serial Transfer
<div class="grid grid-cols-2 gap-8">

<div>

In a **serial transfer**, information is moved one bit at a time.



*   The source register is shifted to move bits out of its serial output.
*   The destination register is shifted to accept bits at its serial input.
*   After *n* clock pulses, the *n-bit* transfer is complete.

<img src="/serial_transfer.svg" class="rounded-lg bg-white p-4 w-80 mx-auto" alt="Serial Transfer Example">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-4: Serial Transfer from Register A to Register B</div>

</div>

<div>

<img src="/serial_transfer_timing.svg" class="rounded-lg bg-white p-4 w-full" alt="Timing Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-5: Timing Diagram for Serial Transfer</div>


<div class="mt-4 text-sm">
$$
\begin{array}{|c|c|c|c|}
\hline
\text{Timing Pulse} & \text{Serial Output} & \text{Register A} & \text{Register B} \\
\hline
\text{Initial} & - & 1011 & 0000 \\
T_1 & 1 & 1101 & 1000 \\
T_2 & 1 & 1110 & 1100 \\
T_3 & 0 & 0111 & 0110 \\
T_4 & 1 & 1011 & 1011 \\
\hline
\end{array}
$$
<div class="text-center text-sm opacity-50 mt-1">Table 7-1: Serial Transfer Example (A=1011)</div>
</div>


</div>

</div>

---
layout: two-cols-header
---

## Serial Adder

A serial adder is a sequential circuit that adds two binary numbers one bit at a time.

:: left ::
*   It uses two shift registers to hold the numbers to be added.
*   A single full adder (FA) performs the addition.
*   A D flip-flop is used to store the carry-out from one bit position and use it as the carry-in for the next.



:: right ::

<img src="/serial_adder.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Serial Adder with D Flip-Flop">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-6: Serial Adder using a Full Adder and D Flip-Flop</div>


---

### Serial Adder Operation Example

<div class="text-sm">

Let's trace the operation for **A = 1001** (9) and **B = 0011** (3).  
The Sum should be **1100** (12).

$$
\begin{array}{|c|c|c|c|c|c|c|}
\hline
\text{Time} & \text{Shift Current} & \text{Shift Next} & \text{Reg A (Augend)} & \text{Reg B (Addend)} & \text{Full Adder inputs} & \text{Output} \\
\text{Pulse} & \text{State} & \text{State} & Q_3 Q_2 Q_1 Q_0 & Q_3 Q_2 Q_1 Q_0 & x \quad y \quad C_{in} & S \quad C_{out} \\
\hline
\text{Initial} & - & - & 1 \ 0 \ 0 \ 1 & 0 \ 0 \ 1 \ 1 & - \quad - \quad 0 & - \quad - \\
T_1 & 1 & 0 & 0 \ 1 \ 0 \ 0 & 1 \ 0 \ 0 \ 1 & 1 \quad 1 \quad 0 & 0 \quad 1 \\
T_2 & 0 & 1 & 0 \ 0 \ 1 \ 0 & 1 \ 1 \ 0 \ 0 & 0 \quad 1 \quad 1 & 0 \quad 1 \\
T_3 & 1 & 0 & 1 \ 0 \ 0 \ 1 & 0 \ 1 \ 1 \ 0 & 0 \quad 0 \quad 1 & 1 \quad 0 \\
T_4 & 0 & 0 & 1 \ 1 \ 0 \ 0 & 0 \ 0 \ 1 \ 1 & 1 \quad 0 \quad 0 & 1 \quad 0 \\
\hline
\text{Final} & - & - & \mathbf{1 \ 1 \ 0 \ 0} & 0 \ 0 \ 1 \ 1 & - \quad - \quad - & - \quad - \\
\hline
\end{array}
$$

*   Initially, $C_{in}$ (from D Flip-Flop) is cleared to 0.
*   At each clock pulse ($T_1 \dots T_4$), the LSBs are added with $C_{in}$.
*   The Sum ($S$) is shifted into the MSB of Register A.
*   Register B is rotated (circulated) so its value is preserved.
*   $C_{out}$ is stored in the D Flip-Flop for the next step.

</div>


---
layout: two-cols-header
---

## Universal Shift Register

<div class="text-base">

A **universal shift register** is a versatile register with multiple modes of operation. It combines the features of parallel load, shift-right, and shift-left into a single unit.

</div>

:: left ::

<div class="text-sm">

### Common Capabilities
*   **Clear:** Reset all flip-flops to 0.
*   **Shift-Right:** Shift data from left to right.
*   **Shift-Left:** Shift data from right to left.
*   **Parallel Load:** Load all bits simultaneously from parallel inputs.
*   **No Change:** Hold the current data.

A mode control input (e.g., $s_1s_0$) selects the operation.

$$
\begin{array}{|cc|l|cccc|}
\hline
\textbf{s}_1 & \textbf{s}_0 & \textbf{Operation} & \textbf{A}_3^+ & \textbf{A}_2^+ & \textbf{A}_1^+ & \textbf{A}_0^+ \\
\hline
0 & 0 & \text{No Change} & A_3 & A_2 & A_1 & A_0 \\
0 & 1 & \text{Shift Right} & \text{SIR} & A_3 & A_2 & A_1 \\
1 & 0 & \text{Shift Left} & A_2 & A_1 & A_0 & \text{SIL} \\
1 & 1 & \text{Parallel Load} & I_3 & I_2 & I_1 & I_0 \\
\hline
\end{array}
$$
<div class="text-center text-sm opacity-50 mt-1">Table 7-2: 4-Bit Universal Shift Register Function Table</div>

</div>

:: right ::

<img src="/universal_shift_register_block.svg" class="rounded-lg bg-white p-4" alt="4-bit Universal Shift Register Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-7: Block Diagram of 4-Bit Universal Shift Register</div>

---

### 4-Bit Universal Shift Register

The operation is selected by inputs $s_1$ and $s_0$. A 4x1 MUX is used for each flip-flop to select the appropriate input for the next state.


<img src="/universal_shift_register.svg" class="rounded-lg bg-white p-4 w-full" alt="4-Bit Universal Shift Register">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-8: 4-Bit Universal Shift Register</div>


---

### VHDL Implementation

**universal_shift_register.vhd**

```vhdl {*}{maxHeight:'380px',lines:true}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity universal_shift_register is
    port ( CLK, CLR      : in  std_logic;
           S            : in  std_logic_vector(1 downto 0); -- Mode select
           P_IN         : in  std_logic_vector(3 downto 0); -- Parallel input
           SL_IN, SR_IN : in  std_logic;                     -- Serial inputs
           Q_OUT        : out std_logic_vector(3 downto 0) );
end universal_shift_register;

architecture behavioral of universal_shift_register is
    signal reg_val : std_logic_vector(3 downto 0);
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            reg_val <= (others => '0');
        elsif rising_edge(CLK) then
            case S is
                when "00" => reg_val <= reg_val; -- No change
                when "01" => reg_val <= SR_IN & reg_val(3 downto 1); -- Shift Right
                when "10" => reg_val <= reg_val(2 downto 0) & SL_IN; -- Shift Left
                when "11" => reg_val <= P_IN; -- Parallel Load
                when others => reg_val <= reg_val;
            end case;
        end if;
    end process;
    Q_OUT <= reg_val;
end behavioral;
```

---
layout: two-cols-header
---

## Counters

A **counter** is a register that goes through a predetermined sequence of states upon the application of input pulses.

*   The input pulses are often clock pulses.
*   The sequence of states can be a binary count or any other sequence.

:: left ::

### Categories of Counters
*   **Ripple Counters (Asynchronous):** The flip-flop output transition serves as the clock for the next flip-flop. No common clock pulse.
*   **Synchronous Counters:** All flip-flops are triggered by a common clock pulse.

:: right ::

<img src="/counter_block.svg" class="rounded-lg bg-white p-4 w-100 mx-auto mt-4" alt="General Counter Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-9: General n-Bit Counter Block Diagram</div>
---

## Ripple Counters (Asynchronous)

In a ripple counter, the clock is applied only to the first flip-flop. The output of each flip-flop is connected to the clock input of the next.

*   This creates a "rippling" effect as the state change propagates through the chain of flip-flops.
*   Simple to construct, but slower than synchronous counters due to the cumulative propagation delay.

<img src="/4bit_ripple_counter.svg" class="rounded-lg bg-white mt-4 p-4 w-190 mx-auto" alt="4-bit Ripple Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-10: 4-Bit Binary Ripple Counter using T Flip-Flops</div>


---
layout: two-cols-header
---

## Characteristics of Asynchronous Counters

The fundamental characteristic of ripple counters is that flip-flops change state one after another, not simultaneously.

:: left ::

<div class="text-base">

### Propagation Delay
*   Each flip-flop has a propagation delay ($t_{pd}$).
*   In a ripple counter, these delays accumulate.
*   For an *n-bit* counter, the total settling time is $n \times t_{pd}$.
*   **Glitches**: Decoding logic connected to the counter outputs might see invalid intermediate states (glitches) while the counter is "rippling" to the final state.

### Frequency Limitation
*   The clock frequency is limited by the total propagation delay.
*   $f_{clk} < \frac{1}{n \times t_{pd}}$

</div>

:: right ::

<img src="/4bit_ripple_counter_timing.svg" class="rounded-lg bg-white p-2 w-100 mx-auto" alt="Timing Diagram of Ripple Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-11: Timing Diagram showing Accumulation Delay</div>

---
layout: two-cols-header
---

## BCD Ripple Counter

A BCD counter counts from 0 to 9 (0000 to 1001) and then resets to 0.

:: left ::

*  BCD counters are essential for digital systems that interface with human users, such as digital clocks and voltmeters, where data must be displayed in decimal format.
*   They simplify the conversion from binary to 7-segment display formats.  
*   It can be constructed from a 4-bit binary ripple counter by modifying the interconnections and logic to skip states 10 to 15.



:: right ::

<img src="/bcd_state_diagram.svg" class="rounded-lg bg-white p-4 w-85 mx-auto" alt="State Diagram of BCD Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-12: State Diagram of BCD Counter</div>




---

*   The J and K inputs are controlled to force the transition from **1001** (9) back to **0000** (0).
    *   **Q1 Control:** The J input of the Q1 flip-flop is connected to $\overline{Q_3}$. When the counter reaches 1000 ($Q_3=1$), $J=0$, preventing Q1 from toggling to 1 on the next clock pulse.
    *   **Q3 Control:** The J input of the Q3 flip-flop is connected to $Q_2 \cdot Q_1$. This ensures Q3 only toggles to 1 when the count transitions from 0111 (7) to 1000 (8).
<div class="my-8"></div>

<img src="/bcd_ripple_counter.svg" class="rounded-lg bg-white p-4 w-full" alt="BCD Ripple Counter Logic Circuit">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-13: BCD Ripple Counter Logic Circuit</div>

---

## Synchronous Counters

In a **synchronous counter**, all flip-flops are triggered simultaneously by a common clock signal.

*   The decision of whether a flip-flop should toggle or not is determined by combinational logic connected to its J and K (or T) inputs.
*   This design avoids the cumulative delay of ripple counters, making them faster and more suitable for high-frequency applications.
*   The design follows the standard procedure for synchronous sequential circuits.

<img src="/4bit_synchronous_counter.svg" class="rounded-lg bg-white p-4 w-full mt-4" alt="4-bit Synchronous Binary Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-14: 4-Bit Synchronous Binary Counter</div>


---
layout: two-cols-header
---

## Up-Down Binary Counter

An up-down counter is capable of counting in both ascending and descending order, controlled by an `Up` and `Down` input.

:: left ::

*   When `Up=1`, the circuit counts up.
*   When `Down=1`, the circuit counts down.
*   The logic for the T input of each flip-flop is modified to handle both counting directions.
    *   **Up-count:** A flip-flop `Aᵢ` toggles if all lower-order bits `Aᵢ₋₁...A₀` are 1.
    *   **Down-count:** A flip-flop `Aᵢ` toggles if all lower-order bits `Aᵢ₋₁...A₀` are 0.

:: right ::

<div class="flex justify-center mt-2">
    <img src="/4bit_up_down_counter_state_diagram.svg" class="rounded-lg bg-white w-80" alt="State Diagram of 4-bit Up-Down Counter">
</div>
<div class="text-center text-sm opacity-50 mt-2">Figure 7-15: State Diagram of 4-Bit Up/Down Counter</div>



---

<img src="/4bit_up_down_counter.svg" class="rounded-lg bg-white p-4 w-full" alt="4-bit Up-Down Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-16: 4-Bit Synchronous Up/Down Binary Counter</div>



---

## Counter with Parallel Load

Counters used in digital systems often require both counting and parallel loading capabilities.

*   This allows the counter to be preset to a specific starting value.
*   Control inputs like `Load` and `Count` determine the operation on each clock edge.

### Function Table

<div class="flex justify-center my-4">
$$
\begin{array}{|c|c|c|c|l|}
\hline
\text{Clear} & \text{CLK} & \text{Load} & \text{Count} & \text{Function} \\
\hline
0 & X & X & X & \text{Clear to 0} \\
1 & \uparrow & 1 & X & \text{Load inputs} \\
1 & \uparrow & 0 & 1 & \text{Count next binary state} \\
1 & \uparrow & 0 & 0 & \text{No change} \\
\hline
\end{array}
$$
</div>
<div class="text-center text-sm opacity-50 mb-4">Table 7-3: Function Table for 4-Bit Counter with Parallel Load</div>

---

<img src="/counter_parallel_load.svg" class="rounded-lg bg-white p-4 w-125 mx-auto" alt="4-bit Counter with Parallel Load">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-17: 4-Bit Counter with Parallel Load</div>



---

### VHDL Implementation

**counter_parallel_load.vhd**
```vhdl {*}{maxHeight:'380px',lines:true}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_parallel_load is
    port ( CLK, CLR, LOAD, COUNT : in  std_logic;
           P_IN                  : in  std_logic_vector(3 downto 0);
           Q_OUT                 : out std_logic_vector(3 downto 0) );
end counter_parallel_load;

architecture behavioral of counter_parallel_load is
    signal count_val : unsigned(3 downto 0);
begin
    process(CLK, CLR)
    begin
        if CLR = '1' then
            count_val <= (others => '0');
        elsif rising_edge(CLK) then
            if LOAD = '1' then
                count_val <= unsigned(P_IN);
            elsif COUNT = '1' then
                count_val <= count_val + 1;
            end if;
        end if;
    end process;
    Q_OUT <= std_logic_vector(count_val);
end behavioral;
```

---

## Modulo-N Counter (Divide-by-N)
*   A counter that goes through a repeated sequence of *N* states. The counter "divides" the input clock frequency by *N*.
*   A BCD counter is a Modulo-10 counter.
*   Can be designed to follow any arbitrary sequence.

<img src="/modulo_n_counter.svg" class="rounded-lg bg-white p-4 w-120 mx-auto mt-4" alt="Modulo-N Counter Block Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-18: Modulo-N Counter Block Diagram</div>

---

### BCD (Modulo-10) Counter    

<div class="text-base">

Two common approaches to implement a BCD counter using a 4-bit binary counter with parallel load:

*   **Using Synchronous Load:** Detect the count of **9 (1001)**. On the next clock edge, load **0000** into the counter.
*   **Using Asynchronous Clear:** Detect the count of **10 (1010)**. This immediately resets the counter to **0000**.
</div>

<div class="grid grid-cols-2 gap-4 mt-4">

<div class="text-center">
<img src="/bcd_counter_sync_load.svg" class="rounded-lg bg-white p-4 w-90" alt="BCD Counter Sync Load">
<div class="text-sm opacity-50 mt-2">Figure 7-19: Using Synchronous Load (Detect 9)</div>
</div>

<div class="text-center">
<img src="/bcd_counter_async_clear.svg" class="rounded-lg bg-white p-4 w-90 mt-15" alt="BCD Counter Async Clear">
<div class="text-sm opacity-50 mt-2">Figure 7-20: Using Asynchronous Clear (Detect 10)</div>
</div>

</div>


---

## Self-Correcting Counter
*   A counter with unused states can sometimes enter one of these states due to noise.
*   A self-correcting design ensures that if the counter enters an unused state, it will eventually transition back to a valid state.


<div class="grid grid-cols-2 gap-8 items-center">

<div class="text-center">
<img src="/self_correcting_counter.svg" class="rounded-lg bg-white p-4 w-70 mx-auto" alt="State Diagram of Self-Correcting Counter">
<div class="text-sm opacity-50 mt-2">Figure 7-21: State Diagram of Self-Correcting Counter (Modulo-6)</div>
</div>

<div class="text-xl">
$$
\begin{array}{|ccc|ccc|}
\hline
Q_2 & Q_1 & Q_0 & Q_2^+ & Q_1^+ & Q_0^+ \\
\hline
0 & 0 & 0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0 & 1 & 0 \\
0 & 1 & 0 & 0 & 1 & 1 \\
0 & 1 & 1 & 1 & 0 & 0 \\
1 & 0 & 0 & 1 & 0 & 1 \\
1 & 0 & 1 & 0 & 0 & 0 \\
\hline
1 & 1 & 0 & 0 & 0 & 0 \\
1 & 1 & 1 & 0 & 0 & 0 \\
\hline
\end{array}
$$
<div class="text-center text-sm opacity-50 mt-2">Table 7-4: State Table with Self-Correction</div>
</div>

</div>



---

## Ring Counter

A **ring counter** is a circular shift register where only one flip-flop is set at any particular time; all others are cleared.

*   It is initialized by setting one flip-flop to 1 (e.g., `1000`).
*   The single '1' bit is then shifted from one flip-flop to the next on each clock pulse, creating a sequence of timing signals.
*   An *n-bit* ring counter produces *n* distinct states/timing signals.

<div class="grid grid-cols-2 gap-8 items-center">

<div>
<img src="/ring_counter.svg" class="rounded-lg bg-white p-4 mx-auto" alt="Ring Counter Diagram">
<p class="text-sm opacity-50 text-center">Figure 7-22: Ring Counter Diagram</p>

</div>

<div>

$$
\begin{array}{|c|cccc|}
\hline
\text{Clock} & T_0 & T_1 & T_2 & T_3 \\
\hline
t_0 & 1 & 0 & 0 & 0 \\
t_1 & 0 & 1 & 0 & 0 \\
t_2 & 0 & 0 & 1 & 0 \\
t_3 & 0 & 0 & 0 & 1 \\
t_4 & 1 & 0 & 0 & 0 \\
\hline
\end{array}
$$

</div>
</div>
---

### Ring Counter Timing Signals

<img src="/timing_signals.svg" class="rounded-lg bg-white p-4 w-200 mt-4" alt="Timing Signals">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-23: Timing Signals</div>
---

## Application: Generating Timing Signals

Counters are frequently used to generate timing signals that control the sequence of operations in a digital system.

<div class="grid grid-cols-2 gap-8">

<div>

### Method 1: Ring Counter
*   Uses *N* flip-flops for *N* timing signals.
*   Simple, requires no decoder.

<img src="/ring_counter_generator.svg" class="rounded-lg bg-white p-4 w-90 mx-auto" alt="Ring Counter Generator">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-24: Ring Counter Timing Generator</div>

</div>

<div>

### Method 2: Counter + Decoder
*   Uses an *n-bit* counter and an *n-to-2ⁿ* decoder to generate *N = 2ⁿ* timing signals.
*   More efficient in terms of flip-flop count for a large number of signals.

<img src="/counter_decoder_block.svg" class="rounded-lg bg-white p-4 mt-3 mx-auto" alt="Counter and Decoder">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-25: Counter and Decoder Block</div>

</div>
</div>



---


## Lecture 7 Summary

*   **Registers:** Groups of flip-flops storing binary information. Parallel load capabilities allow simultaneous data transfer.
*   **Shift Registers:** Capable of shifting data serially. Universal shift registers combine serial/parallel operations.
*   **Counters:**
    *   **Ripple:** Asynchronous, simple but slower due to propagation delay.
    *   **Synchronous:** Common clock, faster, requires more logic.
    *   **Up/Down:** Count in both directions.
    *   **Modulo-N:** Reset at a specific count.
    *   **Ring Counter:** One-hot encoding, useful for timing signals.

---
layout: section
---

## Lecture 7 Exercises

---


### Exercise 7-1: Register Design

**Design a 4-bit Register with the following specifications:**

*   **Inputs:** Clock `CLK`, Clear `CLR`, Load `LD`, Increment `INC`, Input Data `I[3:0]`.
*   **Operations:**
    *   `CLR = 1`: Reset to `0000`.
    *   `LD = 1`: Load `I` into the register (priority over `INC`).
    *   `INC = 1`: Increment value by 1.
    *   Otherwise: Hold current value.

**Task:** Write the VHDL Behavioral Architecture for this register.

---

### Exercise 7-2: Shift Register Analysis

**Given a 4-bit Universal Shift Register (Table 7-2) initially containing `1010`:**

Determine the content of the register after the following sequence of operations:

1.  **Shift Right** (serial input `SIR = 1`).
2.  **Shift Left** (serial input `SIL = 0`).
3.  **No Change**.
4.  **Parallel Load** (`I = 1100`).

---

### Exercise 7-3: Counter Design

**Design a Synchronous Modulo-6 Counter using JK Flip-Flops.**

*   **Sequence:** 0, 1, 2, 3, 4, 5, 0, ...
*   **Task:** Determine the J and K input equations for the flip-flops.

**Hint:**
1.  Draw the State Diagram.
2.  Create the Excitation Table.
3.  Simplify maps for J and K inputs.

---

### Exercise 7-4: Timing Diagram

**Draw the timing diagram for a 4-bit Ring Counter.**

*   **Initial State:** `1000` ($Q_3=1, Q_2=0, Q_1=0, Q_0=0$)
*   **Clock:** Show 5 clock pulses.

**Question:**
*   What is the relationship between the frequency of the clock and the frequency of the signal at any single output $Q_i$?
*   How does this differ from a Johnson Counter (Switch-Tail Ring Counter)?
