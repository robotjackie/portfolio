---
layout: project
title: Security Camera Networking
date: February 20, 2015
image: microchip_back.jpg
---

## Overview
Based off of PIC32MX used in our Mechatronics class, we tried to get its more powerful cousin, the PIC32MZ to stream video to the cloud.

With Nurullah Gulmus and Ed Kim.

Microchip 

The project profile picture shows the MEB-II from the back, with the Microchip Starter Board attached.

This is the front, with a display screen.

<center><img src="http://i.imgur.com/rWGBN0E.jpg" width="400"></center>

## Implementation

The folks at Microchip were nice enough to donate a board for 

TCP/IP worked

easyWiFiConfig worked

On-board camera, which was OVXXXX, worked

Could see the image live on the monitor

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/meb_selfie.jpg" width="300"></center>

The most helpful PDF is going to be found under your Harmony install directory, under "docs" or "help" or whatever it was. It's a ginormous PDF with a short introduction of what Harmony is, how to create a new project, how to install and use MHC (this is the plug-in you installed yesterday Jackie), and most importantly the API and prerequisite drivers for all the peripherals.

The other useful PDF is probably this one: http://ww1.microchip.com/downloads/en/DeviceDoc/50002027C.pdf It talks about configuration files and everything else you need to know.

As far as hardware goes, this is the one we probably need when soldering: http://ww1.microchip.com/downloads/en/DeviceDoc/70005148B.pdf The MEB II also uses the OVM7690, so that's pretty neat and helpful.

The demonstrations are all outlined in the Harmony PDF. The ones relevant to us are probably gfx_camera (I got this running yesterday), tcpip_udp_client, and wifi_easy_configuration. The tcpip one we can't really run since we need an Ethernet expansion, and the WiFi one can't be run until we remove the resistor and add the required jumper cable.

We'll have to use the MHC to look at the required prereqs for each of those demos and combine them to how we need. 

gfx_camera just writes to a framebuffer array and has a callback for horizontal and vertical sync (http://www.ovt.com/uploads/parts/OVM7690_PB(1.0)_web.pdf detailed here), so it shouldn't be difficult to transform those into RTP packets and send them over. 

Right now, we have an AWS server that receives payloads of this format: https://tools.ietf.org/html/rfc4421. I have the encoding code for Java, so I'll need to rewrite that in C for the microprocessor, and then figure out how to use the WiFi module to send that data. 

Later when working with compressed video, we'll probably need to re-encode the packets into this format: https://tools.ietf.org/html/rfc6184.

1) Open Project > gfx_camera 

2) Choose the EC SK configuration 

3) Build and Clean 

4) Connect the PIC microUSB to USB 

5) Make and Install Program, choosing the Starter Kit as the ICE

Nope, should be the same PIC version. Make sure it says pic32mz2048ech144 though...

Hm.... Do you have the right configuration? At the top, you're able to choose the configuration. Make sure it's not the ETH SK one.


## Challenges

Microchip is very poorly maintained

Technical support is lacking and takes weeks

Forums are not helpful

Code is poorly documented and long

Product error - had to remove a resistor and solder a wire in order to get WiFi to work

<center><img src="http://i.imgur.com/sXaJaMT.jpg" width="400"></center>

Northwestern networks were difficult - couldn't connect. Also, couldn't use Guest Network. Had to use home network or turn phone into a hotspot.

### Sources
Code

GitHub
