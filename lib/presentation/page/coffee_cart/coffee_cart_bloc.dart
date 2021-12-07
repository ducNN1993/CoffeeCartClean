import 'package:coffeecarttest/domain/usecase/get_detail_coffee_usecase.dart';
import 'package:coffeecarttest/presentation/base/index.dart';
import 'package:coffeecarttest/presentation/page/coffee_cart/index.dart';

class CoffeeCartBloc extends BaseBloc {
  GetDetailCoffeeUseCases _useCases;

  CoffeeCartBloc(this._useCases);

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is InitDetailCoffeeEvent) {
      yield* _mapOnInitDetailCoffeeEvent();
    }
  }

  @override
  void dispose() {}

  Stream<BaseState> _mapOnInitDetailCoffeeEvent() async* {
    yield LoadingState();
    final r = await _useCases.getDetailCoffee();
    yield* r.fold((l) async* {
      yield InitDetailCoffeeFailureState(messageError: l.message, code: l.code);
    }, (r) async* {
      yield InitDetailCoffeeSuccessState(r);
    });
  }
}
