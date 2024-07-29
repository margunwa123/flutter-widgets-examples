import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttApp extends StatelessWidget {
  const MqttApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MqttMessageDisplay(),
    );
  }
}

class MqttMessageDisplay extends StatefulWidget {
  const MqttMessageDisplay({Key? key}) : super(key: key);

  @override
  _MqttMessageDisplayState createState() => _MqttMessageDisplayState();
}

class _MqttMessageDisplayState extends State<MqttMessageDisplay> {
  final String broker = 'broker.hivemq.com';
  final String topic = '/nodejs/mqtt';
  final client = MqttServerClient('broker.hivemq.com', '');
  String message = 'No message received yet.';

  @override
  void initState() {
    super.initState();
    _connectToMqtt();
  }

  Future<void> _connectToMqtt() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean();
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');
      _subscribeToTopic();
    } else {
      print(
          'MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
  }

  void _subscribeToTopic() {
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String newMessage =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        message = newMessage;
      });
    });
  }

  void _onConnected() {
    print('Connected');
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Received message: $message',
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
