import 'package:coffeecarttest/presentation/base/index.dart';
import 'package:flutter/foundation.dart';

abstract class ApplicationState extends BaseState {}

class AppLaunchLoadingState extends ApplicationState {}

class AppLaunchReadyState extends ApplicationState {
  AppLaunchTag tag;
  AppLaunchReadyState({required this.tag});
}

class AppAccessTokenExpiredState extends ApplicationState {}

class AppLaunchErrorState extends AppLaunchReadyState implements ErrorState {
  AppLaunchErrorState({
    this.code,
    this.messageError,
    required AppLaunchTag tag,
  }) : super(tag: tag);

  @override
  String? code;

  @override
  String? messageError;
}

class AppSettingChangedState extends ApplicationState {}

const APP_LAUNCH_ERROR_MESSAGE = "application cannot start";

enum AppLaunchTag { login, loginBySns, main, policy }
