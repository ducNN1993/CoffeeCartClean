import 'package:connectivity/connectivity.dart';

/// check mobile data, wifi has enable

abstract class ConnectivityStatus {
  Future<ConnectivityResult> get connectivityResult;
}

class ConnectivityStatusImpl implements ConnectivityStatus {
  Connectivity connectivity;

  ConnectivityStatusImpl(this.connectivity);

  @override
  Future<ConnectivityResult> get connectivityResult async =>
      await connectivity.checkConnectivity();
}