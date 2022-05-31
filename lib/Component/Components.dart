import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
