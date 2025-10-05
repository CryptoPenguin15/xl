# xl-2025

A fork of xl, extended linearization, by Tung Chou and Ruben Niederhagen (2013), modified by Anders Nilson (2025).
For more information, see the original project:
👉 [http://polycephaly.org/projects/xl/](http://polycephaly.org/projects/xl/)

## Build

sudo apt install sagemath
sudo apt install libnuma-dev
make

## XL Algorithm Overview

1. **Extend the system**
   Multiply the equations by all monomials up to a certain degree **D**.

2. **Linearize the system**
   Treat all monomials in the resulting system as individual variables.

3. **Solve the linear system**
   The solution to the linearized system is also a solution to the original MQ system.

---

**Coppersmith’s Block Wiedemann (BW)** algorithm adapted to solve the resulting linear system.

## Overview
- Removed dependency to boost library
- Fixed compiler warnings

## License
This project is licensed under the MIT License.
See [LICENSE](LICENSE) for details.

## Acknowledgements
Credits to the original authors.
