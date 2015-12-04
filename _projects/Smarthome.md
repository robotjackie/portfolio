---
layout: project
title: Smarthome/IoT Motes
date: February 20, 2015
image: haptics.jpg
---
#### Status - NOT MAINTAINED. Please don't message me about this project.

## Overview
(Private repo because it contains our solutions for class assignments: 
https://github.com/robotjackie/tinyos_smarthome)

*** blah blah blah smarthome, light, humidity, temperature
communicate to each other - sensor networks

## General Approach
Our task was is to design and program a TinyOS application to run on two TelosB motes, utilizing the built-in light, temperature, and humidity sensors to provide real-time notifications and “display” the notification on the on-board available LEDs. In addition, temperature sensors would transmit the data from one mote to another, and the second mote would transfer light data to the first, blinking on and off different LEDs.


### Method
nesC
reminded me of Arduino code, with separate "configuration" and "implementation" functions
like "setup" and "loop" functions
first calls components with "provides" (general things like LEDs, timer) and "uses" (like radio functions)
is event-driven 

wrote code for separate sensor modules, splitting up temperature, light, and humidity across modules

need Makefile, header file, and the actual code .nc file

### Installation
http://tinyos.stanford.edu/tinyos-wiki/index.php/Automatic_installation

Note: TinyOS only offered support up to 12.04 (natty) and only supported 32-bit libraries. I had trouble installing several key libraries on Ubuntu 14.04.

### Getting Started and Compiling
http://tinyos.stanford.edu/tinyos-wiki/index.php/The_simplest_TinyOS_program

### Debugging
LEDs and print to Serial

## Results
It works

## What I Learned
 Through this project, we learned how to send data to another TelosB mote with its native sensors, and display this both as a print to the command line as well as blinking on-board LEDs on and off. We were able to successfully complete the project and the extra credit, which gave us a feeling of pride and accomplishment.

### Sources
(1) TinyOS Wiki: http://tinyos.stanford.edu/tinyos-wiki/index.php/Main_Page

(2) Tutorials: http://www.tinyos.net/tinyos-1.x/doc/tutorial/

(3) 130+ pg book on TinyOS and programming: http://www.tinyos.net/tinyos-2.x/doc/pdf/tinyos-programming.pdf

(4) http://www.wsnmagazine.com/TinyOS%20tutorial.pdf

