# SAT-based ATPG with Incremental PBO on ABC

## 🔍 Introduction

This project implements an improved SAT-based Automatic Test Pattern Generation (ATPG) framework with incremental Pseudo Boolean Optimization (PBO) for better test compaction. Built on top of the ABC logic synthesis and verification tool from UC Berkeley, our system integrates circuit optimization, fault list generation, SAT-based test pattern generation, and PBO-driven compaction into a single, extensible research platform.

Key features:
- Full support for single stuck-at fault modeling
- Incremental SAT solving for complete fault list coverage
- Integration with external SAT and PBO solvers
- AIG-based circuit optimization using ABC infrastructure
- Compact test set generation using Mixed-Bag PBO solver

---

## 📦 Cloning the Repository

```bash
git clone https://github.com/xNTsai/SAT-based-ATPG.git
```

---

## ⚙️ Compiling

### Build the ABC-based ATPG Tool

```bash
cd SAT-based-ATPG
make
g++ -o runpbo runPBO.cpp
```

### Build the Mixed-Bag PBO Solver

```bash
git clone https://bitbucket.org/coreo-group/pbcomp24-cg.git
cd pbcomp24-cg
mkdir build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -Dpapilo=ON -Dscip=ON -Dgmp=ON -Dsoplex=OFF
cmake --build build -t mixed-bag
```

> ⚠️ If your `cmake` version is outdated, you may need to remove the line `cmake_policy(SET CMP0135 NEW)` from `CMakeLists.txt`.

### Build the Kissat SAT Solver

```bash
./configure && make test
```

---

## 🚀 Running the Sample Test Case

```bash
./abc -f cnf_gen.dofile
./abc -f pbo_solve.dofile
```

Output patterns will be stored in `atpg.txt`.

---

## 🧩 Custom Commands for our work on ABC

This project introduces several new commands in ABC for ATPG:

- `fault_gen [-c] [-l]`
  - Generate stuck-at faults for the current network
  - Options:
    - `-c`: Use checkpoint fault generation method
    - `-l`: Use collapsing fault generation method

- `fault_sim [-c]`
  - Insert the faulty gate x, y based on the fault list
  - Options:
    - `-c`: Insert the PBO constraint gates based on the fault list

- `ntk_combine`
  - Combines good and faulty circuits to generate fault detection logic

- `fault_constraint`
  - Builds the constraint network used for fault dropping

- `add_tp <pattern>`
  - Stores a test pattern from the PBO solver

- `insert_tp [-f]`
  - Maps the latest test pattern into the current network
  - Options:
    - `-f`: Maps the latest test pattern into the constraint network

- `pbo`
  - Create child process to run PBO on generated cnf file

- `print_faults [-sh]`
  - Prints the list of faults in the current network
  - Options:
    - `-s`: Print fault statistics [default = no]
