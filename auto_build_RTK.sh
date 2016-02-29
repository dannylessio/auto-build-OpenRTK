#!/bin/bash

# Pick up the number of processors
echo "Insert the number of your processor's cores followed by [ ENTER ]"
read core

if [ ! -d "$ITK" ]; then
	# Control will enter here if $DIRECTORY doesn't exist.
	git clone git://itk.org/ITK.git
	cd ITK
	cd ..
fi

if [ -d "$ITK-bin" ]; then
	# Control will enter here if $DIRECTORY exists.
	echo "Removing ITK-bin"
fi

mkdir ITK-bin
cd ITK-bin
cmake -DModule_ITKReview=ON -DITK_USE_FFTWD=ON -DITK_USE_FFTWF=ON -DBUILD_DOCUMENTATION=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF ../ITK
make -j $core
path_of_ITK=pwd
cd ..

git clone git://github.com/SimonRit/RTK.git
mkdir RTK-bin
cd RTK-bin
cmake -DITK_DIR=$path_of_ITK -DCMAKE_BUILD_TYPE=Release ../RTK
make -j $core
cd ..

