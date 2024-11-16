import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetConnectionChecker {
  Future<bool>  getInternetConnection();
}

class InternetConnectionCheckerImpl implements InternetConnectionChecker {
  final InternetConnection internetConnection;

  InternetConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> getInternetConnection()async {
    return await internetConnection.hasInternetAccess;
  }
}
