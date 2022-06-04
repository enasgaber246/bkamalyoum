import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TextTitle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'InputData.dart';

class AuthInputData extends StatelessWidget {
  final String text;
  final TextInputType keyboardType;
  final bool isPass;
  final Widget suffixIcon;
  final TextEditingController ctrl;
  final FormFieldValidator<String> validator;

  AuthInputData(this.text, this.keyboardType,
      {this.isPass = false, this.suffixIcon, this.ctrl, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            margin:
                EdgeInsets.symmetric(horizontal: 60.0.sp, vertical: 60.0.sp),
            child: TextTitle(
              text,
              Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            )),
        InputData(
          height: 178.0,
          horizontal: 50.0,
          keyboardType: keyboardType,
          isPass: isPass,
          suffixIcon: suffixIcon,
          ctrl: ctrl,
          validator: validator,
        ),
      ],
    );
  }
}
