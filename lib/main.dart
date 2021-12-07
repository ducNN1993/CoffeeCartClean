import 'package:coffeecarttest/presentation/page/coffee_cart/index.dart';
import 'package:coffeecarttest/presentation/resources/index.dart';
import 'package:coffeecarttest/presentation/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_injector.dart';
import 'presentation/app/index.dart';
import 'presentation/base/index.dart';

late ApplicationBloc appBloc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjector();
  await AppLocalizations.shared.reloadLanguageBundle(languageCode: "en");

  appBloc = injector.get<ApplicationBloc>();
  runApp(BlocProvider<ApplicationBloc>(
    create: (context) => appBloc,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appBloc.dispatchEvent(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<ApplicationBloc, BaseState>(
          bloc: appBloc,
          builder: (context, state) {
            return CoffeeCartPage(PageTag.coffee_page_tag);
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
