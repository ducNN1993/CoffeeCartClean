import 'package:coffeecarttest/presentation/styles/app_colors.dart';
import 'package:coffeecarttest/presentation/styles/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
export 'package:flutter/material.dart';

mixin BasePageMixin {
  Future<void> showSnackBarMessage(String msg, BuildContext context) async {
    final snackBar = SnackBar(
      // backgroundColor: AppColors.primaryColor,
      content: Container(
        height: 40,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(msg,
              style:
                  getTextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
        ),
      ),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  hideKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }


  buildDivider() => Container(
    height: 0.2,
    color: Colors.black.withOpacity(0.5),
  );

  buildLoading() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  buildBottomLoadMore({Color? backgroundColor}) {
    return Container(
      alignment: Alignment.center,
      color: backgroundColor ?? AppColors.grey2F5,
      child: Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  showBottomSheetMenu<T>(
      {required Widget child,
      required BuildContext context,
      double? height,
      bool isDismissible = false}) {
    return showModalBottomSheet<T>(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.menuBackground,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        // ),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 60,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  )),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: Container(
                    color: AppColors.white,
                    height:
                        height ?? MediaQuery.of(context).size.height * 5 / 6,
                    alignment: Alignment.center,
                    child: Center(child: child)),
              ),
            ],
          );
        });
  }
}
