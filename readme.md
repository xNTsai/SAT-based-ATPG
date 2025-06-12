# Compiling

To build the program

 * Run `make`
 * Run `g++ -o runpbo runPBO.cpp`

To build mixed-bag solver
 * `cd pbcomp24-cg`
 * `mkdir build`
 * `cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -Dpapilo=ON -Dscip=ON -Dgmp=ON -Dsoplex=OFF`
 * `cmake --build build -t mixed-bag`
Note: if the cmake version is not the latest, line "cmake_policy(SET CMP0135 NEW)" in the CMakeLists.txt can be removed.

To build kissat solver
 * Run `./configure && make test`

# To Run the Sample Test Case
 
 * `./abc -f atpg1.dofile && ./abc -f atpg2.dofile`
The output patterns will be stored at atpg.txt
