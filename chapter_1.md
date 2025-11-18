---
theme: 'default'
title: 'Digital Circuits and Logic Design'
---

# Digital Circuits and Logic Design

## Lecture 1: Digital System

<div class="abs-br m-6 text-sm">
010113025 Digital Circuits and Logic Design
</div>

---
layout: two-cols
---

# Digital and Analog


* A **digital signal** is a signal that at any time can have one of a finite set of possible values, and is also known as a *discrete signal*.



* An **analog signal** can have one of an infinite number of possible values, and is also known as a *continuous signal*.

:: right ::

![Stairs](https://crossroadenergy.com/wp-content/uploads/2024/02/Digital-Vs-Analgo-1200x1200.jpg.webp)


---

# Switch and Binary Representation

The most common digital signals are those that can have one of only two possible values, like on or off (0 and 1) => switch => a binary representation.

<div class="grid grid-cols-2 gap-4 mt-4">

![Circuits](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-3-image-1.png)

![Representations](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-3-image-2.png)

</div>

---

# Switch and Binary Representation

A digital circuit representing the number 25:

<div class="text-center">

![Circuit for 25](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-4-image.png)

</div>

---

# Digital and Analog

<div class="grid grid-cols-2 gap-8">
<div>

![Sampling](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-5-image.png)

</div>
<div>

<br><br><br>

T = sampling period
<br>
f<sub>s</sub> = 1/T = sampling frequency

</div>
</div>

---

# Digital and Analog

<div class="text-center">

![ADC and DAC](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-6-image.png)

</div>

More and more analog products are becoming digital.

---

# Ex. Keypad Encoding

<div class="grid grid-cols-2 gap-4">

![Button](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-7-image-1.png)

![Encoding](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-7-image-2.png)

</div>

---

# Ideal Switch to Real Switch

<div class="grid grid-cols-2 gap-4">

![Ideal Switch](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-8-image-1.png)

![Real Switches](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-8-image-2.png)

</div>

---

# Digital Hardware

<div class="grid grid-cols-2 gap-4">
<div>

*   1930's Relays
*   1940's VacuumTube – No moving part, Faster than Relays

</div>
<div>

![Relay](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-9-image-1.png)

![Vacuum Tubes](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-9-image-2.png)

</div>
</div>

---

# Digital Hardware

*   Logic circuits are used to build computer hardware as well as other products
*   Late 1960's and early 1970's saw a revolution in digital capability
    *   Smaller transistors
    *   Larger chip size
*   More transistors/chip gives greater functionality, but requires more complexity in the design process

---

# ENIAC - The First Electronic Computer
### ENIAC (Electrical Numerical Integrator And Calculator) 1946

<div class="grid grid-cols-2 gap-4">
<div>

![ENIAC](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-11-image.png)

</div>
<div>

*   5000 addition per second OR 400 multiplications per second
*   (200,000 times speed up compared with hand calculation)

</div>
</div>

---

# ENIAC - The First Electronic Computer

<div class="grid grid-cols-2 gap-4">
<div>

*   17,468 vacuum tubes
*   70,000 resistors
*   10,000 capacitors
*   1,500 relays
*   6,000 manual switches
*   160 kilowatts
*   167 square meters
*   30 tons

**Size:**
*   -80 feet long
*   -30 feet wide
*   -8.5 feet high

</div>
<div>

![ENIAC](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-12-image.png)

</div>
</div>

---

# The First 'BUG'

In 1947, Grace Murray Hopper was working on the Harvard University Mark II Aiken Relay Calculator (a primitive computer). On the 9th of September, 1947, when the machine was experiencing problems, an investigation showed that there was a moth trapped between the points of Relay #70, in Panel F.

![First Bug](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-13-image.png)

---

# The First Transistor (1947)

<div class="grid grid-cols-2 gap-4">
<div>

![First Transistor](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-14-image-1.png)

</div>
<div>

![Inventors](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-14-image-2.png)
John Bardeen, William Shockley and Walter Brattain

</div>
</div>

---

# The First Integrated Circuit (IC)

<div class="grid grid-cols-2 gap-4">
<div>

![First IC](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-19-image.png)

<p class="text-sm">
The first working integrated circuit was created by Jack Kilby in 1958. It contains a single transistor and supporting components on a slice of germanium and measures 1/16 by 7/16 inches (1.6 x 11.1 mm).
</p>

</div>
<div>

*   Jack Kirby, invented Integrated Circuits in 1958 at Texas Instruments.
*   He argued that by putting all electronic components into a single die, performance would increase and cost would decrease.

</div>
</div>

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

![Moore's Law Graph](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-31-image.png)

</div>
</div>

---

# The Development Process

<div class="grid grid-cols-2 gap-8">

![Development Process 1](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-35-image.png)

![Development Process 2](https://raw.githubusercontent.com/slidevjs/docs-cn/main/public/assets/digital-1/page-36-image.png)

</div>