---
layout: project
title: Wireless Charging Video Drone Prototype
date: February 20, 2015
image: wireless_charge.jpg
---

## Overview
This is a proof of concept of an automatically charging drone that can transmit video. The idea is that one day in the future, we could have a drone in our home or inside buildings that could transmit its video wirelessly, and upon finishing whatever viewing task the user had, could fly to its landing dock and charge automatically. It could be used for home security monitoring, indoor power plant inspection, first responders in fires and hostile incidents, and more.

Current drones generally need a USB wire cable to charge, which requires a human to be connect it. But with inductive charging, humans could be anywhere in the world, and control the drone remotely, if the drone could fly itself back to the charging dock. 

This proof of concept, of a rather simple principle that others have done before me, grew into a startup that I recently incorporated in 2015. My company is called [Eighty Nine Robotics, LLC](www.eightyninerobotics.com), and the mission is to put a drone in every home and in buildings around the world. 


## General Approach

In order to get this to work, we wanted to do the minimum necessary to prove a concept, and not reinvent the wheel from scratch. My friend [Ritwik Ummalaneni](www.ritwiku.com) and I combined an off-the-shelf drone, controllable by PC, with a remote camera transmitter and an inductive charging unit. 


We did this project using the following equipment:

- the Bitcraze "Crazyflie" mini quadcopter

<img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/crazyflie.JPG?raw=true" width="400">

<br/>

- Camera and transmitter: [1 gram camera + transmission module](http://www.fpvhobby.com/143-sub-nano-combo-set.html)

This was sold as the lightest camera + transmitter combo in the world by Chinese manufacturers, with an odd camera resolution (something like PAL 720x576).

<img src="http://www.fpvhobby.com/img/p/143-353-large.jpg" width="300">

<br/>

- an inductive charger, and a charging coil stripped from a cheap phone that is compatible with the Palm charger

<img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/palm_charger.jpg?raw=true" width="300">


## Challenges
We ran into a few difficulties in the project, but generally were able to get things to work. The "sub-nano camera module" was quite small, and as you can imagine, soldering was a bit difficult since the pins were so close to each other. 

The two components connect with 3 wires, GND, 3V3, and the video data wire. The GND and 3V3 cables could then be connected to another power source such as pins on an Arduino. An antenna could also be added, and the whole thing could be heat-shrinked with a plastic wrap that came with the shipment (we didn't bother).

<br/>

<center><img src="http://www.fpvhobby.com/img/p/143-354-thickbox.jpg" width="250"><img src="http://www.fpvhobby.com/img/p/143-380-thickbox.jpg" width="250"></center>

<br/>

In addition, we needed a TV antenna receiver in order to display the image. As a follow-up, one could buy a USB dongle to receive and transfer the images onto the computer in order to do image processing on the video stream.

The inductive charger has some sort of microcontroller presumably to regulate charging. Unfortunately, near the end of our project, the charging chip on the inductive coils broke: 

<br/>

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/crazyflie_broken.jpg?raw=true" alt="Broken charging chip" width="400"></center>

<br/>

One could solve this by buying the official [Crazyflie inductive charging coils expansion board](http://www.seeedstudio.com/depot/Crazyflie-20-Qi-inductive-charging-expansion-board-p-2112.html), or just the [inductive charging coils](http://www.digikey.com/product-search/en/inductors-coils-chokes/wireless-charging-coils/197928?WT.srch=1) from a distributor and creating one's own PCB to address charging.

The last challenge was that the Crazyflie couldn't fly while charging. This is a setting in the code that makes sense, as usually the mini-drone charges via USB, and there is no reason for it to need to fly while connected with a USB cable. As a follow-up, one could modify the open-source code for the Crazyflie to change this option so that the drone can take off directly from the charging pad.


## Sources
(1) Tutorial: [https://www.bitcraze.io/2012/09/inductive-charging-hack/](https://www.bitcraze.io/2012/09/inductive-charging-hack/)

(2) Palm charger teardown tutorial: [https://www.ifixit.com/Teardown/Palm-Touchstone-Charger-Teardown/810/1](https://www.ifixit.com/Teardown/Palm-Touchstone-Charger-Teardown/810/1)

(3) Crazyflie firmware code: [https://github.com/bitcraze/crazyflie-firmware](https://github.com/bitcraze/crazyflie-firmware)

