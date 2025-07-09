abstract class ConnectRepository {
  Future<void> connectSoketi({
    required Function(String message) onMessage,
    required Function(String message) onSubscribed,
    required Function(String message) onConnect,
  });
}
