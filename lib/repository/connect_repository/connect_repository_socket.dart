import 'dart:async';
import 'package:chattrix_app/repository/connect_repository/base_connect.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';

class SoketiConnect implements ConnectRepository {
  @override
  Future<void> connectSoketi({
    required Function(String message) onMessage,
    required Function(String message) onSubscribed,
    required Function(String message) onConnect,
  }) async {
    try {
      final client = PusherChannelsClient.websocket(
        options: PusherChannelsOptions.fromHost(
          scheme: 'wss',
          host: 'soketi.asepnasihin.com',
          key: 'my-app-key',
          port: 443,
        ),
        connectionErrorHandler: (exception, trace, refresh) {
          if (exception != null) {
          } else if (trace.hashCode == 200) {
          } else {
            refresh();
          }
        },
      );

      client.onConnectionEstablished.listen((event) {
        onConnect("Berhasil connect ke dalam soketi");
        final channel = client.privateChannel(
          'private-chat.0030c23a-3564-4160-898a-4f30b3533e34',
          authorizationDelegate:
              EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
                authorizationEndpoint: Uri.parse(
                  'https://test.asepnasihin.com/api/broadcasting/auth',
                ),
                headers: {
                  'Authorization':
                      'Bearer 1|RfRCucHOqKqrtyGaLevZ6RhXKpPGr7JGmKfpk3lA',
                  'Content-Type': 'application/json',
                },
              ),
        );
        channel.subscribe();
        channel.whenSubscriptionSucceeded().listen((event) {
          onSubscribed("berhasil subscribe ke ${event.channelName}");
          channel.bind("message.sent").listen((event) {
            onMessage(event.data);
          });
        });
      });

      await client.connect();

      // Future.delayed(Duration(seconds: 1));
      // connectionSubs.cancel();
    } catch (e) {
      print("error in this line ${e.toString()}");
    }
  }
}
