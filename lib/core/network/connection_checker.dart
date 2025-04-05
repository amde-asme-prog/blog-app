import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  ConnectionCheckerImpl(this.internetConnection);
  final InternetConnection internetConnection;

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
