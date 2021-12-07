

import 'package:coffeecarttest/domain/model/coffee_detail.dart';

abstract class CoffeeRepository {
  Future<CoffeeDetail> getCoffeeDetail();
}