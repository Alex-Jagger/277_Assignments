# 277_Assignments
## Installation
1. Clone the repo
	```sh
	git clone https://github.com/Alex-Jagger/277_Assignments.git
	```
 2. Install all these add-ons for MATLAB and Simulink
 * MATLAB Coder
 * Simulink Coder
 * Embedded Coder
 * Embedded Coder Support Package for Texas Instruments C2000 Processors 
 	* only TI Delfino F2837xD needed
	* Download other 3rd party software from TI's website
 * MATLAB Support for MinGW-w64 C/C++ Compiler
 
 ## Use
 1. Run /src/init.m at first everytime
 2. To run code on the MCU, use the Monitor & Tune mode
 3. Put all main models inside /src
 4. Put subsystems(model reference) insdie /lib
 5. Put test models inside /test
 6. Define global constants in /src/init.m using structures
 7. Make changes on individual branches first then merge to main
 
 ## Note
 1. Make sure there is no the absolute path of the repo doesn't contain spaces
 2. For Monitor & Tune mode, rember to chose the correct COM port
