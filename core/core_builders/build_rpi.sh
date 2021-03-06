#!/bin/bash
cd core
echo Generating object files...
g++ -I ./lib -c Config0.c
g++ -I ./lib -c Res0.c
echo Generating glueVars.cpp
./glue_generator
echo Compiling main program
g++ -I ./lib -lrt -lwiringPi -lpthread *.cpp *.o -o openplc
cd ..
