---
layout: post
title: "PIR motion detect and send pushbullet push notification with esp8266 wifi"
modified:
categories:
excerpt: "PIR motion detect and send pushbullet push notification with esp8266 wifi"
tags: [pushbullet, push, notification, iot, esp8266, rest]
comments: true
---

#description
==============
With ESP8266 is approximately $5 to be able to create your own one IoT devices connected to the internet and send a message alerting you to the phone when a motion detect by PIR sensor.

In principle, when the device detects motion sensor PIR, it will send request to the pushbullet server with the information and your api key. All mobile devices that had installed pushbullet app will get this message almost immediately.

#demo
=======
![Pushbullet](/images/pushbullet/pushbullet.jpg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/-S1m-YRLOrU" frameborder="0" allowfullscreen></iframe>

#installations
1. Install pushbullet application [https://www.pushbullet.com/apps](https://www.pushbullet.com/apps)
2. Register an account at [https://pushbullet.com](https://pushbullet.com) and try to find your api key at the top left screen (your account infomation). Login your appp with this account.
3. Flash your ESP8266 with [esp_bridge] firmware (see: [https://github.com/tuanpmt/espduino])
4. Wiring arduino, pir sensor and esp8266 and flash espduino example for pushbullet. And remember to change your wifi ssid, password and replace your pushbullet api key. ```rest.setHeader("Authorization: Bearer <your_api_key>\r\n");```

![](/images/pushbullet/pushbullet_bb.png)

[Download fritzing](/images/pushbullet/pushbullet.fzz)

###Github Repository: [https://github.com/tuanpmt/espduino](https://github.com/tuanpmt/espduino)
