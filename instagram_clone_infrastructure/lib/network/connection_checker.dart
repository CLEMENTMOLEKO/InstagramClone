import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionChecker {
  final InternetConnectionChecker internetConnectionChecker;

  ConnectionChecker({required this.internetConnectionChecker});

  Future<bool> get hasConnection => internetConnectionChecker.hasConnection;
}
