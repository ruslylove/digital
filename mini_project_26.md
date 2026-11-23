---
theme: seriph
background: https://cover.sli.dev
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Morse Code Decoder with Latching LED Indicators
  Mini Project 2026 (Semester 2/2026)
drawings:
  persist: false
transition: fade
title: Mini Project 2026 - Morse Code Decoder
layout: cover
---

# Mini Project 2026

<div class="text-3xl mt-2">Morse Code Decoder with Latching LED Indicators</div>

FSM Design and Sequential Logic Implementation

<div class="opacity-70 mt-8">Digital Circuit and Logic Design · Semester 2/2026 · Individual mini project</div>

---
layout: default
---

## Project Objective

Design, simulate and implement a **synchronous sequential circuit** that decodes incoming **Morse code** for **two English letters assigned to each student**.

<div class="grid grid-cols-2 gap-4 text-base mt-4">
<div>

### You will apply
* Finite State Machine (FSM) modeling (**Moore or Mealy**)
* State minimization and **state assignment**
* Flip-flop **excitation equations**
* **Combinational logic** optimization

</div>
<div>

### Project facts
* **Course:** Digital Circuit and Logic Design
* **Type:** Individual mini project
* **Target letters:** 2 assigned letters
* **Submission / demo due:** to be announced in class

</div>
</div>

> The circuit monitors a **serial Morse input** and controls an **output LED** that latches when one of your two letters has been received.

---

## Input Encoding

The serial input consists of three kinds of symbols:

| Symbol | Meaning | Duration |
| :--- | :--- | :--- |
| **Dot** (•) | short pulse (level 1) | ~1 – 500 ms |
| **Dash** (—) | long pulse (level 1) | ~900 – 1500 ms |
| **End-of-Character delimiter** | idle gap (level 0) | > 2 seconds |

<br>

> **Note:** The timing of dot, dash and delimiter is **not strictly defined**. You may choose reasonable values yourself (and state them in your report).

---

## Example Input: "R" followed by "S"

<img src="/mini_project_26_morse_timing.svg" class="rounded-lg bg-white p-4 w-full mx-auto" alt="Morse timing diagram for R and S">
<div class="text-center text-sm opacity-60 mt-2">Figure 1: R ( • — • ) then a 2000 ms delimiter, then S ( • • • ) — durations in ms</div>

---

## Operation Rules (1/2)

<div class="text-base">

* **Detection & latching** — when a complete Morse sequence matches **either of your two letters** *and* is followed by the End-of-Character delimiter, the output LED turns **ON** and stays **latched** (lit continuously).
* **Strict end-of-character verification** — never light the LED early while symbols are still arriving.
  * *Example:* if your letter is **E** ( • ) and the transmitter sends **I** ( • • ), the LED must stay **OFF**, because no delimiter occurred after the first dot.
* **Hold and auto-clear** — a lit LED stays ON **until the first symbol (dot or dash) of the next character begins**. On that first symbol the LED turns **OFF immediately** and the FSM starts evaluating the new character.

</div>

---

## Operation Rules (2/2)

<div class="text-base">

* **Non-matching sequences** — if the sequence deviates from **both** of your patterns (or becomes longer than a valid pattern before the delimiter), the FSM goes to a **trap / error state** and keeps the LED **OFF** until the next End-of-Character delimiter resets the decoder.
* **Master reset (RST)** — an asynchronous or synchronous, active-low or active-high reset returns the FSM to its initial **IDLE** state and turns the LED **OFF**.

</div>

<br>

### Behaviour summary

<style>
.tight th, .tight td { padding: 2px 8px !important; font-size: 0.85rem; line-height: 1.2; }
</style>

<div class="tight">

| Situation | LED |
| :--- | :---: |
| Letter in progress (symbols still arriving) | OFF |
| Complete target letter + delimiter | **ON (latched)** |
| First symbol of the next character | OFF |
| Wrong / too-long sequence until next delimiter | OFF |
| Master reset | OFF |

</div>

---

## Character Assignment (Based on Student ID)

1. Take the **last two digits** of your Student ID (00 – 99).
2. Compute **(last two digits) mod 50** — if they are ≥ 50, subtract 50.
3. Look up your index **(00 – 49)** in the table on the next slides.

Every pair **shares a common prefix**, so all students need a state machine of **identical complexity**.

### Example
* **Student ID:** `...630827`
* **Last two digits:** 27 → 27 mod 50 = **27**
* **Assigned letters:** **C, M** → — • — • & — —

---

## Assignment Table (ID mod 50 = 00 – 24)

<style>
.tight table { width: 100%; }
.tight th, .tight td { padding: 3px 8px !important; font-size: 0.85rem; line-height: 1.2; }
</style>

<div class="tight grid grid-cols-2 gap-6">
<div>

| ID mod 50 | Letters | Morse patterns |
| :---: | :---: | :--- |
| 00 | F, S | • • — • & • • • |
| 01 | D, O | — • • & — — — |
| 02 | C, D | — • — • & — • • |
| 03 | G, O | — — • & — — — |
| 04 | B, N | — • • • & — • |
| 05 | R, S | • — • & • • • |
| 06 | G, K | — — • & — • — |
| 07 | F, I | • • — • & • • |
| 08 | I, J | • • & • — — — |
| 09 | B, K | — • • • & — • — |
| 10 | I, P | • • & • — — • |
| 11 | C, Y | — • — • & — • — — |
| 12 | G, Q | — — • & — — • — |

</div>
<div>

| ID mod 50 | Letters | Morse patterns |
| :---: | :---: | :--- |
| 13 | B, D | — • • • & — • • |
| 14 | N, Q | — • & — — • — |
| 15 | M, Y | — — & — • — — |
| 16 | F, U | • • — • & • • — |
| 17 | D, Y | — • • & — • — — |
| 18 | K, X | — • — & — • • — |
| 19 | A, J | • — & • — — — |
| 20 | P, R | • — — • & • — • |
| 21 | B, X | — • • • & — • • — |
| 22 | J, R | • — — — & • — • |
| 23 | U, V | • • — & • • • — |
| 24 | O, Q | — — — & — — • — |

</div>
</div>

---

## Assignment Table (ID mod 50 = 25 – 49)

<style>
.tight table { width: 100%; }
.tight th, .tight td { padding: 3px 8px !important; font-size: 0.85rem; line-height: 1.2; }
</style>

<div class="tight grid grid-cols-2 gap-6">
<div>

| ID mod 50 | Letters | Morse patterns |
| :---: | :---: | :--- |
| 25 | I, L | • • & • — • • |
| 26 | H, V | • • • • & • • • — |
| 27 | C, M | — • — • & — — |
| 28 | D, G | — • • & — — • |
| 29 | O, Z | — — — & — — • • |
| 30 | R, U | • — • & • • — |
| 31 | L, W | • — • • & • — — |
| 32 | J, P | • — — — & • — — • |
| 33 | Q, Z | — — • — & — — • • |
| 34 | A, F | • — & • • — • |
| 35 | U, W | • • — & • — — |
| 36 | S, W | • • • & • — — |
| 37 | A, P | • — & • — — • |

</div>
<div>

| ID mod 50 | Letters | Morse patterns |
| :---: | :---: | :--- |
| 38 | H, U | • • • • & • • — |
| 39 | M, X | — — & — • • — |
| 40 | C, K | — • — • & — • — |
| 41 | K, O | — • — & — — — |
| 42 | C, N | — • — • & — • |
| 43 | D, X | — • • & — • • — |
| 44 | A, H | • — & • • • • |
| 45 | A, V | • — & • • • — |
| 46 | B, M | — • • • & — — |
| 47 | A, L | • — & • — • • |
| 48 | D, K | — • • & — • — |
| 49 | N, Z | — • & — — • • |

</div>
</div>

---

## Required Deliverables & Assessment

Each student submits a **technical design report (video presentation)** with the simulation / hardware source files, and completes an **individual live demonstration**.

1. **FSM design** — state diagram showing the **shared-prefix states**, branching transitions, End-of-Character **latching states** and **trap states**.
2. **Logic synthesis** — state assignment table, state transition table, **Karnaugh maps** and **minimized Boolean equations** for all flip-flop inputs and the LED output.
3. **Simulation & timing verification** — a complete schematic (e.g. Logisim, Quartus, Vivado or Multisim) and waveforms showing the cases on the next slide.
4. **Live demonstration** — a live functional test with **instructor-provided random Morse test vectors** (and a breadboard).
5. **Interview** — questions to check your understanding of your own design.

---

## Required Timing Verification

Your waveforms must demonstrate:

| | Case |
| :---: | :--- |
| &#40;a&#41; | **Letter 1** matched and latched |
| &#40;b&#41; | **Letter 2** matched and latched |
| &#40;c&#41; | **Hold** duration of the lit LED across idle cycles |
| &#40;d&#41; | **Immediate clear** at the start of a new character |
| &#40;e&#41; | **Rejection** of invalid / prefix-only sequences |

---

## Hardware Example

<img src="/mini_project_26_breadboard.jpg" class="rounded-lg mx-auto h-90" alt="Breadboard Morse decoder (AI-generated picture)">
<div class="text-center text-sm opacity-60 mt-2">This picture is generated by AI. Its wiring is not good — don't do it like this!</div>

---

## Suggested Workflow

1. **Know your pair** — write both Morse patterns and mark the **common prefix**.
2. **Draw the state diagram** — shared prefix first, then the branches, the latching state(s) and the trap state; check **every input** (dot, dash, delimiter) in **every state**.
3. **State table & assignment** — choose Moore or Mealy, assign codes, handle unused states.
4. **Equations** — K-maps for each flip-flop input and for the LED; minimize and **explain the grouping**.
5. **Simulate** — test all five cases (a)–(e) before building.
6. **Build & demo** — neat breadboard wiring; practise with random test vectors.

<br>

> Decide how the **dot / dash / delimiter** are recognised from the input timing (e.g. a counter or timer) and **write down the timings you chose**.

---

## Summary of Deliverables

<div class="text-xl leading-12 mt-4">

* **FSM design** — state diagram
* **Logic synthesis** — tables, K-maps, equations
* **Simulation & timing** — schematic and waveforms (a)–(e)
* **Live demonstration** — random Morse test vectors
* **Interview** — your own design

</div>
