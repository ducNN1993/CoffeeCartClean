import 'package:coffeecarttest/domain/model/coffee_detail.dart';



abstract class CoffeeApi {
  Future<CoffeeDetail> getCoffeeDetail();

}
