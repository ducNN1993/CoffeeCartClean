

const BASE_URL =
    'https://www.google.com.vn';

abstract class ApiConfig {
  late String baseUrl;
  late int connectTimeout;
  late int receiveTimeout;
  late String appName;
}

class ApiConfigImpl extends ApiConfig {
  ApiConfigImpl();

  String get baseUrl => BASE_URL;

  int connectTimeout = 50000;
  int receiveTimeout = 30000;
  String appName = "app-client";
}
