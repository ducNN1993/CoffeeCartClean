import 'package:coffeecarttest/core/network/network_status.dart';
import 'package:coffeecarttest/data/remote/api/index.dart';

import '../../../app_injector.dart';

abstract class BaseApi {
  NetworkStatus? networkStatus;
  ApiConfig? apiConfig;

  BaseApi({
    ApiConfig? config,
    NetworkStatus? status
  }) {
    this.networkStatus = status ?? injector.get<NetworkStatus>();
    this.apiConfig = config ?? injector.get<ApiConfig>();
  }
}
