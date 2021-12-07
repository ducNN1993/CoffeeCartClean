import 'dart:async';

import 'package:coffeecarttest/core/error/exceptions.dart';
import 'package:coffeecarttest/core/error/failures.dart';
import 'package:coffeecarttest/presentation/app/index.dart';
import 'package:coffeecarttest/presentation/navigator/page_navigator.dart';
import 'package:coffeecarttest/presentation/resources/index.dart';
import 'package:coffeecarttest/presentation/styles/app_colors.dart';
import 'package:coffeecarttest/presentation/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import '../../app_injector.dart';
import '../app/application_bloc.dart';
import 'base_bloc.dart';
import 'base_event.dart';
import 'base_page_mixin.dart';
import 'base_router.dart';
import 'base_state.dart';

export 'package:logger/logger.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({
    required this.tag,
    Key? key,
    this.bloc,
    this.router,
  }) : super(key: key);
  final PageTag tag;
  final BaseBloc? bloc;
  final BaseRouter? router;
}

abstract class BasePageState<
    T extends BaseBloc<BaseEvent, BaseState>,
    P extends BasePage,
    R extends BaseRouter> extends State<P> with BasePageMixin {
  late BaseBloc bloc;
  late BuildContext subContext;
  late BaseRouter router;
  late ApplicationBloc applicationBloc;
  late StreamSubscription<BaseEvent>? appStreamSubscription;

  bool get willListenApplicationEvent => false;

  bool get usingAppBackgroundPhoto => true;

  bool get resizeToAvoidBottomInset => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.dispatchEvent(PageDidChangeDependenciesEvent(context: context));
  }

  @override
  void initState() {
    bloc = widget.bloc ?? injector.get<T>();
    bloc.dispatchEvent(PageInitStateEvent(
      context: context,
    ));
    router = widget.router ?? injector.get<R>();
    applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    appStreamSubscription = applicationBloc.appEventStream.listen((event) {
      if (willListenApplicationEvent) {
        bloc.dispatchEvent(event);
      }
    });
    super.initState();
  }

  Widget buildBody(BuildContext context, BaseBloc bloc);

  void stateListenerCallBack(BaseState state) async {

  }

  _onResult(dynamic res) {
    if (res != null) {
      bloc.dispatchEvent(OnResultEvent(result: res));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: BlocProvider(
            create: (context) => bloc,
          // child: BlocListener(
          //   listener: ,
          // ),
            child: BlocListener<BaseBloc, BaseState>(bloc: bloc,listener: (_, state) async {
              stateListenerCallBack(state);
              final res =
                  await router.onNavigate(context: context, state: state);
              _onResult(res);
            }, child: LayoutBuilder(builder: (sub, _) {
              subContext = sub;
              return buildBody(subContext, bloc);
            })),
          ),
        ),
      ],
    );
  }



  @override
  dispose() {
    appStreamSubscription?.cancel();
    bloc.dispose();
    bloc.close();
    super.dispose();
  }
}
