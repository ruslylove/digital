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

## Outline

*   Registers
    *   Parallel Load
    *   Shift Registers
    *   Universal Shift Register
*   Serial Transfer & Addition
*   Counters
    *   Ripple Counters (Asynchronous)
    *   Synchronous Counters
    *   Up-Down Counters
    *   Counters with Parallel Load
*   Special Counters
    *   Ring Counter
    *   Johnson Counter

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

## Serial Adder

A serial adder is a sequential circuit that adds two binary numbers one bit at a time.

*   It uses two shift registers to hold the numbers to be added.
*   A single full adder (FA) performs the addition.
*   A D flip-flop is used to store the carry-out from one bit position and use it as the carry-in for the next.

<img src="/serial_adder.svg" class="rounded-lg bg-white p-4 w-80 mx-auto" alt="Serial Adder with D Flip-Flop">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-6: Serial Adder using a Full Adder and D Flip-Flop</div>


---

## Universal Shift Register

A **universal shift register** is a versatile register with multiple modes of operation. It combines the features of parallel load, shift-right, and shift-left into a single unit.

### Common Capabilities
*   **Clear:** Reset all flip-flops to 0.
*   **Shift-Right:** Shift data from left to right.
*   **Shift-Left:** Shift data from right to left.
*   **Parallel Load:** Load all bits simultaneously from parallel inputs.
*   **No Change:** Hold the current data.

A mode control input (e.g., `s₁s₀`) selects the operation.



---

### 4-Bit Universal Shift Register

The operation is selected by inputs `s₁` and `s₀`. A 4x1 MUX is used for each flip-flop to select the appropriate input for the next state.


<img src="/universal_shift_register.svg" class="rounded-lg bg-white p-4 w-full mb-4 col-span-2" alt="4-Bit Universal Shift Register">
<div class="text-center text-sm opacity-50 mt-2 mb-8 col-span-2">Figure 7-7: 4-Bit Universal Shift Register</div>


---

<div class="grid grid-cols-2 gap-8">

<div>

### Function Table


<div class="mt-4 text-base">
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


</div>

<img src="/universal_shift_register_block.svg" class="rounded-lg bg-white p-4" alt="4-bit Universal Shift Register Diagram">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-8: Block Diagram of 4-Bit Universal Shift Register</div>


</div>

---

### VHDL Implementation

```vhdl
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

## Counters

A **counter** is a register that goes through a predetermined sequence of states upon the application of input pulses.

*   The input pulses are often clock pulses.
*   The sequence of states can be a binary count or any other sequence.

### Categories of Counters
*   **Ripple Counters (Asynchronous):** The flip-flop output transition serves as the clock for the next flip-flop. No common clock pulse.
*   **Synchronous Counters:** All flip-flops are triggered by a common clock pulse.

---

## Ripple Counters (Asynchronous)

In a ripple counter, the clock is applied only to the first flip-flop. The output of each flip-flop is connected to the clock input of the next.

*   This creates a "rippling" effect as the state change propagates through the chain of flip-flops.
*   Simple to construct, but slower than synchronous counters due to the cumulative propagation delay.

<img src="/4bit_ripple_counter.svg" class="rounded-lg bg-white p-4 w-180 mx-auto" alt="4-bit Ripple Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-9: 4-Bit Binary Ripple Counter</div>


---

## BCD Ripple Counter

A BCD counter counts from 0 to 9 (0000 to 1001) and then resets to 0.

*   It can be constructed from a 4-bit binary counter by adding logic to force a reset to 0000 after the count of 1001.
*   When the counter reaches 1010 (decimal 10), the NAND gate output goes low, asynchronously clearing all flip-flops.

<img src="/bcd_state_diagram.svg" class="rounded-lg bg-white p-4 w-55 mx-auto" alt="State Diagram of BCD Counter">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-10: State Diagram of BCD Counter</div>




---

<div class="my-8"></div>

<img src="/bcd_ripple_counter.svg" class="rounded-lg bg-white p-4 w-full" alt="BCD Ripple Counter Logic Circuit">
<div class="text-center text-sm opacity-50 mt-2">Figure 7-11: BCD Ripple Counter Logic Circuit</div>

---

## Synchronous Counters

In a **synchronous counter**, all flip-flops are triggered simultaneously by a common clock signal.

*   The decision of whether a flip-flop should toggle or not is determined by combinational logic connected to its J and K (or T) inputs.
*   This design avoids the cumulative delay of ripple counters, making them faster and more suitable for high-frequency applications.
*   The design follows the standard procedure for synchronous sequential circuits.

<img src="https://i.imgur.com/7g9a83B.png" class="rounded-lg bg-white p-4 w-2/3" alt="4-bit Synchronous Binary Counter">

---

## Up-Down Binary Counter

An up-down counter is capable of counting in both ascending and descending order, controlled by an `Up` and `Down` input.

*   When `Up=1`, the circuit counts up.
*   When `Down=1`, the circuit counts down.
*   The logic for the T input of each flip-flop is modified to handle both counting directions.
    *   **Up-count:** A flip-flop `Aᵢ` toggles if all lower-order bits `Aᵢ₋₁...A₀` are 1.
    *   **Down-count:** A flip-flop `Aᵢ` toggles if all lower-order bits `Aᵢ₋₁...A₀` are 0.

<img src="https://i.imgur.com/j13z98m.png" class="rounded-lg bg-white p-4 w-full" alt="4-bit Up-Down Counter">

---

## Counter with Parallel Load

Counters used in digital systems often require both counting and parallel loading capabilities.

*   This allows the counter to be preset to a specific starting value.
*   Control inputs like `Load` and `Count` determine the operation on each clock edge.

### Function Table

| Clear | CLK | Load | Count | Function                |
|:-----:|:---:|:----:|:-----:|:------------------------|
| 0     | X   | X    | X     | Clear to 0              |
| 1     | ↑   | 1    | X     | Load inputs             |
| 1     | ↑   | 0    | 1     | Count next binary state |
| 1     | ↑   | 0    | 0     | No change               |

<img src="https://i.imgur.com/o280i9Q.png" class="rounded-lg bg-white p-4 w-full" alt="4-bit Counter with Parallel Load">

### VHDL Implementation

```vhdl
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

## Other Counter Types

### Modulo-N Counter (Divide-by-N)
*   A counter that goes through a repeated sequence of *N* states. The counter "divides" the input clock frequency by *N*.
*   A BCD counter is a Modulo-10 counter.
*   Can be designed to follow any arbitrary sequence.

### Self-Correcting Counter
*   A counter with unused states can sometimes enter one of these states due to noise.
*   A self-correcting design ensures that if the counter enters an unused state, it will eventually transition back to a valid state.

---

## Ring Counter

A **ring counter** is a circular shift register where only one flip-flop is set at any particular time; all others are cleared.

*   It is initialized by setting one flip-flop to 1 (e.g., `1000`).
*   The single '1' bit is then shifted from one flip-flop to the next on each clock pulse, creating a sequence of timing signals.
*   An *n-bit* ring counter produces *n* distinct states/timing signals.

<div class="grid grid-cols-2 gap-8 items-center">

<img src="https://i.imgur.com/978051s.png" class="rounded-lg bg-white p-4" alt="Ring Counter Diagram">

<div>

**4-bit Sequence**
*   1000
*   0100
*   0010
*   0001
*   (repeats) 1000

</div>
</div>

---

## Application: Generating Timing Signals

Counters are frequently used to generate timing signals that control the sequence of operations in a digital system.

<div class="grid grid-cols-2 gap-8">

<div>

### Method 1: Ring Counter
*   Uses *N* flip-flops for *N* timing signals.
*   Simple, requires no decoder.

<img src="https://i.imgur.com/978051s.png" class="rounded-lg bg-white p-4 w-48" alt="Ring Counter">

</div>

<div>

### Method 2: Counter + Decoder
*   Uses an *n-bit* counter and an *n-to-2ⁿ* decoder to generate *N = 2ⁿ* timing signals.
*   More efficient in terms of flip-flop count for a large number of signals.

<img src="https://i.imgur.com/9b2915l.png" class="rounded-lg bg-white p-4 w-48" alt="Counter and Decoder">

</div>
</div>

<img src="https://i.imgur.com/39665jS.png" class="rounded-lg bg-white p-4 w-full mt-4" alt="Timing Signals">