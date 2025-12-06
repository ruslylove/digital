---
theme: seriph
background: https://cover.sli.dev
transition: fade
layout: cover
title: Lecture 1 - Digital System
lectureIndex: 1
---

# Lecture 1: Digital System

{{ $slidev.configs.subject }}

{{ $slidev.configs.author }}


---
layout: two-cols-header
---

## Why Study Digital Systems?

Digital circuits are the **brain** of the modern world. As a future electrical engineer, you will design, build, and understand the systems that power our lives.

:: left ::

*   **Smart Devices:** Phones, watches, and home assistants.
*   **Computing:** Laptops, servers, and supercomputers.
*   **Communication:** 5G networks, Wi-Fi, and the Internet.
*   **Automotive:** Engine control, safety systems (ABS, airbags), and infotainment.
*   **Aerospace & Defense:** Avionics, guidance systems, and modern radar.

Understanding the fundamentals of digital logic is essential for a career in almost any field of electrical and computer engineering.

:: right ::

<img src="https://images.unsplash.com/photo-1555664424-778a1e5e1b48?w=800" class="rounded-lg bg-white p-2 mt-4" alt="A modern circuit board">
<p class="text-sm text-center">Figure 1-1. The principles you learn here are built into every complex electronic device.</p>

---

## Learning Objectives

By the end of this lecture, you will be able to:

*   **Differentiate** between analog and digital signals.
*   **Explain** how information is represented using binary.
*   **Describe** the key historical inventions that led to the modern computer, from vacuum tubes to the integrated circuit.
*   **Recognize** the impact of Moore's Law on the growth of computing power.
*   **Categorize** the main types of digital logic chips (Standard, PLD/FPGA, ASIC).
*   **Appreciate** the role of digital systems in modern engineering and technology.

---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="4"/>

---


## Digital vs. Analog Signals
* An **analog signal** is continuous, representing information with an infinite range of values over time. Think of a smooth, flowing wave.
* A **digital signal** is discrete, representing information with a finite set of values (like 0s and 1s). It moves in distinct steps.
 
 
<img src="/analog_vs_digital.svg" class="rounded-lg bg-white p-4 w-135 mt-2 mx-auto" alt="Analog vs Digital Waveforms">
<p class="text-sm text-center">Figure 1-2. An analog signal has continuous values, while a digital signal has discrete, step-like values.</p>


---
layout: two-cols-header
---

## Switch and Binary Bit Representation

The most common digital signals are those that can have one of only two possible values, like `on` or `off` (`0` and `1`) => switch => a binary representation.

<img src="/switch_binary.svg" class="w-120 mx-auto"/>
<p class="text-sm text-center">Figure 1-3. Switch and Binary Representation.</p>


---

## Binary Representation

A binary `1001111` is representing the number 79:

<div class="text-center">

<img src="/binary_rep.svg" class="mx-auto mt-4 w-200 p-5"/>
<p class="text-sm text-center">Figure 1-4. Binary representation of 79.</p>

</div>

---
layout: two-cols-header
---

## Analog to Digital Transformation: Tape Record to CD Audio
The shift from analog to digital technology has revolutionized how we create, store, and listen to music.

:: left ::

### Analog: Magnetic Tape (Cassette/Reel)
*   **Physical Medium:** Audio stored as magnetic patterns on a plastic tape.
*   **Signal Degradation:** Prone to hiss, wow and flutter, and demagnetization over time.
*   **Sequential Access:** Finding a specific track requires fast-forwarding or rewinding.
<img src="https://upload.wikimedia.org/wikipedia/commons/f/f0/Compactcassette.jpg" class="rounded-lg mt-4 w-40 mx-auto" alt="Cassette Tape">
<p class="text-sm text-center">Figure 1-5. Cassette Tape.</p>

::right::

### Digital: CD Audio
*   **Abstract Data:** Audio stored as binary data (pits and lands) on a polycarbonate disc.
*   **High Fidelity & Durability:** Offers clear, consistent sound quality, less susceptible to wear than tape.
*   **Random Access:** Tracks can be accessed instantly.
<img src="https://www.soundandvision.com/images/styles/600_wide/public/100517_tbt_sony_cdp-101_0.jpg" class="rounded-lg mt-4 w-60 mx-auto" alt="CD Audio Disc">
<p class="text-sm text-center">Figure 1-6. CD Audio Disc.</p>

---
layout: two-cols-header
---

## Analog to Digital Transformation: Industrial Automation
The evolution from analog to digital sensors has been a cornerstone of modern automation and "smart" factories.
:: left ::

### Analog Sensor (e.g., Pressure Gauge)
<div class="text-base pt-2">

<img src="https://upload.wikimedia.org/wikipedia/commons/7/74/MAXIMATOR-High-Pressure-Manometer-01a.jpg" class="rounded-lg mt-4 w-20" alt="Analog Pressure Gauge" style="float: left; margin-right: 25px; width: 150px;">

*   **Continuous Signal:** Outputs a varying voltage or current (e.g., 4-20mA) that is proportional to the measured property (like pressure).
*   **Noise Susceptibility:** The signal can be degraded by electrical noise, affecting accuracy.
*   **Limited Information:** Only provides a single data point—the measurement itself.
</div>
::right::

### Digital Sensor (e.g., Smart Sensor)
<div class="text-base pt-2">

<img src="https://www.ifm.com/binaries/content/assets/webanimations/rotatable3d/pg1/pg_gedreht.png" class="rounded-lg w-60" alt="Digital Smart Sensor" style="float: left; margin-right: 25px; width: 150px;">

*   **Discrete Data:** An internal ADC converts the measurement into a digital format. The sensor communicates this data via a digital protocol (e.g., IO-Link, I2C).
*   **Noise Immunity:** Digital communication is highly resistant to electrical noise.
*   **Rich Information:** Can provide the measurement, diagnostics, calibration data, and device identity over a single connection.

</div>

---
layout: two-cols
---

## Analog to Digital Conversion

To convert an analog signal to digital, we perform two key steps:
1.  **Sampling:** The value of the analog signal is measured at regular time intervals (the dots on the curve).
2.  **Quantization:** Each sampled value is mapped to the nearest value in a finite set of discrete levels (the steps).

:: right ::

<img src="/adc.png" class="mt-4 w-80 mx-auto"/>
<p class="text-sm text-center">Figure 1-7. Sampling process.</p>
<img src="/adc.svg" class="mt-4 w-80 mx-auto"/>
<p class="text-sm text-center">Figure 1-8. Quantization levels.</p>



---
layout: two-cols-header
---

## Keypad Encoding

A keypad is organized as a matrix of rows and columns. When a key is pressed, it connects one row wire to one column wire.

:: left ::

*   **Scanning:** A microcontroller scans the keypad by activating one row (or column) at a time and then reading the columns (or rows) to see if any button is pressed.
*   **Encoding:** The unique row-column combination is then converted (encoded) into a binary number to identify the pressed key.
*   **Example:** For a 4x4 keypad (16 keys), a 4-bit binary code is sufficient to represent each key (e.g., key '1' could be `0000`, '2' could be `0001`, etc.).

::right::

<img src="https://circuitdigest.com/sites/default/files/inlineimages/4x4-matrix-keypad.gif" class="rounded-lg bg-white p-4" alt="Keypad Matrix Diagram">
<p class="text-sm text-center">Figure 1-9. Keypad Matrix Diagram.</p>


---
layout: two-cols-header
---

## Ideal Switch to Real Switch

An ideal switch is a perfect, theoretical component, while real-world switches like transistors have physical limitations.

:: left ::
<div class="text-base">

### Ideal Switch
*   Switches **instantaneously**.
*   **Zero** resistance when closed (ON).
*   **Infinite** resistance when open (OFF).
*   Consumes **no power**.
<img src="/circuit_switch.png" class="rounded-lg mt-4 w-70"/>
<p class="text-sm text-center">Figure 1-10. Ideal Switch Model.</p>

</div>

:: right ::
<div class="text-base">

### Real Switch (Transistor)
*   Has **finite** switching time (rise/fall time).
*   Small, **non-zero** resistance when ON.
*   Very high, but **not infinite**, resistance when OFF.
*   `Transistors` are the physical basis for digital logic.
<div class="grid grid-cols-2 gap-4">
<img src="/circuit_transistor.png" class="rounded-lg w-80"/>
<img src="https://i0.wp.com/darlingevil.com/wp-content/uploads/2018/03/transistor.jpg?resize=768%2C476&ssl=1" class=" w-80 pt-7"/>
</div>
<p class="text-sm text-center">Figure 1-11. Real Transistor.</p>

</div>

---
layout: two-cols
---

## Digital Hardware

*   1930's Relays
<img src="https://how2electronics.com/wp-content/uploads/2022/12/understanding-relay-pinouts-and-contacts.jpg" class="w-90"/>
<p class="text-sm text-center">Figure 1-12. Electrical Relay.</p>
:: right ::
*   1940's VacuumTube – No moving part, Faster than Relays
<div class="grid grid-cols-2 gap-4 items-center">
<div>
<img src="https://cdn-blog.adafruit.com/uploads/2017/10/37069392422_56b2c8d7b3_b.jpg" class="w-50 mt-5"/>
<p class="text-sm text-center">Figure 1-13. Vacuum Tubes.</p>
</div>
<div>
<img src="https://static.wixstatic.com/media/b3b6fa_502a0c330cf045a7a2ea85854d96cf69~mv2.jpg/v1/fill/w_572,h_540,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/b3b6fa_502a0c330cf045a7a2ea85854d96cf69~mv2.jpg" class="w-100 mt-5" />
<p class="text-sm text-center">Figure 1-14. Vacuum Tubes in ENIAC.</p>
</div>
</div>

---

## Digital Hardware
<div class="grid grid-cols-8 gap-4">
<div class="col-span-3">

*   Logic circuits are used to build computer hardware as well as other products
*   Late 1960's and early 1970's saw a revolution in digital capability
    *   Smaller transistors
    *   Larger chip size
*   More transistors/chip gives greater functionality, but requires more complexity in the design process
</div>

<div class="col-span-5">

<div class="grid grid-cols-2 gap-4">
<img src="https://cdn.sparkfun.com/assets/learn_tutorials/1/9/3/intro.png" class="rounded-lg"/>
<img src="https://ethw.org/w/images/5/58/Logic_Gates_Dec_System_Building_Blocks_1103_Attribution.jpg?20120302164220" class="rounded-lg"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/Agc_nor2.jpg" class="mt-1 rounded-lg" />
<img src="https://hackster.imgix.net/uploads/attachments/1249774/_JBfBEpQNXw.blob?auto=compress&w=900&h=675&fit=min&fm=jpg" class="rounded-lg mx-auto"/>
</div>

</div>

</div>
---

## ENIAC - The First Electronic Computer
### ENIAC (Electrical Numerical Integrator And Calculator) 1946

<div class="grid grid-cols-3 gap-4">

<div class="col-span-1">

<img src="https://www.aps.org/_ipx/w_828,q_90/https%3A%2F%2Fcdn.sanity.io%2Fimages%2Fi2z87pbo%2Fproduction%2Fa9132a54f148d9eef366dbf5f7a8cb5c25603971-2500x1597.webp%3Fauto%3Dformat%26fit%3Dmax%26w%3D828%26q%3D90" class="rounded-lg w-60 mt-2 mx-auto"  />
<p class="text-sm text-center">Figure 1-15. ENIAC Computer (1946).</p>

<img src="https://www.aps.org/_ipx/w_828,q_90/https%3A%2F%2Fcdn.sanity.io%2Fimages%2Fi2z87pbo%2Fproduction%2F77e84894dd3ea6d6585ab07b6e826e157b40e996-2846x1924.jpg%3Fauto%3Dformat%26fit%3Dmax%26w%3D828%26q%3D90" class="rounded-lg w-60 mt-2 mx-auto" />
<p class="text-sm text-center">Figure 1-16. ENIAC Programming.</p>

</div>


<div>

**Performance**
*   **5,000** additions/sec
*   **400** multiplications/sec
*   ~200,000x faster than hand calculation

**Components & Specs**
*   **17,468** vacuum tubes, **70,000** resistors, **10,000** capacitors
*   **1,500** relays, **6,000** manual switches
*   Power: **160 kW**

</div>
<div>

**Physical Size**
*   Area: **167 m²** (~1800 ft²)
*   Weight: **30 tons**
*   Dimensions: ~80 ft long, 8.5 ft high, 3 ft deep
</div>
</div>

---
layout: two-cols-header
---

## The First 'BUG'

:: left ::

* In 1947, Grace Murray Hopper was working on the Harvard University Mark II Aiken Relay Calculator (a primitive computer). 
* On the 9th of September, 1947, when the machine was experiencing problems, an investigation showed that there was a moth trapped between the points of Relay #70, in Panel F.

:: right ::

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/First_Computer_Bug%2C_1945.jpg/2560px-First_Computer_Bug%2C_1945.jpg" class="rounded-lg mx-auto w-60"/>
<p class="text-sm text-center">Figure 1-17. The First Computer Bug Log.</p>

<img src="/first_bug.jpg" class="rounded-lg mt-4 mx-auto w-40" />
<p class="text-sm text-center">Figure 1-18. Grace Hopper's Moth.</p>
---

## The First Transistor (1947) - A Revolution in Electronics

<div class="grid grid-cols-2 gap-4 text-base">
<div>

<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0419_Steber_Figure07.jpg" class="rounded-lg" />
<p class="text-sm text-center">Figure 1-19. The First Point-Contact Transistor.</p>

*   The first **point-contact transistor**, invented at Bell Labs.
*   It was a solid-state device that could amplify electrical signals, replacing bulky and unreliable vacuum tubes.

</div>
<div>

<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0419_Steber_Figure09.jpg" class="rounded-lg w-70 mx-auto"/>
<p class="text-sm text-center">Figure 1-20. Bardeen, Shockley, and Brattain.</p>

*   Inventors **John Bardeen, William Shockley, and Walter Brattain** were awarded the **Nobel Prize in Physics in 1956**.
*   This invention paved the way for the development of integrated circuits and the entire modern electronics industry.
</div>
</div>

---

## The First Integrated Circuit (IC) - 1958

<div class="grid grid-cols-2 gap-4 text-base">
<div>

<img src="https://www.allaboutcircuits.com/uploads/articles/Kilbys-Germanium-Integrated-Circuit.jpg" class="rounded-lg w-80 mx-auto pt-5" />

<p class="text-sm text-center">
Figure 1-21. Jack Kilby's first hybrid IC (1958). It was made of germanium and measured 7/16" x 1/16".
</p>

*   **Jack Kilby** (Texas Instruments) and **Robert Noyce** (Fairchild Semiconductor) independently invented the integrated circuit.


</div>
<div>


<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0222_Steber_Figure10.jpg" class="rounded-lg w-60 mx-auto"/>
<p class="text-sm text-center">Figure 1-22. Early Monolithic Integrated Circuit.</p>

*   Kilby built the first hybrid IC, while Noyce created the first monolithic IC, which was more practical for manufacturing.
*   This invention allowed for putting all electronic components onto a single die, dramatically increasing performance and decreasing cost.
*   Kilby was awarded the **Nobel Prize in Physics in 2000**.

</div>
</div>

---

## The First Logic IC

<div class="grid grid-cols-3 gap-4">
<div>

**1961:** TI and Fairchild introduced the first logic IC's (cost ~$50 in quantity!). This is a dual flip-flop with 4 transistors.

<img src="/ic1.png" class="mt-4 w-50 mx-auto"/>
<p class="text-sm text-center">Figure 1-23. First Logic IC (Dual Flip-Flop).</p>

</div>
<div>

**1963:** Densities and yields are improving. This circuit has four flip flops.

<img src="/ic2.png" class="mt-4 w-50 mx-auto"/>
<p class="text-sm text-center">Figure 1-24. Four Flip-Flop IC.</p>

</div>
<div>

**1967:** Fairchild markets the semi-custom chip shown below. Transistors could be easily rewired using a two-layer interconnect to create different circuits. This circuit contains ~150 logic gates.

<img src="/ic3.png" class="mt-4 w-50 mx-auto"/>
<p class="text-sm text-center">Figure 1-25. Fairchild Semi-Custom Chip.</p>

</div>
</div>

---
layout: two-cols
---

## Intel (1968)

*   Founded in July 1968 by semiconductor pioneers **Robert Noyce** and **Gordon Moore**, who left Fairchild Semiconductor.
*   The name is a portmanteau of **Int**egrated **El**ectronics.
*   **Andy Grove**, also from Fairchild, joined soon after and led the company's manufacturing operations, becoming a key figure in Intel's success.
*   Their initial business plan focused on the market for semiconductor memory, believing it would soon replace magnetic-core memory.

::right::
<div class="flex flex-col items-center justify-center h-full">
  <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Andy_Grove_Robert_Noyce_Gordon_Moore_1978_edit.jpg" class="rounded-lg w-70"/>
  <p class="text-sm text-center">Figure 1-26. Gordon Moore (right), Robert Noyce (center), and Andy Grove (left). Noyce and Moore founded Intel, with Grove joining as the first employee. All three were instrumental in the company's growth.</p>
</div>

---
layout: two-cols-header
---

## Milestone: The Microprocessor & the PC

The invention of the microprocessor on a single chip led to the personal computer revolution, fundamentally changing the world.

::left::

### Intel 4004 (1971)
*   The world's **first microprocessor**.
*   It proved that a complex general-purpose processor could be built on a single chip.
*   Initially designed for a calculator, it paved the way for all future CPUs.

### Intel 8088 & the IBM PC (1981)
*   This processor, a variant of the 8086, was chosen for the **original IBM PC**.
*   Its selection established the **x86 architecture** as the industry standard, a legacy that continues today.

::right::
<div class="flex items-center gap-4 text-sm text-center">
<div>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Intel_C4004.jpg/1200px-Intel_C4004.jpg" class="rounded-lg w-40 mt-1 mx-auto"/>
<p>Figure 1-27. Intel 4004.</p>
</div>
<div>
<img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Busicom_141_PF_1.jpg" class="rounded-lg w-30 mt-1 mx-auto" />
<p>Figure 1-28. Busicom Calculator.</p>
</div>
</div>

<img src="https://external-preview.redd.it/dRMlIwz2nWdkuj9a6NyPzmhI_KQvx553vC3dmA4Pm1I.jpg?width=640&crop=smart&auto=webp&s=41a127b251329349e99684961b3916ce0884a8af" class="rounded-lg w-40 mt-1 mx-auto"/>
<p class="text-sm text-center">Figure 1-29. The IBM PC, powered by an Intel 8088.</p>

---
layout: two-cols-header
---

## Milestone: 32-bit, Multi-Core & Efficiency

Processor design has evolved from simply increasing clock speed to focusing on architectural improvements, parallelism, and power efficiency.

::left::

### The 32-bit Leap: Intel 80386 (1985)
*   The first 32-bit x86 processor, a massive jump in capability.
*   It enabled **modern multitasking operating systems** like Microsoft Windows and Linux.

### The Multi-Core: Core 2 Duo (2006)
*   Instead of just chasing higher clock speeds, which created heat and power issues, Intel shifted focus.
*   The **Core architecture** placed multiple processors ("cores") on a single chip, dramatically increasing performance through parallelism.

::right::

### The Modern Era: Core i-Series
*   Integrates more functions (graphics, memory controller) onto the CPU.
*   Focus continues on adding more cores, increasing power efficiency, and adding specialized instructions for tasks like AI and media processing.


<div class="grid grid-cols-2">
<div>
<img src="https://upload.wikimedia.org/wikipedia/commons/4/44/Intel_80386_IV_die.JPG" class="rounded-lg w-35 mt-2 mx-auto"/>
<p class="text-sm text-center">Figure 1-30. The 80386 die.</p>
</div>
<div>
<img src="https://images.bit-tech.net/content_images/2006/07/intel_core_2_duo_processors/die-large.jpg" class="rounded-lg w-40 mt-3 mx-auto"/>
<p class="text-sm text-center">Figure 1-31. A Core 2 Duo.</p>
</div>
</div>
---

## Intel Summary
<div class="text-sm text-center mt-2">

| Processor   | Year | Feature Size (µm) | Transistors | Frequency (MHz) | Word Size | Package         |
|-------------|------|-------------------|-------------|-----------------|-----------|-----------------|
| 4004        | 1971 | 10                | 2.3k        | 0.75            | 4         | 16-pin DIP      |
| 8008        | 1972 | 10                | 3.5k        | 0.5-0.8         | 8         | 18-pin DIP      |
| 8080        | 1974 | 6                 | 6k          | 2               | 8         | 40-pin DIP      |
| 8086        | 1978 | 3                 | 29k         | 5-10            | 16        | 40-pin DIP      |
| 80286       | 1982 | 1.5               | 134k        | 6-12            | 16        | 68-pin PGA      |
| 80386       | 1985 | 1.5-1.0           | 275k        | 16-25           | 32        | 100-pin PGA     |
| 80486       | 1989 | 1-0.6             | 1.2M        | 25-100          | 32        | 168-pin PGA     |
| Pentium     | 1993 | 0.8-0.35          | 3.2-4.5M    | 60-300          | 32        | 296-pin PGA     |

</div>

---

## Intel Summary (Continue)

<div class="text-sm text-center mt-2">

| Processor   | Year | Feature Size (µm) | Transistors | Frequency (MHz) | Word Size | Package         |
|-------------|------|-------------------|-------------|-----------------|-----------|-----------------|
| Pentium Pro | 1995 | 0.6-0.35          | 5.5M        | 166-200         | 32        | 387-pin MCM PGA |
| Pentium II  | 1997 | 0.35-0.25         | 7.5M        | 233-450         | 32        | 242-pin SECC    |
| Pentium III | 1999 | 0.25-0.18         | 9.5-28M     | 450-1000        | 32        | 330-pin SECC2   |
| Pentium 4   | 2001 | 0.18-0.13         | 42-55M      | 1400-3200       | 32        | 478-pin PGA     |
| Core 2 Duo  | 2006 | 0.065             | 291M        | 1800-3330       | 64        | 775-pin LGA     |
| Core i7     | 2008 | 0.045             | 731M        | 2660-3330       | 64        | 1366-pin LGA    |
| Core i7 (SB)| 2011 | 0.032             | 995M        | 3400-3800       | 64        | 1155-pin LGA    |
| Core i7 (SK)| 2015 | 0.014             | 1.75B       | 4000-4200       | 64        | 1151-pin LGA    |

</div>

---
layout: two-cols-header
---

## Moore's Law

<div class="grid grid-cols-5 gap-4">
<div class="col-span-2">

*   **Gordon Moore**: co-founder of Intel.
    *   Predicted that number of transistors per chip would grow exponentially (double every 18 months).
    *   Exponential improvement in technology is a natural trend: steam engines, dynamos, automobiles.
*   Today, the price of a transistor is less than a grain of rice.

</div>
<div class="col-span-3">

![Moore's Law Graph](https://upload.wikimedia.org/wikipedia/commons/0/00/Moore%27s_Law_Transistor_Count_1970-2020.png)
<p class="text-sm text-center">Figure 1-32. Moore's Law Graph.</p>

</div>
</div>

---
layout: two-cols-header
---

## Types of Logic Chips: Standard Chips (74xx)

::left::

*   Contain a small, fixed amount of circuitry (typically < 100 transistors).
*   Perform simple, fundamental logic functions (e.g., AND, OR, NOT, Flip-Flops).
*   The **74xx series** is a famous family of standard logic ICs.
*   Used as "glue logic" to connect larger chips or for simple tasks.
*   Not programmable; their function is determined during manufacturing.

::right::

<div class="grid grid-cols-2 gap-4">

<div>

<img src="https://mecha-tronx.com/wp-content/uploads/2022/08/IC-74HC00-2-INPUT-NAND-Gate-7400-1.jpg" class="rounded-lg w-35 mx-auto" alt="7400 NAND Gate IC">
<p class="text-sm text-center">Figure 1-33. 74HC00 NAND Gate IC.</p>
</div>
<div>
<img src="https://www.hackatronic.com/wp-content/uploads/2025/04/7400-Quad-NAND-Gate-Pinout-Diagram.webp" class="rounded-lg bg-white p-2 mt-5 w-40" alt="7400 Logic Diagram">
<p class="text-sm text-center">Figure 1-34. 7400 Internal Diagram.</p>
</div>

</div>

<img src="https://hackaday.com/wp-content/uploads/2020/01/breadboard800.jpg"  class="rounded-lg w-80 mx-auto"/>
<p class="text-sm text-center">Figure 1-35. A 74xx 24H Digital Quartz Clock.</p>


---
layout: two-cols-header
---

## Types of Logic Chips: Programmable Logic (PLD/FPGA)

::left::

*   A collection of logic gates with programmable interconnections.
*   The chip's function is configured by the designer/user **after** manufacturing.
*   Designed using CAD tools and Hardware Description Languages (HDLs) like VHDL or Verilog.
*   **PLD (Programmable Logic Device):** Simpler, for smaller tasks.
*   **FPGA (Field-Programmable Gate Array):** Much larger and more complex, containing thousands to millions of logic cells. Ideal for prototyping ASICs and complex systems.

::right::

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Xilinx_Spartan_FPGA_die_shot.jpg/1994px-Xilinx_Spartan_FPGA_die_shot.jpg" class="rounded-lg w-35 mt-4 mx-auto" alt="FPGA Die">
<p class="text-sm text-center">Figure 1-36. Die of an FPGA showing logic cells and interconnection wires.</p>


<img src="https://s3.amazonaws.com/iphonecde/_HDLS.GIF" class="rounded-lg w-65 mt-4 mx-auto" alt="HDL languages"/>
<p class="text-sm text-center">Figure 1-37. VHDL and Verilog are the most popular HDLs.</p>


---
layout: two-cols-header
---

## Types of Logic Chips: Custom Chips (ASIC)

::left::

*   **ASIC (Application-Specific Integrated Circuit)** is a chip customized for a particular use.
*   Optimized for a specific task, offering the best performance, smallest size, and lowest power consumption.
*   The design is permanent and cannot be changed after manufacturing.
*   Very high initial cost (Non-Recurring Engineering) for design and production masks.
*   Economically viable only for very high-volume products (e.g., smartphones, game consoles).

::right::

<img src="https://developer.nvidia.com/blog/wp-content/uploads/2018/09/image7.jpg" class="rounded-lg mt-4 w-80 mx-auto" alt="ASIC Die">
<p class="text-sm text-center">Figure 1-38. An example of a complex ASIC: NVIDIA's Turing GPU.</p>


---
layout: two-cols-header
---

## The Development Process

A typical digital circuit design flow involves several key stages, from initial concept to final implementation.

:: left ::

* **Design Phase**

This phase focuses on defining what the circuit should do and describing its behavior at a high level of abstraction, typically using an HDL.
* **Implementation Phase**

This phase transforms the abstract design into a physical, manufacturable layout, ensuring it meets performance, area, and power targets.

:: right ::

```mermaid 
flowchart LR;

    subgraph Design[Design Phase]
      direction TB
      A[Problem Specification] --> B{Design Entry};
      B -->|"HDL (Verilog/VHDL)"| C[RTL Design];
      B -->|Schematic| C;
      C --> D[Functional Simulation];
    end

    Design -- "realization (hardware)" ---> Implementation
   

    subgraph Implementation[Implementation Phase]
      direction TB
    E{Synthesis};
    E --> F[Post-Synthesis Simulation];
    F --> G[Implementation / P&R];
    G --> H[Timing Simulation];
    H --> I[Hardware Verification];
    end
```
<p class="text-sm text-center">Figure 1-39. A Development Flow of Digtial Circuit.</p>


---
layout: default
---

## Where Do We Go From Here?

This lecture was a historical overview. In the coming lectures, we will dive into the fundamental building blocks of digital systems:

*   **Number Systems:** Beyond binary, we'll explore other systems like hexadecimal used in computing.
*   **Boolean Algebra:** The mathematical foundation for digital logic.
*   **Logic Gates:** The basic electronic circuits (AND, OR, NOT) that perform Boolean operations.
*   **Combinational Logic Circuits:** Designing circuits without memory, like adders and decoders.
*   **Sequential Logic Circuits:** Designing circuits with memory, like counters and state machines.
*   **Dedicated Microprocessors:** Understanding the architecture, datapath, and control unit of specialized processors.

These concepts are the foundation upon which all modern digital electronics are built.

---
layout: two-cols-header
---

## Lecture 1 Summary

This lecture provides an introduction to digital systems, tracing their evolution from basic concepts to modern processors.
:: left ::

*   **Fundamentals:** Distinguishes between **analog** (continuous) and **digital** (discrete) signals, represented by binary values. Covers Analog-to-Digital conversion (**sampling** and **quantization**).

*   **Early Hardware:** Traces history from **relays** and **vacuum tubes** to **ENIAC** (1946), the first electronic computer.

*   **Key Inventions:** Highlights the **transistor** (1947) and the **Integrated Circuit (IC)** (1958) as revolutionary milestones.

:: right ::

*   **Microprocessors:** Details the evolution of Intel processors from the **4004 (1971)** to modern multi-core CPUs, establishing the x86 architecture.

*   **Moore's Law:** Explains the prediction of exponential growth in transistor density on chips.

*   **Types of Logic Chips:** Categorizes chips into **Standard (74xx)**, **Programmable (FPGAs)**, and **Custom (ASICs)**.

*   **Design Process:** Outlines the modern digital design flow, from specification and HDL to physical implementation.