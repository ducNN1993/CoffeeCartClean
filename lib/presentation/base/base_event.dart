import 'package:coffeecarttest/presentation/utils/index.dart';
import 'package:flutter/material.dart';

abstract class BaseEvent {}

class PageInitStateEvent extends BaseEvent {
  BuildContext? context;
  PageInitStateEvent({
    this.context,
  });
}

class PageDidChangeDependenciesEvent extends BaseEvent {
  BuildContext? context;
  PageDidChangeDependenciesEvent({this.context});
}

class PageBuildEvent extends BaseEvent {
  BuildContext? context;
  PageBuildEvent({this.context});
}

class PageDidAppearEvent extends BaseEvent {
  BuildContext? context;
  PageTag tag;
  PageDidAppearEvent({this.context, required this.tag});
}

class PageDidDisappearEvent extends BaseEvent {
  BuildContext? context;
  PageTag tag;
  PageDidDisappearEvent({@required this.context, required this.tag});
}

class AppEnterBackground extends BaseEvent {
  BuildContext? context;
  PageTag tag;
  AppEnterBackground({this.context, required this.tag});
}

class AppGainForeground extends BaseEvent {
  BuildContext? context;
  PageTag tag;
  AppGainForeground({this.context, required this.tag});
}

class OnResultEvent extends BaseEvent {
  dynamic result;
  OnResultEvent({this.result});
}

class ApplicationInactiveEvent extends BaseEvent {}

class ApplicationResumeEvent extends BaseEvent {}

class LoadMoreEvent extends BaseEvent {}

class LogoutSuccessEvent extends BaseEvent {}

class NewNotificationEvent extends BaseEvent {}
