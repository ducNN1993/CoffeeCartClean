


import 'package:coffeecarttest/data/remote/base/index.dart';
import 'package:coffeecarttest/domain/model/coffee_detail.dart';
import 'package:coffeecarttest/domain/repository/coffee_repository.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  CoffeeApi _api;
  CoffeeRepositoryImpl(this._api);
  @override
  Future<CoffeeDetail> getCoffeeDetail() async{
    final r = await _api.getCoffeeDetail();
    return r;
  }

}
