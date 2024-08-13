import 'package:injectable/injectable.dart';
import 'package:instagram_clone_application/common/common.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: ConnectionChecker)
class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnectionChecker internetConnectionChecker;

  ConnectionCheckerImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get hasConnection => internetConnectionChecker.hasConnection;
}
