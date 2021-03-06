#!/bin/bash
echo Building OpenPLC environment:

echo [MATIEC COMPILER]

echo [LADDER]
cp ./matiec_src/bin_win32/iec2c.exe ./
cp ./matiec_src/bin_win32/*.dll ./
./iec2c.exe ./st_files/blank_program.st
mv -f POUS.c POUS.h LOCATED_VARIABLES.h VARIABLES.csv Config0.c Config0.h Res0.c ./core/

echo [GLUE GENERATOR]
cd glue_generator_src
g++ glue_generator.cpp -o glue_generator
cd ..
cp ./glue_generator_src/glue_generator.exe ./core/glue_generator.exe

cd core
rm -f ./hardware_layer.cpp
rm -f ../build_core.sh
echo The OpenPLC needs a driver to be able to control physical or virtual hardware.
echo Please select the driver you would like to use:
OPTIONS="Blank Fischertechnik RaspberryPi Unipi Arduino Arduino+RaspberryPi Simulink "
select opt in $OPTIONS; do
	if [ "$opt" = "Blank" ]; then
		cp ./hardware_layers/blank.cpp ./hardware_layer.cpp
		cp ./core_builders/build_win.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "Fischertechnik" ]; then
		cp ./hardware_layers/fischertechnik.cpp ./hardware_layer.cpp
		cp ./core_builders/build_rpi.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "RaspberryPi" ]; then
		cp ./hardware_layers/raspberrypi.cpp ./hardware_layer.cpp
		cp ./core_builders/build_rpi.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "UniPi" ]; then
		cp ./hardware_layers/unipi.cpp ./hardware_layer.cpp
		cp ./core_builders/build_rpi.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "Arduino" ]; then
		cp ./hardware_layers/arduino.cpp ./hardware_layer.cpp
		cp ./core_builders/build_win.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "Arduino+RaspberryPi" ]; then
		cp ./hardware_layers/arduino.cpp ./hardware_layer.cpp
		cp ./core_builders/build_rpi.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	elif [ "$opt" = "Simulink" ]; then
		cp ./hardware_layers/simulink.cpp ./hardware_layer.cpp
		cp ./core_builders/build_win.sh ../build_core.sh
		echo [OPENPLC]
		cd ..
		./build_core.sh
		exit
	else
		#clear
		echo bad option
	fi
done
