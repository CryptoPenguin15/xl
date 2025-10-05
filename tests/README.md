# xl-2025 tests

Set the field, Q, and the size of the system, M and N, in the Makefile.  
There are implementations for **F2**, **F16**, and **F31**.

---

## MQ Challenge Types

Format see <https://www.mqchallenge.org/format.html>

There are six types of MQ challenges, categorized by the coefficient field **F**,  
the number of variables **n**, and the number of equations **m**:

| Type | Purpose     | Relation        | Field     |
|------|-------------|-----------------|-----------|
| I    | Encryption  | m = 2n          | GF(2)     |
| II   | Encryption  | m = 2n          | GF(2⁸)    |
| III  | Encryption  | m = 2n          | GF(31)    |

---

## Prereq

```sh
sudo apt install sagemath
sudo apt install libnuma-dev
sudo apt install libopenmpi-dev openmpi-bin
```

## Command

```sh
./xl --challenge FILE --all
```

```sh
./run.sh
```
