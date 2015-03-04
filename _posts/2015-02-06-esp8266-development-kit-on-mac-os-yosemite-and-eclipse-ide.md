---
layout: post
title: "ESP8266 Development Kit on Mac Os Yosemite and Eclipse IDE"
modified:
categories: esp8266
excerpt: "ESP8266 Development Kit on Mac Os Yosemite and Eclipse IDE"
tags: [iot, esp8266, mqtt]
redirect_from:
    - /post/109019196894/
    - /post/109019196894/esp8266-development-kit-on-mac-os-yosemite-and/
comments: true
---


After successful installation of development tools on [Windows with Eclipse IDE](http://www.esp8266.com/viewtopic.php?f=9&t=820) for ESP8266 and have pretty interesting time with the MQTT project (*[esp_mqtt](https://github.com/tuanpmt/esp_mqtt)*), I tried looking for someone who develop ESP8266 applications for Mac, discovered a lot of people do this, but there is no specific guidance. So I was tinkering, and record the steps in a specific way for those who are in need.

[![](http://i.imgur.com/lqeRIZW.png?1)](http://i.imgur.com/lqeRIZW.png?1)

<!--more-->

First, prepare the necessary tools<br/>
Download and install [macports](https://www.macports.org/install.php), then:

	sudo port install git gsed gawk binutils gperf grep gettext py-serial wget libtool autoconf automake
<br/>

Create a case-sensitive filesystem image and mount it somewhere before cloning and compile esp-sdk

```bash
hdiutil create -size 5g -fs "Case-sensitive HFS+" -volname ESPTools ESPTools.sparsebundle
hdiutil attach ESPTools.sparsebundle
sudo ln -s /Volumes/ESPTools/ /esptools
cd /esptools
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive
cd esp-open-sdk
sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile
sed -i.bak -e 's/[[:<:]]sed[[:>:]]/gsed/' Makefile
sed -i.bak -e 's/[[:<:]]awk[[:>:]]/\$(AWK)/' lx106-hal/src/Makefile.am
sed -i.bak 's/AM_PROG_AS/AM_PROG_AS\'$'\nAM_PROG_AR/' lx106-hal/configure.ac
make STANDALONE=n
```

Then:

```bash
nano $HOME/.bash_profile
```

add this line and save:

```bash
export PATH=$PATH:/esptools/esp-open-sdk/xtensa-lx106-elf/bin
```

after that:

```bash
source $HOME/.bash_profile
```

You need a tool to creation and handling of firmware files suitable for the ESP8266 chip. I am clone here: https://github.com/tommie/esptool-ck but it was an error exists on the Mac, not compiled, the pull request to resolve the error had not been interested. And I have to fork, edit, to be compile

```bash
git clone https://github.com/tuanpmt/esptool-ck.git
cd esptool-ck
make
chmod +x esptool
```

At this point, you should be able to compile it, but how to check. Just:<br/>

```bash
cd /esptools
git clone https://github.com/tuanpmt/esp_mqtt
cd esp_mqtt
make -f Makefile.mac
```

Compile NodeMcu

```bash
git clone https://github.com/nodemcu/nodemcu-firmware
make
```

Next we will install Eclipse IDE, and configure it.

Download Install java 7: http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html

Download Eclipse for Mac OS: https://www.eclipse.org/downloads/?osType=macosx

Install PySerial: http://sourceforge.net/projects/pyserial/

	tar xfvz pyserial-2.7.tar.gz
	cd pyserial-2.7
	sudo python setup.py install

**Eclipse->File->New->Makefile project exist with code**

[![](http://i.imgur.com/HVRWsor.png)](http://i.imgur.com/HVRWsor.png)

**Project properties->Build command: make -f Makefile.mac**
[![](http://i.imgur.com/Gql8O3x.png)](http://i.imgur.com/Gql8O3x.png)

**Add Make Target all, clean, flash**


[![](http://i.imgur.com/VFOvWzd.png)](http://i.imgur.com/VFOvWzd.png)

**Reference:**

https://github.com/pfalcon/esp-open-sdk/issues/11