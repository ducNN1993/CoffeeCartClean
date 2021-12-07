import 'dart:convert';

import 'package:coffeecarttest/core/error/exceptions.dart';
import 'package:coffeecarttest/domain/model/coffee_detail.dart';

import '../base/interface_api.dart';

class CoffeeApiImpl extends CoffeeApi {
  @override
  Future<CoffeeDetail> getCoffeeDetail() async {
    await Future.delayed(Duration(seconds: 3));
    final testData =
        '{"id": 14557,"name": "Flat White","price": 125,"before_sale_price": null,"description": "Freshly-ground beans and steamed milk","full_description": "Freshly-ground beans and steamed milk","order": 1,"category": {"id": 1727,"name": "Coffee"},"images": {"full_size": "https://res.cloudinary.com/ginja-co-ltd/image/upload/s--zHcUzne6--/c_fill,h_300,q_jpegmini,w_485/v1/vendors/the-coffee-club-205/products/flat-white-mug-14557","thumbnail": "https://res.cloudinary.com/ginja-co-ltd/image/upload/s--sVm4XF-z--/c_fill,h_70,q_jpegmini,w_103/v1/vendors/the-coffee-club-205/products/flat-white-mug-14557"},"extras": [{"id": 1535,"name": "Milk Option","min": "1","max": "1"}],"extra_items": [{"id": 6631,"name": "Full Milk","extra_id": 1535,"price": "0"},{"id": 6632,"name": "Skim Milk","extra_id": 1535,"price": "0"},{"id": 6633,"name": "Soy Milk","extra_id": 1535,"price": "20"}],"tags": [],"availability": "available"}';
    // final testData = '{"id": 14557,"name": "Flat White","price": 125,"before_sale_price": null,"description": "Freshly-ground beans and steamed milk","full_description": "Freshly-ground beans and steamed milk","order": 1,"category": {"id": 1727,"name": "Coffee"},"images": {"full_size": "https://res.cloudinary.com/ginja-co-ltd/image/upload/s--zHcUzne6--/c_fill,h_300,q_jpegmini,w_485/v1/vendors/the-coffee-club-205/products/flat-white-mug-14557","thumbnail": "https://res.cloudinary.com/ginja-co-ltd/image/upload/s--sVm4XF-z--/c_fill,h_70,q_jpegmini,w_103/v1/vendors/the-coffee-club-205/products/flat-white-mug-14557"},"extras": [{"id": 1535,"name": "Milk Option","min": "1","max": "1"},{"id": 1536,"name": "Buble Option","min": "0","max": "5"}],"extra_items": [{"id": 6631,"name": "Full Milk","extra_id": 1535,"price": "0"},{"id": 6632,"name": "Skim Milk","extra_id": 1535,"price": "0"},{"id": 6633,"name": "Soy Milk","extra_id": 1535,"price": "20"},{"id": 6634,"name": "Buble 1","extra_id": 1536,"price": "20"},{"id": 6635,"name": "Buble 2","extra_id": 1536,"price": "20"}],"tags": [],"availability": "available"}';
    return CoffeeDetail.fromJson(jsonDecode(testData));
  }
}
