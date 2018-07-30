#!/bin/bash

# Check if some of the requirements are satisfied
command -v gcc >/dev/null 2>&1 || { echo >&2 "C/C++ compiler is not installed. Aborting."; exit 1; }
command -v cmake >/dev/null 2>&1 || { echo >&2 "Cmake is not installed. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed. Aborting."; exit 1; }

# If required, clean up and start again
if [[ $1 == "clean" ]]; then
	echo "Cleaning all directories for fresh download and compile"
	rm -rf ITK*
	rm -rf RTK*
elif [[ $1 == "build" ]]; then
	echo "Cleaning build directories for fresh compile"
	rm -rf ITK-bin
	rm -rf RTK-bin
fi
	
# Doesn't seem to like multiple threads on macOS
unamestr=`uname`
if [[ $unamestr == "Darwin" ]]; then
	num_make_threads="1"
else
	num_make_threads=""
fi

# Download ITK source
if [ ! -d "./ITK" ]; then
	git clone http://itk.org/ITK.git
	cd ITK
	git checkout tags/v4.13.0
	cd ..
fi

# Build ITK
if [ ! -d "./ITK-bin" ]; then
	mkdir ITK-bin
	cd ITK-bin
	cmake -DModule_ITKReview=ON -DITK_USE_FFTWD=ON -DITK_USE_FFTWF=ON -DBUILD_DOCUMENTATION=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC ../ITK
	make -j $num_make_threads
	cd ..
fi

# Download RTK source
if [ ! -d "./RTK" ]; then
	git clone http://github.com/SimonRit/RTK.git
	cd RTK
	git checkout tags/v1.4.0
	cd ..
fi

# Build RTK
if [ ! -d "./RTK-bin" ]; then
	# Getting the full path of ITK-bin
	cd ITK-bin
	path_of_ITK=$(pwd)
	cd ..

	# Compile RTK
	mkdir RTK-bin
	cd RTK-bin
	cmake -DITK_DIR=$path_of_ITK -BUILD_SIMPLERTK=ON -WRAP_PYTHON=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC ../RTK
	make -j $num_make_threads
	cd bin
	./HelloWorld
	cd ../..
fi



