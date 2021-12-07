import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressHud extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  ProgressHud({
    this.inAsyncCall = false,
    this.opacity = 0,
    this.color = Colors.pink,
    this.progressIndicator = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
    ),
    this.offset,
    this.dismissible = false,
    required this.child,
  })  : assert(child != null),
        super();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null)
        layOutProgressIndicator = Center(child: progressIndicator);
      else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset!.dx,
          top: offset!.dy,
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
