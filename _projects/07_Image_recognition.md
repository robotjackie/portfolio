---
layout: project
title: Image Recognition and Classification App
date: February 20, 2015
image: image_recog1.jpg
---

## Overview
The original purpose of this project was to remotely stream camera feed to a mobile app, classify what objects were in the image, and print and ship the image to the user (with the Walgreens and PostMates APIs). 

The idea was an app that would allow users to "capture serendipitous moments in real time" and have a physical copy of that moment, printed and framed, delivered to them within an hour. A beautiful sunset, a child's first steps at home, the birth of an animal on a farm - the moments could all be captured remotely and delivered quickly to the user to physically keep using the APIs of modern companies.

## Implementation

I worked on this with Shayne Hemminger, Adi Dhingra, and Jon Tan for WildHacks 2015. However, we ran into many challenges during this brief period. 

We were not able to get the microcontroller + WiFi chip that we used, the Particle Photon, to work with the OV7670 camera (details below, but also see my [Arduino Camera Project](http://robotjackie.github.io/portfolio/projects/04_Arduino_cam/) writeup). We worked around this by using a Nest Camera API to retrieve its video stream to an Android mobile app, as well as using the Android phone's native camera to take a picture. 

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/photon_ide.jpg" width="700" alt="UI for the image comparison app"></center>

We then performed image classification by submitting an image to the Cloudsight API, which would then relay a text description of the object it had classified. Then our app performed some simple parsing and comparison to find which images in our "object database" matched the description (for our sake, we used only a collection of different colored "Beats" headphones to match to, but in reality this would be a large collection of images of all sorts of objects in the real world). We did not have time to implement the printing and shipping features unfortunately. 

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/image_recog1.jpg" width="600" alt="UI for the image comparison app">

UI for the image comparison app
</center>


<center><img src="https://github.com/robotjackie/portfolio/blob/gh-pages/public/images/Ben_Hangout.jpg?raw=true" width="450" alt="Example image fed to the app"></center>
Example image fed to the app

<center><img src="https://raw.githubusercontent.com/robotjackie/portfolio/gh-pages/public/images/image_recog3.jpg" width="600" alt="Output for closest image matching from image database"></center>
Output for closest image matching from image database

## Challenges

The Particle Photon that was connected to the OV7670 camera had a bug where it wouldn't reset its I2C pins back after being pulled down from initial register changes. We didn't know this but afterward realized that we needed pullup resistors for the SCL/SDA pins. I fixed this by manually touching 3V3 wires to the I2C pins when the Photon was on to force the pins up. It's possible that there are internal resistor settings for the Photon to set this in code.

We also ran into challenges with the mobile app, in printing a screenshot of the camera feed. It would force close when we did so and saved a blank picture. We manually fed our image recognition app by uploading images.


## Details
[GitHub repo](https://github.com/AwesomeShayne/CamerAzure/tree/dev).
