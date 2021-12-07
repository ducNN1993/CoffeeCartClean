import 'package:coffeecarttest/presentation/app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_state.dart';

abstract class BaseRouter {
  ApplicationBloc applicationBloc(BuildContext context) {
    final bloc = BlocProvider.of<ApplicationBloc>(context);
    return bloc;
  }

  dynamic onNavigate(
      {required BuildContext context, required BaseState state});
}
