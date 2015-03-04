---
layout: post
title: "What is MQTT"
modified:
categories:
excerpt: "MQTT protocol"
tags: [mqtt, esp8266]
redirect_from:
    - /post/108428048879/
comments: true
---

![](http://mqtt.org/new/wp-content/uploads/2011/08/mqttorg-glow.png)


MQTT (Message Queuing Telemetry Transport) is a publish/subscribe messaging protocol for constrained Internet of Things devices and low-bandwidth, high-latency or unreliable networks.

Because MQTT specializes in low-bandwidth, high-latency environments, it is an ideal protocol for machine-to-machine (M2M) communication.

<!--more-->

So what is MQTT? To get a good overview simply search for “what is mqtt” or “mqtt slides”. In this article, we will briefly review the main definitions: “subscribe”, “publish”, "qos", "retain", "last will and testament" (lwt).

In an MQTT system, many nodes (called mqtt clients) connect to a mqtt server (called broker). Each client will typically register a few channels, eg "/client1/channel1", "/client1/channel2", this registration process is called **subscribe**. Each subscribing node will receive data when another client sends data to the subscribed channel. When a node sends data to a channel it is called **publish**.

- The three levels **QoS(Qualities of service)** are:

**QoS0** The broker/client will deliver the message once, with no confirmation (fire and forget).

**QoS1** The broker/client will deliver the message at least once, with confirmation required.

**QoS2** The broker/client will deliver the message exactly once by using a four-step handshake.

**Use cases QoS**: https://code.google.com/p/mqtt4erl/wiki/QualityOfServiceUseCases

Messages can be sent at any QoS level, and clients may attempt to subscribe to topics at any QoS level, which means that the client chooses the maximum QoS level they will receive. For example, if a message is published at QoS 2 and a client is subscribed with QoS 0, the message will be delivered to that client with QoS 0. If a second client is also subscribed to the same topic, but with QoS 2, then it will receive the same message but with QoS 2.

Another example could be if a client is subscribed with QoS 2 and a message is published on QoS 0, the client will receive it on QoS 0. Higher levels of QoS are more reliable, but involve higher latency and have higher bandwidth requirements.

- **Retain**:

If the RETAIN flag is set to 1, in a PUBLISH Packet sent by a Client to a Server, the Server MUST store the Application Message and its QoS, so that it can be delivered to future subscribers whose subscriptions match its topic name. When a new subscription is established, the last retained message, if any, on each matching topic name MUST be sent to the subscriber. If the Server receives a QoS 0 message with the RETAIN flag set to 1 it MUST discard any message previously retained for that topic. It SHOULD store the new QoS 0 message as the new retained message for that topic, but MAY choose to discard it at any time - if this happens there will be no retained message for that topic.

When sending a PUBLISH Packet to a Client the Server MUST set the RETAIN flag to 1 if a message is sent as a result of a new subscription being made by a Client . It MUST set the RETAIN flag to 0 when a PUBLISH Packet is sent to a Client because it matches an established subscription regardless of how the flag was set in the message it received.

A PUBLISH Packet with a RETAIN flag set to 1 and a payload containing zero bytes will be processed as normal by the Server and sent to Clients with a subscription matching the topic name. Additionally any existing retained message with the same topic name MUST be removed and any future subscribers for the topic will not receive a retained message . “As normal” means that the RETAIN flag is not set in the message received by existing Clients. A zero byte retained message MUST NOT be stored as a retained message on the Server.

If the RETAIN flag is 0, in a PUBLISH Packet sent by a Client to a Server, the Server MUST NOT store the message and MUST NOT remove or replace any existing retained message

- **LWT**:

LWT messages are not really concerned about detecting whether a client has gone offline or not (that task is handled by keepAlive messages). LWT messages are about what happens after the client has gone offline. 

**_A fictitious example:_**

I have a sensor, which sends crucial data, but very infrequently. It has formulated a last will statement in the form of [topic: '/node/gone-offline', message: ':id'], with :id being a unique id for the sensor. I also have a emergency-subscriber for the topic 'node/gone-offline', which will send a SMS to my phone every time a message is published on that channel.

During normal operation, the sensor will keep the connection to the MQTT-broker open by sending periodic keepAlive messages interspersed with the actual sensor readings. If the sensor goes offline, the connection to the broker will time out, due to the lack of keepAlives.

This is where LWT comes in: If no LWT is specified, the broker doesn't care and just closes the connection. In our case however, the broker will execute the sensor's last will and publish the LWT-message '/node/gone-offline: :id'. The message will then be consumed to my emergency-subscriber and I will be notified of the sensor's ID via SMS so that I can check up on what's going on.

**_In short:_**

Instead of just closing the connection after a client has gone offline, LWT messages can be leveraged to define a message to be published by the broker on behalf of the client, since the client is offline and cannot publish anymore.

# **How to use it with ESP8266?**
**UPDATING**

- Reference: 

http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html

http://bb-smartsensing.com/basics-of-mqtt/

http://stackoverflow.com/questions/17270863/mqtt-what-is-the-purpose-or-usage-of-last-will-testament



