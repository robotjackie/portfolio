---
layout: project
title: Arduino Camera Project
date: February 20, 2015
image: mega2560_ov7670_side.jpg
---
### STATUS: Not maintained. Please don't contact me about this project.

## Overview
For this project I tried to get an Omnivision 7670 camera working with various Arduinos. I partially succeeded in getting some images off, but I was not successful in getting quality image.

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/mega2560_ov7670.JPG?raw=true"></center>

The Omnivision (OV)7670 camera comes in 2 forms: with a memory chip, and without. The one with a memory chip 

ALB422
enough to store 1 image in YUV, at 2 bytes/pixel. 

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_with_fifo.JPG?raw=true">
<img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_non_fifo.JPG?raw=true">
</center>


camera case
unscrew cap

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_with_cap.JPG?raw=true"></center>


manual screw to change focus
golden finger connections, no case

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_golden_finger.JPG?raw=true"></center>



## Implementation
Nano

Mega2560

Mega clone

Pro Mini

Book code

Arduvision code - with Processing

## Technical Details

#### Camera components:

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_camera_components.png?raw=true"></center>


#### Pins: 


- 3V3 ----- input supply voltage (3V3)
- GDN ----- ground
- SIO_C --- SCCB interface control clock (Same/compatible with SCL on I2C. MAY NEED PULL-UP RESISTOR)
- SIO_D --- SCCB interface serial data (Same/compatible with SDA on I2C. MAY NEED PULL-UP RESISTOR)
- VSYNC --- frame synchronizing signal (output - pulses at beginning and end of each frame)
- HREF ---- line synchronizing signal (unused)
- D0-D7 --- data port (output)
- RST --- reset port (triggered when LOW)
- PWDN ---- power selection mode (triggered when HIGH)
- STROBE -- photographed flash control port (unused)
- FIFO_RCK --- FIFO memory read clock control terminal
- FIFO_OE ---- FIFO off control (connect to GROUND RAIL)
- FIFO_WRST-FIFO write pointer reset terminal
- FIFO_RRST-FIFO read pointer reset terminal

(From electrodragon - see Sources at end)

Pin connections:

With Arduino Pro Mini
doesn't use all the data pins
<center><img src="http://2.bp.blogspot.com/-AC4P0mwMXkk/VCb21n9EIZI/AAAAAAAABAI/jdVbCIMCVhk/s1600/conections.png"></center>

#### Timing diagrams:

<center><img src="http://www.electrodragon.com/w/images/7/7f/7670_sequence.jpg"><img src="http://www.electrodragon.com/w/images/5/5d/7670_sequence2.jpg"></center>

#### Image color formats
The formats used by the OV7670 are the RGB565, RGB555 and RGB444
RGB565 is 5 bits for R, 6 bits for G, and 5 bits for B. So that means Red is split up into 2^5=32 different levels of red, Green into 2^6=64, etc.
In addition there are formats with Yxxxx, such as YCbCr and YUV. 

#### Libraries
See "Sources" at bottom for different libraries with different microcontrollers.

The main two that I used are from the book "Beginning OV7670 with Arduino," and the Arduvision library.

#### Register Settings

## Results

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_garbage.png?raw=true"></center>

Brightest blog detection, at 2-3 fps: 

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_lightblob1.png?raw=true">
<img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_lightblob2.png?raw=true">
</center>


## Challenges

BE CAREFUL: Some libraries say "OV7670" in the name of the file, but you have to look at the code and description carefully. Some libraries floating out there are sometimes for other cameras, like OV7076, or other cameras starting with "OV," which make it easy to mistakenly try to get to work with your OV7670 camera. 


Decrease baud rate for Serial

From the Arduvision blog:

> In the arduino sketch look for the line:
>    static const unsigned long _BAUDRATE = 500000;
> 
> And in the processing sketch, in the globalDefinitions.java tab:
>    public final static int BAUDRATE = 500000;
> 
> Try with substituting the 500000 for 115200.

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_SD_fail.png?raw=true"></center>

SD card fragile / somewhat broken - used rubber band to hold together. Solved some funny SD card problems, e.g. taking 70 seconds + 0 seconds for 2 images and re-writing old images
or would work, but take 70 seconds to write 1 image, 0 seconds to write other images. 
Or would rewrite over old images

tried SD sample code
shorter wires
reformatted with FAT32 - 4 GB
held down with rubber band
worked

Photon bug:
To solve the I2C issue, can manually hold 3V3 wires to both wires, reboot the Photon (possibly to Safe Mode), and flash code to it

#### Output format: YUV 
<yuv.jpg>
2400 lines, each line has 8 words, each word is 4-digit hex. 
1 hex character is half a byte, so each word is 2 bytes.
2 bytes * 8 per line * 2400 lines = 19200, which is the QQVGA resolution (120x160).
so each 2-byte word is one pixel, which is what we expected.

Used free software trial of "All to Real Converter Standard" to convert images to JPG.
Tried many different softwares and online apps, this was the only one that worked, and it was not very convenient. 
15-day free trial

## Sources

(1) _Beginning Arduino with OV7670_ book [http://psycho-sphere.com/](http://psycho-sphere.com/) (The code can be found halfway down the page and downloaded as a zip)

(2) Arduvision library [https://github.com/dasaki/arduvision](https://github.com/dasaki/arduvision) and [theRandomLab blog post where it's from](http://therandomlab.blogspot.com.es/2014/09/arduvision-i-embedded-computer-vision.html#more), which has an extensive list of other links

(3) OV7670 Datasheet [downloads as PDF](http://www.electrodragon.com/w/File:OV7670_DS_(1_4).pdf)

(4) Electrodragon description [http://www.electrodragon.com/w/index.php?title=OV7670_Module#Demo_Code](http://www.electrodragon.com/w/index.php?title=OV7670_Module#Demo_Code)

(5) arndtjenssen GitHub library with AVR ATmega1284 to give ideas [https://github.com/arndtjenssen/ov7670](https://github.com/arndtjenssen/ov7670). An example of [pin wirings for the ATMega1284](https://github.com/arndtjenssen/ov7670/blob/master/ov7670_test/ov7670_ports.h)

(6) Several posts on this ThinkSmallThings blog can give you an idea [https://thinksmallthings.wordpress.com/2015/01/11/atmega328-ov7670-fifo-module-software/](https://thinksmallthings.wordpress.com/2015/01/11/atmega328-ov7670-fifo-module-software/)

(7) Video resources with the OV7670 that may help [http://www.yourepeat.com/g/OV7670](http://www.yourepeat.com/g/OV7670)

(8) More information on image formats: [http://embeddedprogrammer.blogspot.com.es/2012/07/hacking-ov7670-camera-module-sccb-cheat.html](http://embeddedprogrammer.blogspot.com.es/2012/07/hacking-ov7670-camera-module-sccb-cheat.html)

(9) GitHub code for OV7670, non-FIFO version: [https://github.com/eranws/ov7670-no-ram-arduino-uno](https://github.com/eranws/ov7670-no-ram-arduino-uno). This is based on [ComputerNerd's library](https://github.com/ComputerNerd/ov7670-no-ram-arduino-uno)

(10) Another OV7670 register library: [https://github.com/dalmirdasilva/ArduinoCamera/tree/master/CameraOV7670](https://github.com/dalmirdasilva/ArduinoCamera/tree/master/CameraOV7670)

(11) Another register library, from Japan; haven't used it: [http://www.suwa-koubou.jp/micom/NetCamera/ov7670.c](http://www.suwa-koubou.jp/micom/NetCamera/ov7670.c)
