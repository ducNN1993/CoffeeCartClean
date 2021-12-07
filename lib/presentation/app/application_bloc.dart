import 'dart:async';
import 'package:coffeecarttest/presentation/base/index.dart';
import 'package:rxdart/subjects.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends BaseBloc<ApplicationEvent, ApplicationState> {

  PublishSubject<BaseEvent> _appEventManager = PublishSubject<BaseEvent>();
  Stream<BaseEvent> get appEventStream => _appEventManager.stream;



  @override
  Stream<ApplicationState> mapEventToState(BaseEvent event) async* {
    if (event is AppLaunched) {
    }


    if (event is LogoutSuccessEvent) {
      yield AppLaunchReadyState(tag: AppLaunchTag.login);
    }
    _appEventManager.add(event);
  }




  @override
  void dispose() {
    _appEventManager.close();
  }
}
