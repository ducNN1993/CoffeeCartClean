
import 'package:coffeecarttest/presentation/base/index.dart';

abstract class ApplicationEvent extends BaseEvent {}

class LoadingEvent extends ApplicationEvent {}

class AppLaunched extends ApplicationEvent {}

