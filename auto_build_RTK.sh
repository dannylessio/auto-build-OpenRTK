#!/bin/bash

# Check if some of the requirements are installed
if hash make 2>/dev/null; then
	echo "C/C++ compiler not found. Aborting."
	exit 1
fi

if hash cmake 2>/dev/null; then
	echo "CMake not found. Aborting."
	exit 1
fi

if hash git 2>/dev/null; then
	echo "Git not found. Aborting."
	exit 1
fi

# Pick up the number of processors
n_of_cores=$(grep -c ^processor /proc/cpuinfo)

if [ ! -d "./ITK" ]; then
	git clone git://itk.org/ITK.git
fi

if [ ! -d "./ITK-bin" ]; then
	mkdir ITK-bin
	cd ITK-bin
	cmake -DModule_ITKReview=ON -DITK_USE_FFTWD=ON -DITK_USE_FFTWF=ON -DBUILD_DOCUMENTATION=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF ../ITK
	make -j $n_of_cores
	cd..
fi

if [ ! -d "./RTK" ]; then
	git clone git://github.com/SimonRit/RTK.git
fi

if [ ! -d "./RTK-bin" ]; then
	# Getting the full path of ITK-bin
	cd ITK-bin
	path_of_ITK=$(pwd)
	cd ..

	# Compile RTK
	mkdir RTK-bin
	cd RTK-bin
	cmake -DITK_DIR=$path_of_ITK -DCMAKE_BUILD_TYPE=Release ../RTK
	make -j $n_of_cores
	cd ..
fi



