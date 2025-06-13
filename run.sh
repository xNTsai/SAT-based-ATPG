#!/bin/bash
make
g++ -o runpbo runPBO.cpp

./abc -f cnf_gen.dofile
./abc -f pbo_solve.dofile
