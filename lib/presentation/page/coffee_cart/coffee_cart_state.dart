import 'package:coffeecarttest/domain/model/coffee_detail.dart';
import 'package:coffeecarttest/presentation/base/index.dart';

class InitDetailCoffeeSuccessState extends BaseState {
  CoffeeDetail r;
  InitDetailCoffeeSuccessState(this.r);
}

class InitDetailCoffeeFailureState implements ErrorState {
  @override
  String? code;

  @override
  String? messageError;

  InitDetailCoffeeFailureState({this.code, this.messageError});
}

