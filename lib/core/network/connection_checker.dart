import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl({required this.internetConnection});
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected async=> await internetConnection.hasInternetAccess;
}
