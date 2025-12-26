# xl-2025

A fork of xl, extended linearization, by Tung Chou and Ruben Niederhagen (2013), modified by Anders Nilson (2025).
For more information, see the original project:
[http://polycephaly.org/projects/xl/](http://polycephaly.org/projects/xl/)

## Platforms
x86_64 (AMD64) and ARM64 (AArch64) supported

## Build

```sh
sudo apt install sagemath
sudo apt install libnuma-dev
make
```

## Verify

```sh
./tests/run_gf.sh
./tests/run.sh
```

## XL Algorithm Overview

**Coppersmith’s Block Wiedemann (BW)** algorithm adapted to solve the resulting linear system.

1. **Extend the system**
   Multiply the equations by all monomials up to a certain degree **D**.

2. **Linearize the system**
   Treat all monomials in the resulting system as individual variables.

3. **Solve the linear system**
   The solution to the linearized system is also a solution to the original MQ system.

---

## Overview
- ARM64 support added
- Verification of GF(2), GF(16) and GF(31)
- Removed dependency to the Boost library
- Fixed compiler warnings using C++17

## License
This project is licensed under the MIT License.
See [LICENSE](LICENSE) for details.

## Acknowledgements
Credits to the original authors.
