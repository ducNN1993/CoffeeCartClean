import 'package:coffeecarttest/core/error/failures.dart';
import 'package:coffeecarttest/domain/model/coffee_detail.dart';
import 'package:coffeecarttest/domain/repository/coffee_repository.dart';
import 'package:dartz/dartz.dart';

import 'index.dart';

abstract class GetDetailCoffeeUseCases {
  Future<Either<Failure, CoffeeDetail>> getDetailCoffee();
}

class GetDetailCoffeeUseCasesImpl extends BaseUseCase<CoffeeDetail>
    implements GetDetailCoffeeUseCases {
  CoffeeRepository _repository;
  GetDetailCoffeeUseCasesImpl(this._repository);
  @override
  Future<Either<Failure, CoffeeDetail>> getDetailCoffee() {
    return this.execute();
  }

  @override
  Future<CoffeeDetail> main() async{
    final r = await _repository.getCoffeeDetail();
    return r;
  }
}
