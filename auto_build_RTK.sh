#!/bin/bash

# Check if some of the requirements are satisfied
command -v gcc >/dev/null 2>&1 || { echo >&2 "C/C++ compiler is not installed. Aborting."; exit 1; }
command -v cmake >/dev/null 2>&1 || { echo >&2 "Cmake is not installed. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed. Aborting."; exit 1; }

if [ ! -d "./ITK" ]; then
	git clone http://itk.org/ITK.git
fi

if [ ! -d "./ITK-bin" ]; then
	mkdir ITK-bin
	cd ITK-bin
	cmake -DModule_ITKReview=ON -DITK_USE_FFTWD=ON -DITK_USE_FFTWF=ON -DBUILD_DOCUMENTATION=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF 
-DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC ../ITK
	make -j
	cd ..
fi

if [ ! -d "./RTK" ]; then
	git clone http://github.com/SimonRit/RTK.git
fi

if [ ! -d "./RTK-bin" ]; then
	# Getting the full path of ITK-bin
	cd ITK-bin
	path_of_ITK=$(pwd)
	cd ..

	# Compile RTK
	mkdir RTK-bin
	cd RTK-bin
	cmake -DITK_DIR=$path_of_ITK -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC ../RTK
	make -j
	cd bin
	./HelloWorld
	cd ..
	cd ..
fi



