import 'package:bloc/bloc.dart';

import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(IdlState());

  void dispose();

  void dispatchEvent(BaseEvent event) {
    print('dispatchEvent event $event');
    super.add(event);
  }
}
