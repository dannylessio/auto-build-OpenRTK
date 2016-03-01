# auto-build-RTK
This repo contains a bash script that fully automates the compilation process of OpenRTK for a Linux machine.<br>
It simply follows the 0-1-2-3 installation steps that can be found  [here](http://wiki.openrtk.org/index.php/Main_Page#Step_0_-_Getting_ITK). <br>
It compiles with the " make -j " option and also adds the -fPIC value inside CMAKE_CXX_FLAGS and CMAKE_C_FLAGS options in order to prevent troubles with other software that requires ITK or RTK libraries like SimpleITK.

Requirements:
- A good internet connection.
- Enough RAM memory. If you have less than 2 GB, make sure to have enabled a swap partition.
- C/C++ compiler.
- Cmake.
- Git.
- Wget.

How to use it: 
- Create an empty directory that will hosts RTK and ITK sources.
- Enter to this folder.
- Download this [file](https://raw.githubusercontent.com/dannylessio/auto-build-RTK/master/auto_build_RTK.sh) with Wget:<br>
  ```
  wget https://raw.githubusercontent.com/dannylessio/auto-build-RTK/master/auto_build_RTK.sh
  ```
  <br>
- Give the execution privileges to the .sh script.<br>
 ```
 chmod +x auto_build_RTK.sh
 ```
 <br>
- Execute it.<br>
  ```
   ./auto_build_RTK.sh
  ```
  <br>
- Hope, and take a long coffee.
- If you see the "RTK Hello World!" string, all is working fine and the compilation process is done.
