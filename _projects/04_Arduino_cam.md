---
layout: project
title: Light Blob Detection with $5 Camera
date: February 20, 2015
image: mega2560_ov7670_side.jpg
---
### STATUS: Not maintained. 

#### Please don't contact me about this project, unless you know how to make it work better.

<br/>

## Overview
For this project I tried to get an Omnivision 7670 camera working with various microcontrollers in order to detect blobs. I partially succeeded in that I could detect blobs of light, but I was not successful in getting quality images or video stream from the camera.

<br/>

<center><img src="http://i.imgur.com/7FdYsBd.jpg?1" height="700"></center>

The Omnivision OV7670 camera is a cheap, mobile-phone quality CMOS camera that in bulk sells for under $5 from Chinese suppliers on Alibaba. The camera is supposed to be able to stream VGA 640x480 resolution video at 30 frames per second. There are different libraries and projects written online to interface this camera with various microcontrollers, including Arduinos. The camera can take 3.3V input, and some online claim that 5V input may burn the image sensors.

In the States, one can buy a PCB module for this camera for $8-25 on [Amazon](http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dphoto&field-keywords=ov7670+fifo) that is is 3.5mm x 3.5mm x 3mm deep. The module comes in 2 forms: with a memory chip or without. It also comes in different form factors in the number of pins: 18, 20, 22, and 24 pins. This module breaks out and labels the camera's pins to male headers that can be soldered, or plugged into female/male ports for breadboarding. In addition, the module comes with a case that is much larger than the actual camera itself, with a removable camera cap. One can manually adjust the focus of the camera by screwing it left/right. 

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/ov7670_with_cap.jpg" width="250"></center>

To determine whether the OV7670 camera module has a memory chip or not, turn it over; the one with "FIFO" memory has a little horizontal memory chip (ALB422) on the back.

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/ov7670_with_fifo.jpg"  width="350"></center>

...while the OV7670 non-FIFO does not have it. 

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/ov7670_non_fifo.jpg" width="300"></center>

The one with a memory chip (ALB422) has enough space to store 1 image in raw Bayer image format, at 1 byte/pixel (more on YUV image format below, under "Image color formats"). It can hold 384K bytes. The module then allows the image to be read from the memory chip off 8 parallel data pins. 

This camera module makes prototyping with the camera quite easy. But in the case of manufacturing, the bare camera often comes with "Golden Finger" connections for each pin. Without the bulky case of the module, the form factor for the actual camera is quite small:

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/ov7670_golden_finger.jpg" width="300"></center>


## Implementation
I tried various microcontrollers with the OV7670 with FIFO, including different Arduinos and Arduino clones:

- Nano

- Mega2560

- Mega clone

- Pro Mini)

- [Particle Photon](https://docs.particle.io/datasheets/photon-datasheet/) (Arduino-code compatible microprocessor with built-in WiFi and online IDE). 

I bought many of my Arduino clones from [ValueHobby](www.valuehobby.com/arduino-and-cnc.html), which has very cheap Arduino clones and other electronic components in the $2-5 range. ValueHobby has standard ground shipping from Chicago, but I couldn't wait so I drove 40 minutes to their warehouse by O'Hare Airport to pick up my cheap electronics the day I ordered them.

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/cheap_arduinos.jpg" width="400"></center>
<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/cheap_arduinos1.jpg" width="400"></center>

<br/>

Fortunately, someone wrote an entire book on how to use the OV7670 + FIFO camera, with the Arduino Mega2560. This book can be bought on [Amazon](http://www.amazon.com/Beginning-Arduino-ov7670-Camera-Development/dp/1512357987) for ~$20. It contains a library for the register settings to make the camera work, explanation of its components and timing diagrams, tips for coding with the Arduino, as well as code for taking a picture and storing it in an SD card connected to the Arduino. The book's website is in "Sources" below.

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/beginning_ov7670_book.jpg" width="400"></center>

I also heavily leaned on code from a repo called Arduvision (see "Sources" below). The code is supposed to read a live stream of the camera feed, send it over Serial USB to the computer, and, with code for an IDE called Processing, display light blob tracking as well as live video. The light blob tracking code worked but the live video and images did not.

Lastly, Becca Friesen had worked with the non-FIFO camera on a PIC32MX microcontroller for finger detection, and she shared her code. I also worked with my classmate Athulya Simon, who tried to connect the OV7670 + FIFO camera with a PIC32MX, in order to drive a robotic car.

<br/>

## Technical Details

#### Register Settings

There are many registers for this camera, and many register functions have multiple register locations and settings. A comprehensive list of each register and bit can be found in the datasheet listed in the "Sources" section of this page. While the hard way to change registers is that one could write functions to change a bit and mask the rest in a register, the easy way is that the Arduino library has a write function from its Wire library to simplify this task. As long as one knows the location of the register and its value, one can easily change the settings. Libraries for existing register settings can be found in the code from the book as well as some of the repos under "Sources."

**Resolution**

The OV7670 camera has several options for resolution: VGA (640x480 pixels), QVGA (320x240 pixels), QQVGA (160x120 pixels), and weird resolutions like CIF (352x288 pixels) and QCIF (176x144 pixels). 

**Image format**

As mentioned above, the OV7670 can output various quality RGB, YUV, YCbCr, and Raw and processed Bayer.

**Frames per second**

Uses a clock to scale the frames per second. The max is 30 fps.

**Other settings**

In addition to setting the resolution, image format, and frames per second, the camera also has other neat register settings. These include:

- Exposure - the amount of light the image is exposed to over time; the more exposure time, the brighter the image.

- AEC (Auto Exposure Control) settings

- Gain - Some photographers say this is the electronic analog to focus, when the signal is amplified electronically. Something with more gain has more luminance in the photo.

- AGC (Auto Gain Control) settings

- White balancing - calibrating the "white point" of a photo. Depending on the lighting conditions, a pure white wall for example may seem off-white in the image. This lighting may throw off all the colors. By finding a constant red, green, and blue correction to calibrate the off-white as actual white, this correction may be applied to the rest of the pixels so that all colors may be shifted toward their actual color values regardless of the situational lighting condition.

- AWB (Auto White Balancing) - auto-sets the whitest point of a photo to find the above correction

- BLC (Black Level Calibration) - same as white balancing, above, but for black

- ABLC (Auto Black Level Calibration) - calibrates the blackest part of the image to true black, and corrects the rest of the colors

- NightMode - not entirely sure how this works, but it allows the camera to work in low light conditions. Perhaps it changes the exposure and gain settings.

- Demosaicing - processing the Raw Bayer image format into full color image

- 50/60 Hz detection - eliminate flickering from common fluorescent lights that run at 50 Hz, or monitors and screens that run at 60 Hz, presumably by dividing frame-rate or shutter speed by a constant to sync with the lighting pulse rate

- Other register settings, such as edge enhancement, denoising, image scaling, saturation, vertical/horizontal flipping, and other color correction (using gamma curves and histograms). There are also many registers whose functions are not explained as well as unused registers.

<br/>

#### Camera components:

The light hits the lens (A) and is fed into the image array (B), which is slightly larger than 640x480 (it's 656x488). The image array is covered by red, green, and blue sensors that only allow those parts of the wavelength in, arranged in a Raw Bayer format (see below under "Image color formats"). The image array transmits an analog intensity for each sensor. 

The first step in processing is analog processing (C), where AEC, AGC, ABLC etc. are applied. These settings can be automatic or manual, depending on the register settings (most likely they will be on automatic, for the sake of simplicity). Then other register settings (D) such as resolution, image format, frame rate etc. are called. These registers are read and changed from the SCCB interface (E) which is connected by I2C to the processor. There is also a register setting option of generating a test pattern (F).

The next step in processing is that the analog signal is converted to a 10 bit digital signal by an ADC (G). Settings such as 50/60 Hz Auto Detect (H) and exposure/gain detection and control (I) are utilized, followed by a DSP (digital signal processor) (J) that handles white balance and color correction such as gamma control, saturation, and de-noising. This is also where a color matrix is applied to convert colors, with a fixed formula multiplying RGB values by a conversion matrix set by camera registers to return YUV values, for example (see "Image color formats" below). The last processing register is an image scaler (K) that scales down VGA quality to the other available resolutions.

The image then goes into the FIFO memory buffer (L), which as explained above can store 1 VGA-resolution image at 1 byte/pixel in raw Bayer format. Finally the image can be read out of the 8-pin video port (M) through pins D0-D7, at 1 bit per pin at a time, for a speed of 1 byte per read cycle from all 8 pins.


<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_camera_components.png?raw=true" width="650"></center>


#### Pins: 

(From electrodragon - see "Sources" at end)

- 3V3 ----- input supply voltage (3V3)

- GDN ----- ground

- SIO_C ----- SCCB interface control clock (Same/compatible with SCL on I2C. MAY NEED PULL-UP RESISTOR)

- SIO_D ----- SCCB interface serial data (Same/compatible with SDA on I2C. MAY NEED PULL-UP RESISTOR)

- VSYNC ----- frame synchronizing signal (output - pulses at beginning and end of each frame)

- HREF ----- line synchronizing signal (unused)

- D0-D7 ----- data port (output)

- RST ----- reset port (triggered when LOW)

- PWDN ----- power selection mode (triggered when HIGH)

- STROBE ----- photographed flash control port (unused)

- FIFO_RCK ----- FIFO memory read clock control terminal

- FIFO_OE ---- FIFO off control (connect to GROUND RAIL)

- FIFO_WRST-FIFO ----- write pointer reset terminal

- FIFO_RRST-FIFO ----- read pointer reset terminal

<br/>

Pin connections:

With Arduino Pro Mini
doesn't use all the data pins
<center><img src="http://2.bp.blogspot.com/-AC4P0mwMXkk/VCb21n9EIZI/AAAAAAAABAI/jdVbCIMCVhk/s1600/conections.png" width="800"></center>

<br/>

#### Timing diagrams:

<center><img src="http://www.electrodragon.com/w/images/7/7f/7670_sequence.jpg" width="700">

<br/>

<img src="http://www.electrodragon.com/w/images/5/5d/7670_sequence2.jpg" width="700"></center>

<br/>

#### Image color formats
The formats used by the OV7670 are the RGB565, RGB555 and RGB444, 
RGB565 is 5 bits for R, 6 bits for G, and 5 bits for B. So that means Red is split up into 2^5=32 different levels of red, Green into 2^6=64, etc.

In addition there are formats with Yxxxx, such as YCbCr and YUV. 

Finally, there is the Raw Bayer formats. The image sensor contains sensors in a BG/GR Bayer filter pattern, with blue and green filters alternating in one row, and green and red in the next. These filters only allow light of that wavelength in. That means that a pixel must fill in the 2 missing colors in an estimating process called "demosaicing" in order to have full color. This outputs the processed Bayer format.

#### Libraries
See "Sources" at bottom for different libraries with different microcontrollers.

The main two that I used are from the book "Beginning OV7670 with Arduino," and the Arduvision library.
<br/>

## Results

At first I only got garbage. It looked like part of the image was being read and sent correctly, but perhaps the timing was off. Some of this was resolved by decreasing the baud rate to Serial, and also by re-wiring the connections more accurately and with shorter wires.

<br/>

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_garbage.png?raw=true" width="500"></center>

<br/>

Luckily, the light blob detection from the Arduvision library worked. It refreshed at about 2-3 fps and displayed a light blob from lighting sources, such as the overhead light in the room or my mobile camera's flash, and it displayed dark blobs when the light sources were covered. For some reason everything had a green-ish tinge. 

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_lightblob1.png?raw=true" width="450">
<img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_lightblob2.png?raw=true" width="450">
</center>

<br/>

However, the code from the _Beginning OV7670 with Arduino_ book did not work well. There were many problems (listed below in "Challenges"). The program could only take 1 picture at a time and save it to an SD card; it was unable to stream video. I tried to modify the code to output a video stream to Serial but did not succeed. 

Below is the image quality from pictures taken with the book's code. (In the right image, the dark blob on the lefthand side of the image is me!) As you can see it is quite blurry. I tried manually changing the focus, with little impact. The gain and other register settings were similar to the Arduvision library. I couldn't figure out why it didn't give me quality camera feed.

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/VGA0.jpg" width="450">
<img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/VGA1.jpg" width="450">
</center>

<br/>

#### Output format: YUV 

<br/>

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/yuv.jpg" width="800"></center>

2400 lines, each line has 8 words, each word is 4-digit hex. 
1 hex character is half a byte, so each word is 2 bytes.
2 bytes * 8 per line * 2400 lines = 19200, which is the QQVGA resolution (120x160).
so each 2-byte word is one pixel, which is what we expected.


## Challenges

- Be careful: Some libraries say "OV7670" in the name of the file, but you have to look at the code and description carefully. Some libraries titled "OV7670" are mislabeled and for other cameras, like OV7076, or other cameras starting with "OV." 

- Data sheet for pins may be different

- Decrease baud rate for Serial

- From the Arduvision blog:

Change the line "static const unsigned long _BAUDRATE = 500000;" in the Arduino code, and the line "public final static int BAUDRATE = 500000;" in the globalDefinitions.java file of the Processing sketch. Try with substituting the 500000 for 115200.

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/ov7670_SD_fail.png?raw=true" width="500"></center>

- SD card fragile / somewhat broken - used rubber band to hold together. Solved some funny SD card problems, e.g. taking 70 seconds + 0 seconds for 2 images and re-writing old images
or would work, but take 70 seconds to write 1 image, 0 seconds to write other images. 
Or would rewrite over old images

tried SD sample code
shorter wires
reformatted with FAT32 - 4 GB
held down with rubber band
worked

- code too large for a nano, must use mega

- mega clone failed. could reinstall firmware

- input voltage is wrong - used 4.7K resistors
switched with Athulya in case camera sensor burned out

- some pins are pull-LOW to activate, while others are pull-HIGH. this was tricky if not noticed.

- Photon bug:
To solve the I2C issue, can manually hold 3V3 wires to both wires, reboot the Photon (possibly to Safe Mode), and flash code to it

- Used free software trial of "All to Real Converter Standard" to convert images to JPG.
Tried many different softwares and online apps, this was the only one that worked, and it was not very convenient. 
15-day free trial

<br/>

## Sources

(1) _Beginning Arduino with OV7670_ book [http://psycho-sphere.com/](http://psycho-sphere.com/) (The code can be found halfway down the page and downloaded as a zip)

(2) Arduvision library [https://github.com/dasaki/arduvision](https://github.com/dasaki/arduvision) and [theRandomLab blog post where it's from](http://therandomlab.blogspot.com.es/2014/09/arduvision-i-embedded-computer-vision.html#more), which has an extensive list of other links

(3) OV7670 Datasheet [downloads as PDF](http://www.electrodragon.com/w/File:OV7670_DS_(1_4).pdf)

(4) Electrodragon background info and description of the OV7670 camera [http://www.electrodragon.com/w/index.php?title=OV7670_Module#Demo_Code](http://www.electrodragon.com/w/index.php?title=OV7670_Module#Demo_Code)

(5) arndtjenssen GitHub library with AVR ATmega1284, to give ideas on how to use it [https://github.com/arndtjenssen/ov7670](https://github.com/arndtjenssen/ov7670). An example of [pin wirings for the ATMega1284](https://github.com/arndtjenssen/ov7670/blob/master/ov7670_test/ov7670_ports.h)

(6) Several posts on this ThinkSmallThings blog can give you an idea on how to use it [https://thinksmallthings.wordpress.com/2015/01/11/atmega328-ov7670-fifo-module-software/](https://thinksmallthings.wordpress.com/2015/01/11/atmega328-ov7670-fifo-module-software/)

(7) Video resources with the OV7670 that may help [http://www.yourepeat.com/g/OV7670](http://www.yourepeat.com/g/OV7670)

(8) More information on image formats: [http://embeddedprogrammer.blogspot.com.es/2012/07/hacking-ov7670-camera-module-sccb-cheat.html](http://embeddedprogrammer.blogspot.com.es/2012/07/hacking-ov7670-camera-module-sccb-cheat.html)

(9) GitHub code for OV7670, non-FIFO version: [https://github.com/eranws/ov7670-no-ram-arduino-uno](https://github.com/eranws/ov7670-no-ram-arduino-uno). This is based on [ComputerNerd's library](https://github.com/ComputerNerd/ov7670-no-ram-arduino-uno)

(10) Another OV7670 register library: [https://github.com/dalmirdasilva/ArduinoCamera/tree/master/CameraOV7670](https://github.com/dalmirdasilva/ArduinoCamera/tree/master/CameraOV7670)

(11) Another register library, from Japan; haven't used it: [http://www.suwa-koubou.jp/micom/NetCamera/ov7670.c](http://www.suwa-koubou.jp/micom/NetCamera/ov7670.c)

(12) A register library. Has drivers for other OV cameras too. [https://stuff.mit.edu/afs/sipb/contrib/linux/drivers/media/i2c/ov7670.c](https://stuff.mit.edu/afs/sipb/contrib/linux/drivers/media/i2c/ov7670.c)
