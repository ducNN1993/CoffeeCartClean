import 'package:coffeecarttest/data/remote/api/coffee_api_impl.dart';
import 'package:coffeecarttest/data/remote/base/index.dart';
import 'package:coffeecarttest/data/repository/index.dart';
import 'package:coffeecarttest/domain/repository/coffee_repository.dart';
import 'package:coffeecarttest/domain/usecase/index.dart';
import 'package:coffeecarttest/presentation/page/coffee_cart/coffee_cart_bloc.dart';
import 'package:coffeecarttest/presentation/page/coffee_cart/index.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_status.dart';
import 'data/remote/api/index.dart';
import 'presentation/app/index.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
  injector.registerFactory<ApplicationBloc>(
          () => ApplicationBloc());

  //API
  injector.registerLazySingleton<ApiConfig>(() => ApiConfigImpl());
  injector.registerLazySingleton(() => InternetConnectionChecker());
  injector.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(injector(), injector()));
  injector.registerFactory<CoffeeApi>(() => CoffeeApiImpl());

  // repository
  injector.registerFactory<CoffeeRepository>(
          () => CoffeeRepositoryImpl(injector()));

  //
  //Bloc
  injector.registerFactory<CoffeeCartBloc>(
          () => CoffeeCartBloc(injector()));

  // router
  injector.registerFactory<CoffeeCartRouter>(() => CoffeeCartRouter());

  // use case
  injector.registerFactory<GetDetailCoffeeUseCases>(
          () => GetDetailCoffeeUseCasesImpl(injector()));

}
