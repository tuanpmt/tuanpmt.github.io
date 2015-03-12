---
layout: post
title: "RGB LED audio spectrum"
modified:
categories:
excerpt: "LED rgb audio fft spectrum analyzer"
tags: [LED, RGB, audio, REST, FFT, spectrum]
comments: true
---

###Github Repository: [https://github.com/tuanpmt/led-rgb-audio-spectrum](https://github.com/tuanpmt/led-rgb-audio-spectrum)
<iframe src="https://ghbtns.com/github-btn.html?user=tuanpmt&repo=led-rgb-audio-spectrum&type=fork&count=true&size=large" frameborder="0" scrolling="0" width="158px" height="30px"></iframe>
<br/>

This application using [FFT library](http://www.embeddedsignals.com/ARM.htm) for ARM cortex-M3 to analyze audio and display spectrum on RGB LED

#features:
- 16x32 RGB LED
- MCU: STM32F103C8T6

#demonstration:
Youtube: [https://youtu.be/YXznM0IRcUU](https://youtu.be/YXznM0IRcUU)
<iframe width="560" height="315" src="https://www.youtube.com/embed/YXznM0IRcUU" frameborder="0" allowfullscreen></iframe>

#installations
###Hardware Diagram: ```audio-spectrum-hardware\dv_spectrum_corel```
![](https://github.com/tuanpmt/led-rgb-audio-spectrum/raw/master/images/dv_spectrum.png)

- Row board: ```audio-spectrum-hardware\dv_spectrum_row```
![](ttps://github.com/tuanpmt/led-rgb-audio-spectrum/raw/master/images/row.png)

- Column board: ```audio-spectrum-hardware\dv_spectrum_col```
![](https://github.com/tuanpmt/led-rgb-audio-spectrum/raw/master/images/col.png)

- Main board: ```audio-spectrum-hardware\dv_spectrum_main```
![](https://github.com/tuanpmt/led-rgb-audio-spectrum/raw/master/images/controller.png)

###Firmware
```c
git clone --recursive https://github.com/tuanpmt/led-rgb-audio-spectrum.git
```

and open with Keil C


#links:
- [http://hackaday.io/project/4700-led-rgb-audio-spectrum](http://hackaday.io/project/4700-led-rgb-audio-spectrum)
