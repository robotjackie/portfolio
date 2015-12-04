---
layout: project
title: Wireless Charging Video Drone
date: February 20, 2015
image: wireless_charge.jpg
---

## Overview
This is a proof of concept of an automatically charging drone that could transmit video. The idea is that one day in the future, we could have a drone in our home or inside buildings that could transmit its video wirelessly, and upon finishing, could fly to its landing dock and charge automatically. 

Current drones generally need a USB wire cable to charge, which requires a human to be near it. But with inductive charging, humans could be anywhere in the world, and control the drone remotely. 

This proof of concept, of a rather simple principle that others have done before me, later grew into a startup that I recently incorporated in 2015. My startup is called Eighty Nine Robotics, LLC, and the mission is to put a drone in every home and in buildings around the world. 

Part of my journey is that upon graduating from undergrad at Northwestern, I saw many of my friends go into consulting or finance. But I knew that these jobs, while paying well for a 22 year old, weren't my passion. I wanted to start my own company and have the freedom to work hard for my own dreams, which lie in using technology for economic development and to improve the human condition. I was lucky enough to be accepted into the Masters in Robotics program with Todd Murphey and Jarvis Schultz, and went in with the goal of starting a robotics company. 

## General Approach

My friend Ritwik Ummalaneni and I put together an off-the-shelf drone controllable by PC with a remote camera transmitter and an inductive charging unit. We did this project using:

- the Bitcraze "Crazyflie" mini quadcopter
<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/crazyflie.jpg?raw=true"  width="400"></center>

- [http://www.fpvhobby.com/143-sub-nano-combo-set.html](1 gram camera + transmission module)
<center><img src="http://www.fpvhobby.com/img/p/143-353-large.jpg"></center>

- an inductive charger, and a charging coil stripped from a cheap phone that is compatible with the Palm charger
<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/palm_charger.jpg?raw=true" width="400"></center>

<pr>

## Challenges
The "sub-nano camera module" was quite small, and as you can imagine, soldering was difficult since the pins were so close to each other. In addition, we needed a TV receiver in order to display the image. As a follow-up, one could buy a USB dongle to get images onto the computer and do image processing on the video stream.

<img src="http://www.fpvhobby.com/img/p/143-354-thickbox.jpg"><img src="http://www.fpvhobby.com/img/p/143-380-thickbox.jpg">

Unfortunately, as we played with the drone, the charging chip on the inductive coils broke: 

<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/crazyflie_broken.jpg?raw=true" alt="Broken charging chip" width="400"></center>

One could solve this by buying the actual [http://www.seeedstudio.com/depot/Crazyflie-20-Qi-inductive-charging-expansion-board-p-2112.html](Crazyflie inductive charging coils expansion board), or just the [http://www.digikey.com/product-search/en/inductors-coils-chokes/wireless-charging-coils/197928?WT.srch=1](inductive charging coils) from a distributor.

The last challenge was that the Crazyflie couldn't fly while charging. This setting makes sense as usually the mini-drone charges via USB, and there is no reason for it to need to fly while connected with a USB cable. As a follow-up, one could modify the open-source code for the Crazyflie to change this option.


## Sources
(1) Tutorial: [https://www.bitcraze.io/2012/09/inductive-charging-hack/](https://www.bitcraze.io/2012/09/inductive-charging-hack/)
(2) Palm charger teardown tutorial: [https://www.ifixit.com/Teardown/Palm-Touchstone-Charger-Teardown/810/1](https://www.ifixit.com/Teardown/Palm-Touchstone-Charger-Teardown/810/1)
(3) Crazyflie code: [https://github.com/bitcraze/crazyflie-firmware](https://github.com/bitcraze/crazyflie-firmware)

