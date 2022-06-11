import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Btn.dart';

showDialogProgress(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.black.withOpacity(.6),
    builder: (context) {
      return Center(child: showProgressLoading());
    },
  );
}

Widget showProgressLoading() {
  if (Platform.isIOS) {
    return Container(
      height: 32,
      width: 32,
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 14,
      ),
    );
  } else {
    return Container(
      height: 32,
      width: 32,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}

showMsg(BuildContext mContext, String msg) {
  // Toast.show(msg, context, duration: 4);
  // Alert(context: context, title: "RFLUTTER", desc: msg).show();
  if ((msg ?? '').isEmpty) {
    return;
  }
  Alert(
    context: mContext,
    type: AlertType.none,
    title: msg,
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Theme.of(mContext).primaryColor,
        fontSize: 62.sp,
        fontFamily: "Dubai",
      ),
    ),
    buttons: [
      DialogButton(
        child: Btn(
          'حسنا',
          height: 178.0,
          fontSize: 62,
          fontWeight: FontWeight.w500,
          horizontal: 50.0,
          verticalMargin: 0,
          onPressed: () async {
            Navigator.pop(mContext);
          },
        ),
        color: Theme.of(mContext).primaryColor,
        onPressed: () => Navigator.pop(mContext),
      )
    ],
  ).show();
}
