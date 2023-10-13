import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:osm_v2/app/core/constants/mqtt_channels.dart';
import 'package:osm_v2/app/data/services/app_services.dart';

class MQTTService extends GetxService {
  final AppServices appServices = Get.find<AppServices>();

  @override
  void onInit() {
    mqttClientInit();
    super.onInit();
  }

  /// First create a client, the client is constructed with a broker name, client identifier
  /// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
  /// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
  /// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
  /// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
  /// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
  /// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
  /// of 1883 is used.
  /// If you want to use websockets rather than TCP see below.

// 195.179.193.132 = owmmeter.com/index.php, empty arg is for port (default = 1883)
  final mqttClient = MqttServerClient('195.179.193.132', '');

  Future<void> mqttClientInit() async {
    /// Set the correct MQTT protocol for mosquito
    mqttClient.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    mqttClient.keepAlivePeriod = 20;

    /// The connection timeout period can be set if needed, the default is 5 seconds.
    mqttClient.connectTimeoutPeriod = 2000; // milliseconds

    /// Add the unsolicited disconnection callback
    mqttClient.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    mqttClient.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    mqttClient.onSubscribed = onSubscribed;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await mqttClient.connect();
    } on NoConnectionException catch (e) {
      // Raised by the mqttClient when connection fails.
      debugPrint('EXAMPLE::mqttClient exception - $e');
      mqttClient.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      debugPrint('EXAMPLE::socket exception - $e');
      mqttClient.disconnect();
    }

    /// Check we are connected
    if (mqttClient.connectionStatus!.state == MqttConnectionState.connected) {
      debugPrint('EXAMPLE::Mosquitto mqttClient connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      debugPrint('EXAMPLE::ERROR Mosquitto mqttClient connection failed - disconnecting, status is ${mqttClient.connectionStatus}');
      mqttClient.disconnect();
    }
  }

  Map<String, dynamic> recivedDecodedMsgFromMqtt = {};

  Future<void> mqttSubscribeAndListen(String topic) async {
    debugPrint('EXAMPLE::Subscribing to the $topic topic');
    mqttClient.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    mqttClient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? receievedMsgPayload) {
      final recievedMess = receievedMsgPayload![0].payload as MqttPublishMessage;
      final publishedPayloadMsg = MqttPublishPayload.bytesToStringAsString(recievedMess.payload.message);

      // debugPrint('EXAMPLE::Change notification:: topic is <${receievedMsgPayload[0].topic}>, payload is <-- $publishedPayloadMsg -->');
      recivedDecodedMsgFromMqtt[receievedMsgPayload[0].topic] = json.decode(publishedPayloadMsg);
      // debugPrint('${recivedDecodedMsgFromMqtt[MqttChannels.readingsMQTTChannel]}');
      if (receievedMsgPayload[0].topic == MqttChannels.readingsMQTTChannel) {
        List reversedReading = List.from(recivedDecodedMsgFromMqtt[receievedMsgPayload[0].topic]['reading_history'].reversed);
        appServices.litersSeries.add(reversedReading[0]['liters_consumed']);
        appServices.litersDays.add(reversedReading[0]['created_at']);
        appServices.flowSeries.add(reversedReading[0]['flow_rate']);
        appServices.flowDays.add(reversedReading[0]['created_at']);
      } else if (receievedMsgPayload[0].topic == MqttChannels.flowStatusMQTTChannel) {
        //todo implement when the new msg response is clear
        // print(recivedDecodedMsgFromMqtt[MqttChannels.flowStatusMQTTChannel]);
        // print(recivedDecodedMsgFromMqtt);
        appServices.flowStatus[recivedDecodedMsgFromMqtt[MqttChannels.flowStatusMQTTChannel]['token']] = recivedDecodedMsgFromMqtt[MqttChannels.flowStatusMQTTChannel]['flow_status'];
      } else if (receievedMsgPayload[0].topic == MqttChannels.valveStatusMQTTChannel) {
        //todo add change valve-status
      }
    });
  }

  Future<void> mqttPublishMsg(String topic, Map data) async {
    /// Lets publish to our topic
    /// Use the payload builder rather than a raw buffer
    /// Our known topic to publish to
    final builder = MqttClientPayloadBuilder();
    final String jsonString = jsonEncode(data);
    builder.addString(jsonString);

    /// Subscribe to it
    debugPrint('EXAMPLE::Subscribing to the $topic topic');
    mqttClient.subscribe(topic, MqttQos.exactlyOnce);

    /// Publish it
    debugPrint('EXAMPLE::Publishing our topic');
    mqttClient.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.
    // debugPrint('EXAMPLE::Sleeping....');
    // await MqttUtilities.asyncSleep(60);

    // unSubscribeFromMqtt(topic);
  }

  Future<void> unSubscribeFromMqtt(String topic) async {
    /// Finally, unsubscribe and exit gracefully
    debugPrint('EXAMPLE::Unsubscribing');
    mqttClient.unsubscribe(topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    await MqttUtilities.asyncSleep(2);
    debugPrint('EXAMPLE::Disconnecting');
    mqttClient.disconnect();
    debugPrint('EXAMPLE::Exiting normally');
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    debugPrint('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    debugPrint('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (mqttClient.connectionStatus!.disconnectionOrigin == MqttDisconnectionOrigin.solicited) {
      debugPrint('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    } else {
      debugPrint('EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
    }
  }

  /// The successful connect callback
  void onConnected() {
    debugPrint('EXAMPLE::OnConnected client callback - Client connection was successful');
  }
}
