---
layout: project
title: Security Camera Networking Project
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

## PCB layouts

Nurullah created PCB layouts, but since we couldn't get it to work, we didn't print them.


<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/gerber.jpg" width="300"></center>

## Challenges

- The biggest challenge is that the Microchip code base and community are not helpful. The code base is not well maintained. The sample code is poorly documented and very long; the reference was 8,000 pages for just 1 document. Their online forums are not very active or helpful for our project. Technical support is lacking and took weeks for a response; they never answered our question or solved our issues. This made is extremely frustrating to use Harmony and the Microchip environment.

- The MEB-II came with a product error - we had to de-solder and remove a very small resistor with tweezers, and solder an extra wire connecting two pins in order to get the WiFi to work.

<center><img src="http://i.imgur.com/sXaJaMT.jpg" width="400"></center>

- Finally, connecting to Northwestern networks was difficult - we couldn't connect because of firewalls or networking. Also, we couldn't use the Guest network. We worked around this by using our home network, turning a phone into a hotspot, or using the "RoboLab" network in the Masters in Robotics lab.

### Sources

(1) [Our GitHub repo](https://github.com/robotjackie/PIC32_FIRMWARE/tree/master/jackie/firmware) with the PIC32MZ code

(2) Our [GitHub](https://github.com/robotjackie/PIC32_FIRMWARE/tree/master/Nurullah's%20Socket%20Board%20Designs) link for our socket board designs

(3) Microchip [MEB-II documentation](http://www.microchip.com/DevelopmentTools/ProductDetails.aspx?PartNO=dm320005-2&utm_source=&utm_medium=MicroSolutions&utm_term=&utm_content=DevTools&utm_campaign=Multimedia+Expansion+Board+II)
