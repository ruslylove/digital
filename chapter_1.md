---
theme: seriph
background: https://cover.sli.dev
transition: slide-left
layout: cover
title: Chapter 1 - Digital System
---

# Lecture 1: Digital System

{{ $slidev.configs.subject }}

<div class="abs-br m-6 text-sm">
010113025 Digital Circuits and Logic Design
</div>

---
hideInToc: false
---

## Outline

<toc mode="onlySiblings" minDepth="2" columns="1"/>

---
layout: two-cols
---

## Digital and Analog
* A **digital signal** is a signal that at any time can have one of a finite set of possible values, and is also known as a *discrete signal*.
* An **analog signal** can have one of an infinite number of possible values, and is also known as a *continuous signal*.
:: right ::
![Stairs](https://crossroadenergy.com/wp-content/uploads/2024/02/Digital-Vs-Analgo-1200x1200.jpg.webp)


---
layout: two-cols-header
---

## Switch and Binary Bit Representation

The most common digital signals are those that can have one of only two possible values, like on or off (0 and 1) => switch => a binary representation.

:: left ::

<img src="https://electricalacademia.com/wp-content/uploads/2018/11/20-4.jpg"/>

:: right ::

<img src="https://electricalacademia.com/wp-content/uploads/2018/11/20-5.jpg"/>



---

## Binary Representation

A binary `1001111` is representing the number 79:

<div class="text-center">

<img src="https://electricalacademia.com/wp-content/uploads/2018/11/20-12.jpg"/>

</div>

---

## Digital and Analog

<img src="https://circuitcrush.com/wp-content/uploads/Sampling-Analog-Signal-768x432.jpg"/>

---

# Digital and Analog

<div class="text-center">

<img src="https://substackcdn.com/image/fetch/$s_!xinp!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F8d47e8d6-ffe6-40e0-8575-85462a763dbd_996x500.png"/>

</div>

More and more analog products are becoming digital.

---

# Ex. Keypad Encoding

<div class="grid grid-cols-2 gap-4">

![Button](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-7-image-1.png)

![Encoding](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-7-image-2.png)

</div>

---
layout: two-cols-header
---

## Ideal Switch to Real Switch

:: left ::

<img src="https://www.mathworks.com/help/sps/ref/ideal_semi_switch_ports.png"/>

:: right ::

<img src="https://i0.wp.com/darlingevil.com/wp-content/uploads/2018/03/transistor.jpg?resize=768%2C476&ssl=1"/>



---
layout: two-cols
---

## Digital Hardware

*   1930's Relays
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ65WxvJKAeihlwc74ukh-hfq65LIKXxNDSA&s"/>
:: right ::
*   1940's VacuumTube – No moving part, Faster than Relays
<img src="https://cdn-blog.adafruit.com/uploads/2017/10/37069392422_56b2c8d7b3_b.jpg" style="width:300px"/>


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
<img src="https://www.radiomuseum.org/forumdata/users/7800/2N560_Composite_with_Transisto_2.jpg"/>
<img src="https://ethw.org/w/images/5/58/Logic_Gates_Dec_System_Building_Blocks_1103_Attribution.jpg?20120302164220"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/Agc_nor2.jpg" />
<img src="https://hackster.imgix.net/uploads/attachments/1249774/_JBfBEpQNXw.blob?auto=compress&w=900&h=675&fit=min&fm=jpg"/>
</div>

</div>

</div>
---

## ENIAC - The First Electronic Computer
### ENIAC (Electrical Numerical Integrator And Calculator) 1946
<br>

<div class="grid grid-cols-3 gap-4">

<div class="col-span-1">

<img src="https://www.aps.org/_ipx/w_828,q_90/https%3A%2F%2Fcdn.sanity.io%2Fimages%2Fi2z87pbo%2Fproduction%2Fa9132a54f148d9eef366dbf5f7a8cb5c25603971-2500x1597.webp%3Fauto%3Dformat%26fit%3Dmax%26w%3D828%26q%3D90" class="rounded-lg" style="width:300px" />
<br>
<img src="https://www.aps.org/_ipx/w_828,q_90/https%3A%2F%2Fcdn.sanity.io%2Fimages%2Fi2z87pbo%2Fproduction%2F77e84894dd3ea6d6585ab07b6e826e157b40e996-2846x1924.jpg%3Fauto%3Dformat%26fit%3Dmax%26w%3D828%26q%3D90" class="rounded-lg" style="width:300px"/>

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

![First Bug](https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/First_Computer_Bug%2C_1945.jpg/2560px-First_Computer_Bug%2C_1945.jpg)

---

## The First Transistor (1947) - A Revolution in Electronics

<div class="grid grid-cols-2 gap-4">
<div>

<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0419_Steber_Figure07.jpg" class="rounded-lg" />

*   The first **point-contact transistor**, invented at Bell Labs.
*   It was a solid-state device that could amplify electrical signals, replacing bulky and unreliable vacuum tubes.

</div>
<div>

<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0419_Steber_Figure09.jpg" class="rounded-lg" style="width:300px"/>

*   Inventors **John Bardeen, William Shockley, and Walter Brattain** were awarded the **Nobel Prize in Physics in 1956**.
*   This invention paved the way for the development of integrated circuits and the entire modern electronics industry.
</div>
</div>

---

## The First Integrated Circuit (IC) - 1958

<div class="grid grid-cols-2 gap-4">
<div>

<img src="https://www.allaboutcircuits.com/uploads/articles/Kilbys-Germanium-Integrated-Circuit.jpg" class="rounded-lg w-80" />

<p class="text-sm text-center mt-2">
Jack Kilby's first hybrid IC (1958). It was made of germanium and measured 7/16" x 1/16".
</p>

*   **Jack Kilby** (Texas Instruments) and **Robert Noyce** (Fairchild Semiconductor) independently invented the integrated circuit.


</div>
<div>


<img src="https://www.nutsvolts.com/uploads/wygwam/NV_0222_Steber_Figure10.jpg" class="rounded-lg w-70"/>

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

<img src="./ic1.png" class="mt-4"/>

</div>
<div>

**1963:** Densities and yields are improving. This circuit has four flip flops.

<img src="./ic2.png" class="mt-4"/>

</div>
<div>

**1967:** Fairchild markets the semi-custom chip shown below. Transistors could be easily rewired using a two-layer interconnect to create different circuits. This circuit contains ~150 logic gates.

<img src="./ic3.png" class="mt-4"/>

</div>
</div>

---
layout: two-cols
---

## INTegrated ELectronics = Intel (1968)

*   Founded in July 1968 by semiconductor pioneers **Robert Noyce** and **Gordon Moore**, who left Fairchild Semiconductor.
*   The name is a portmanteau of **Int**egrated **El**ectronics.
*   **Andy Grove**, also from Fairchild, joined soon after and led the company's manufacturing operations, becoming a key figure in Intel's success.
*   Their initial business plan focused on the market for semiconductor memory, believing it would soon replace magnetic-core memory.

::right::
<div class="flex flex-col items-center justify-center h-full">
  <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Andy_Grove_Robert_Noyce_Gordon_Moore_1978_edit.jpg" class="rounded-lg w-70"/>
  <p class="text-xs text-center mt-2">Gordon Moore (right), Robert Noyce (center), and Andy Grove (left). Noyce and Moore founded Intel, with Grove joining as the first employee. All three were instrumental in the company's growth.</p>
</div>

---
layout: two-cols-header
---

## Intel 4004 Micro-Processor (1971)

::left::

<img src="https://wifihifi.com/wp-content/uploads/2021/11/4004-schematic.jpg" class="rounded-lg w-80"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Intel_C4004.jpg/1200px-Intel_C4004.jpg" class="rounded-lg w-80"/>

::right::

**First microprocessor (1971)**
*   For Busicom calculator

**Characteristics**
*   10 µm process
*   2300 transistors
*   400 – 800 kHz
*   4-bit word size
*   16-pin DIP package

---

## Intel Processor Evolution

<div class="grid grid-cols-2 gap-8">
<div>

### 8008 (1972)
*   8-bit follow-on
*   Used in Dumb terminals
*   **3500** transistors
*   **500-800** kHz
<img src="https://www.intel.com/content/dam/www/central-libraries/us/en/images/2022-04/8008-die.jpg" class="rounded-lg w-70"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/b/ba/KL_Intel_C8008-1.jpg" class="rounded-lg w-60"/>

</div>
<div>

### 8080 (1974)
*   16-bit address bus
*   Used in Altair computer (early hobbyist PC)
*   **4500** transistors
*   **2** MHz

<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi9gTn8g6db73nZWWAjoC1lJAUhtltwyzQ0Q&s" class="rounded-lg w-45"/>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/KL_Tesla_MHB8080.jpg/500px-KL_Tesla_MHB8080.jpg" class="rounded-lg w-60"/>


</div>
</div>

---

## Intel 8086 / 8088 (1978)

<div class="grid grid-cols-2 gap-4">
<div>

*   **16-bit processor** that introduced the **x86 architecture**.
*   The **8088** (with an 8-bit external bus) was famously used in the original **IBM PC**.
*   **29k** transistors using a **3 µm** process.
*   Clock speed: **5-10 MHz**.

</div>
<div>

<img src="https://static.righto.com/images/8086-overview/metal-w600.jpg" class="rounded-lg w-60"/>
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhlcJXUHfM8Lb8X3RPNDlpdsdqW29qxL9WLg&s" class="rounded-lg w-80 mt-4"/>

</div>
</div>

---

## Intel 80286 & 80386

<div class="grid grid-cols-2 gap-8">
<div>

### 80286 (1982)
*   Introduced **protected mode**, enabling multitasking.
*   Used in the **IBM PC/AT**.
*   **134k** transistors, **6-12 MHz**.
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Intel_80286_die.JPG/250px-Intel_80286_die.JPG" class="rounded-lg w-60 mt-2"/>

</div>
<div>

### 80386 (1985)
*   First **32-bit** x86 processor.
*   A huge leap, enabling modern operating systems.
*   **275k** transistors, **16-33 MHz**.
<img src="https://upload.wikimedia.org/wikipedia/commons/4/44/Intel_80386_IV_die.JPG" class="rounded-lg w-80 mt-2"/>

</div>
</div>

---

## Intel 80486 & Pentium

<div class="grid grid-cols-2 gap-8">
<div>

### 80486 (1989)
*   Integrated the **floating-point unit (FPU)** on-chip.
*   Included on-chip cache for the first time.
*   **1.2M** transistors, **25-100 MHz**.
<img src="https://upload.wikimedia.org/wikipedia/commons/c/cc/Cyrix_Cx486DLC_die.JPG" class="rounded-lg w-60 mt-2"/>

</div>
<div>

### Pentium (1993)
*   Introduced a **superscalar** architecture (could execute multiple instructions per clock cycle).
*   **3.1M** transistors, **60-300 MHz**.
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Intel_Pentium_P54C_die.jpg/1200px-Intel_Pentium_P54C_die.jpg" class="rounded-lg w-70 mt-2"/>

</div>
</div>

---

## Pentium Evolution & The Core Era

<div class="grid grid-cols-2 gap-8">
<div>

### Pentium 4 (2000)
*   Focused on high clock speeds with its **NetBurst** architecture.
*   Reached speeds up to **3.8 GHz**.
*   **42M - 125M** transistors.
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Intel%40130nm%40NetBurst%40Northwood%40Pentium4%40SL6PF_DSC07596_%2832847415126%29.jpg/250px-Intel%40130nm%40NetBurst%40Northwood%40Pentium4%40SL6PF_DSC07596_%2832847415126%29.jpg" class="rounded-lg w-60 mt-2"/>

</div>
<div>

### Core 2 (2006)
*   Shifted focus from clock speed to **efficiency and multi-core** performance.
*   The **Core architecture** was a major success.
*   **291M** transistors (in dual-core variants).
<img src="https://images.bit-tech.net/content_images/2006/07/intel_core_2_duo_processors/die-large.jpg" class="rounded-lg w-80 mt-2"/>

</div>
</div>

---

## Intel Core i-Series (2008-Present)

*   Introduced the **Core i3, i5, and i7** branding, segmenting the market.
*   Integrated the memory controller and, later, graphics onto the CPU die.
*   Focus on multi-core performance, power efficiency, and specialized instructions (e.g., AVX).
*   Transistor counts have grown into the **billions**, with processes shrinking to a few nanometers.

<img src="https://cdn.mos.cms.futurecdn.net/FGk2jZwutGu5Rzv8fJ8RL5-1638-80.jpg" class="rounded-lg w-1/2 mx-auto mt-4"/>

---

## Intel Summary

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



---

## Intel Summary (Continue)

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

---

# Moore's Law

<div class="grid grid-cols-2 gap-4">
<div>

*   **Gordon Moore**: co-founder of Intel.
    *   Predicted that number of transistors per chip would grow exponentially (double every 18 months).
    *   Exponential improvement in technology is a natural trend: steam engines, dynamos, automobiles.
*   Today, the price of a transistor is less than a grain of rice.

</div>
<div>

![Moore's Law Graph](https://upload.wikimedia.org/wikipedia/commons/0/00/Moore%27s_Law_Transistor_Count_1970-2020.png)

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
<img src="https://mecha-tronx.com/wp-content/uploads/2022/08/IC-74HC00-2-INPUT-NAND-Gate-7400-1.jpg" class="rounded-lg" alt="7400 NAND Gate IC">
<img src="https://www.hackatronic.com/wp-content/uploads/2025/04/7400-Quad-NAND-Gate-Pinout-Diagram.webp" class="rounded-lg bg-white p-2" alt="7400 Logic Diagram">
</div>
<p class="text-sm text-center mt-2">A 74HC00 chip containing four separate NAND gates.</p>

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

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Xilinx_Spartan_FPGA_die_shot.jpg/1994px-Xilinx_Spartan_FPGA_die_shot.jpg" class="rounded-lg w-80" alt="FPGA Die">
<p class="text-sm text-center mt-2">Die of an FPGA showing logic cells and interconnection wires.</p>

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

<img src="https://developer.nvidia.com/blog/wp-content/uploads/2018/09/image7.jpg" class="rounded-lg" alt="ASIC Die">
<p class="text-sm text-center mt-2">An example of a complex ASIC: NVIDIA's Turing GPU.</p>

---

# The Development Process

<div class="grid grid-cols-2 gap-8">

![Development Process 1](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-35-image.png)

![Development Process 2](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-36-image.png)

</div>