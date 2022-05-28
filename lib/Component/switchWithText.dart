import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TextTitle.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class switchWithText extends StatelessWidget {
  String lableText;
  bool status;
  ValueChanged<bool> onToggle;

  switchWithText(this.lableText, this.status, this.onToggle);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(8.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextTitle(lableText, Theme.of(context).textTheme.subtitle1),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),

            child: Switch(
              value: status,
              onChanged:onToggle,
              activeColor:Theme.of(context).primaryColor ,
              inactiveThumbColor: Colors.black12,
            ),
            // child: FlutterSwitch(
            //   width: 52.0,
            //   height: 25.0,
            //  // valueFontSize: 12.0,
            //   toggleSize: 21.0,
            //   value: status,
            //   activeColor: Colors.amber,
            //   toggleColor: Theme.of(context).primaryColor,
            //   inactiveColor: Colors.deepPurple,
            //   inactiveToggleColor: Colors.red,
            //   borderRadius: 90.0,
            //   padding: 2.0,
            //   showOnOff: true,
            //   onToggle: onToggle,
            // ),
          ),
        ],
      ),
    );
  }
}
