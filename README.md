# auto-build-OpenRTK
This repo contains a script that fully automates the compilation process of OpenRTK for a Linux machine.
It simply follows the installation tutorial that can be found [here](http://wiki.openrtk.org/index.php/Main_Page#Step_0_-_Getting_ITK).

Requirements:
- A good internet connection.
- Enough RAM memory. If you have less than 2 GB, make sure to have enabled a swap partition.
- C/C++ compiler.
- Cmake.
- Git.
- wget.

How to use it: 
- Create an empty directory that will hosts all the OpenRTK and ITK sources.
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

