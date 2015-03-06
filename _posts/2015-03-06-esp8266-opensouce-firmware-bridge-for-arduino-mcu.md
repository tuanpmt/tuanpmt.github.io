---
layout: post
title: "esp8266 opensouce firmware bridge for Arduino and MCU"
modified:
categories:
redirect_from:
    - /post/esp_bridge/
excerpt: "esp8266 opensouce firmware bridge for Arduino and MCU"
tags: [mqtt, esp8266, restful, REST, arduino, mbed, MCU]
comments: true
---

esp_bridge
========
###Github Repository: [https://github.com/tuanpmt/esp_bridge](https://github.com/tuanpmt/esp_bridge)
<iframe src="https://ghbtns.com/github-btn.html?user=tuanpmt&repo=esp_bridge&type=fork&count=true&size=large" frameborder="0" scrolling="0" width="158px" height="30px"></iframe>
<br/>
This is source code for esp8266 support bridge for arduino or any MCU using SLIP protocol via Serial port. 
###Library for arduino: [https://github.com/tuanpmt/espduino](https://github.com/tuanpmt/espduino)

If you want using only ESP8266, you can find the **Native MQTT client** library for ESP8266 work well here: 
[https://github.com/tuanpmt/esp_mqtt](https://github.com/tuanpmt/esp_mqtt)

Warning
==============
This project **only execute commands from other MCU** via Serial port (like arduino).

Features
========
- Rock Solid wifi network client for Arduino (of course need to test more and resolve more issues :v)
- **More reliable** than AT COMMAND library (Personal comments)
- **Firmware applications written on ESP8266 can be read out completely. For security applications, sometimes you should use it as a Wifi client (network client) and other MCU with Readout protection.**
- MQTT module: 
    + MQTT client run stable as Native MQTT client (esp_mqtt)
    + Support subscribing, publishing, authentication, will messages, keep alive pings and all 3 QoS levels (it should be a fully functional client).
    + **Support multiple connection (to multiple hosts).**
    + Support SSL
    + Easy to setup and use
- REST module:
    + Support method GET, POST, PUT, DELETE
    + setContent type, set header, set User Agent
    + Easy to used API
    + Support SSL
- WIFI module:


Installations
========

You can found here for instructions: [https://github.com/tuanpmt/espduino](https://github.com/tuanpmt/espduino)

Compile
=======

```bash
git clone --recursive https://github.com/tuanpmt/esp_bridge
cd esp_bridge
make all
```




