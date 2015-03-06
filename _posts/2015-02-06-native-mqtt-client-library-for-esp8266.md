---
layout: post
title: "Native MQTT client library for ESP8266"
modified:
categories:
excerpt: "Native MQTT client library for ESP8266"
tags: [iot, esp8266, mqtt]
redirect_from:
    - /post/108150292789/
    - /post/108150292789/native-mqtt-client-library-for-esp8266/
    - /post/esp_mqtt/
comments: true
---
###Github Repository: [https://github.com/tuanpmt/esp_mqtt](https://github.com/tuanpmt/esp_mqtt)
<iframe src="https://ghbtns.com/github-btn.html?user=tuanpmt&repo=esp_mqtt&type=fork&count=true&size=large" frameborder="0" scrolling="0" width="158px" height="30px"></iframe>
<br/>
**ESP8266** is a solution for internet connection via wifi with great price, and it will become more common for IOT applications where system libraries serve these applications become more complete and stable.


This is MQTT client library for ESP8266, port from: [MQTT client library for Contiki](https://github.com/esar/contiki-mqtt) (thanks)
<br/>
For Arduino user, please see here: ***[espduino](https://github.com/tuanpmt/espduino)***

**Features:**

 * Support subscribing, publishing, authentication, will messages, keep alive pings and all 3 QoS levels (it should be a fully functional client).
 * Support multiple connection (to multiple hosts).
 * Support SSL connection (max 1024 bit key size)
 * Easy to setup and use

**Compile:**

Make sure to add PYTHON PATH and compile PATH to Eclipse environment variable if using Eclipse

for Windows:

```bash
git clone https://github.com/tuanpmt/esp_mqtt
cd esp_mqtt
#clean
mingw32-make clean
#make
mingw32-make SDK_BASE="c:/Espressif/ESP8266_SDK" FLAVOR="release" all
#flash
mingw32-make ESPPORT="COM1" flash
```

for Mac or Linux:

```bash
git clone https://github.com/tuanpmt/esp_mqtt
cd esp_mqtt
#clean
make clean
#make
make SDK_BASE="/opt/Espressif/ESP8266_SDK" FLAVOR="release" all
#flash
make ESPPORT="/dev/ttyUSB0" flash
```

**Usage:**

```c
#include "ets_sys.h"
#include "driver/uart.h"
#include "osapi.h"
#include "mqtt.h"
#include "wifi.h"
#include "config.h"
#include "debug.h"
#include "gpio.h"
#include "user_interface.h"
#include "mem.h"

MQTT_Client mqttClient;

void wifiConnectCb(uint8_t status)
{
  if(status == STATION_GOT_IP){
    MQTT_Connect(&mqttClient);
  } else {
    MQTT_Disconnect(&mqttClient);
  }
}
void mqttConnectedCb(uint32_t *args)
{
  MQTT_Client* client = (MQTT_Client*)args;
  INFO("MQTT: Connected\r\n");
  MQTT_Subscribe(client, "/mqtt/topic/0", 0);
  MQTT_Subscribe(client, "/mqtt/topic/1", 1);
  MQTT_Subscribe(client, "/mqtt/topic/2", 2);

  MQTT_Publish(client, "/mqtt/topic/0", "hello0", 6, 0, 0);
  MQTT_Publish(client, "/mqtt/topic/1", "hello1", 6, 1, 0);
  MQTT_Publish(client, "/mqtt/topic/2", "hello2", 6, 2, 0);

}

void mqttDisconnectedCb(uint32_t *args)
{
  MQTT_Client* client = (MQTT_Client*)args;
  INFO("MQTT: Disconnected\r\n");
}

void mqttPublishedCb(uint32_t *args)
{
  MQTT_Client* client = (MQTT_Client*)args;
  INFO("MQTT: Published\r\n");
}

void mqttDataCb(uint32_t *args, const char* topic, uint32_t topic_len, const char *data, uint32_t data_len)
{
  char *topicBuf = (char*)os_zalloc(topic_len+1),
      *dataBuf = (char*)os_zalloc(data_len+1);

  MQTT_Client* client = (MQTT_Client*)args;

  os_memcpy(topicBuf, topic, topic_len);
  topicBuf[topic_len] = 0;

  os_memcpy(dataBuf, data, data_len);
  dataBuf[data_len] = 0;

  INFO("Receive topic: %s, data: %s \r\n", topicBuf, dataBuf);
  os_free(topicBuf);
  os_free(dataBuf);
}


void user_init(void)
{
  uart_init(BIT_RATE_115200, BIT_RATE_115200);
  os_delay_us(1000000);

  CFG_Load();

  MQTT_InitConnection(&mqttClient, sysCfg.mqtt_host, sysCfg.mqtt_port, sysCfg.security);
  //MQTT_InitConnection(&mqttClient, "192.168.11.122", 1880, 0);

  MQTT_InitClient(&mqttClient, sysCfg.device_id, sysCfg.mqtt_user, sysCfg.mqtt_pass, sysCfg.mqtt_keepalive, 1);
  //MQTT_InitClient(&mqttClient, "client_id", "user", "pass", 120, 1);

  MQTT_InitLWT(&mqttClient, "/lwt", "offline", 0, 0);
  MQTT_OnConnected(&mqttClient, mqttConnectedCb);
  MQTT_OnDisconnected(&mqttClient, mqttDisconnectedCb);
  MQTT_OnPublished(&mqttClient, mqttPublishedCb);
  MQTT_OnData(&mqttClient, mqttDataCb);

  WIFI_Connect(sysCfg.sta_ssid, sysCfg.sta_pwd, wifiConnectCb);

  INFO("\r\nSystem started ...\r\n");
}

```

**Publish message and Subscribe**

```c
/* TRUE if success */
BOOL MQTT_Subscribe(MQTT_Client *client, char* topic, uint8_t qos);

BOOL MQTT_Publish(MQTT_Client *client, const char* topic, const char* data, int data_length, int qos, int retain);

```

**Already support LWT: (Last Will and Testament)**

```c

/* Broker will publish a message with qos = 0, retain = 0, data = "offline" to topic "/lwt" if client don't send keepalive packet */
MQTT_InitLWT(&mqttClient, "/lwt", "offline", 0, 0);

```

#Default configuration

See: **include/user_config.h**

If you want to load new default configurations, just change the value of CFG_HOLDER in **include/user_config.h**

**Define protocol name in include/user_config.h**

```c
#define PROTOCOL_NAMEv31  /*MQTT version 3.1 compatible with Mosquitto v0.15*/
//PROTOCOL_NAMEv311     /*MQTT version 3.11 compatible with https://eclipse.org/paho/clients/testing/*/
```

In the Makefile, it will erase section hold the user configuration at 0x3C000

```bash
flash: firmware/0x00000.bin firmware/0x40000.bin
  $(PYTHON) $(ESPTOOL) -p $(ESPPORT) write_flash 0x00000 firmware/0x00000.bin 0x3C000 $(BLANKER) 0x40000 firmware/0x40000.bin 
```
The BLANKER is the blank.bin file you find in your SDKs bin folder.

**Create SSL Self sign**

```
openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days XXX
```

**SSL Mqtt broker for test**

```javascript
var mosca = require('mosca')
var SECURE_KEY = __dirname + '/key.pem';
var SECURE_CERT = __dirname + '/cert.pem';
var ascoltatore = {
  //using ascoltatore
  type: 'mongo',
  url: 'mongodb://localhost:27017/mqtt',
  pubsubCollection: 'ascoltatori',
  mongo: {}
};

var moscaSettings = {
  port: 1880,
  stats: false,
  backend: ascoltatore,
  persistence: {
    factory: mosca.persistence.Mongo,
    url: 'mongodb://localhost:27017/mqtt'
  },
  secure : {
    keyPath: SECURE_KEY,
    certPath: SECURE_CERT,
    port: 1883
  }
};

var server = new mosca.Server(moscaSettings);
server.on('ready', setup);

server.on('clientConnected', function(client) {
    console.log('client connected', client.id);
});

// fired when a message is received
server.on('published', function(packet, client) {
  console.log('Published', packet.payload);
});

// fired when the mqtt server is ready
function setup() {
  console.log('Mosca server is up and running')
}
```

###Example projects using esp_mqtt:

- [https://github.com/eadf/esp_mqtt_lcd](https://github.com/eadf/esp_mqtt_lcd)

###Limited:
- Not fully supported retransmit for QoS1 and QoS2

###Status:
- Release

### Reference:
- [MQTT Broker for test](https://github.com/mcollina/mosca)
- [MQTT Client for test](https://chrome.google.com/webstore/detail/mqttlens/hemojaaeigabkbcookmlgmdigohjobjm?hl=en)
