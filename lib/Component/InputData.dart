import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputData extends StatelessWidget {
  double verticalMargin = 0, horizontal;
  double width, height;
  bool enabled = true;
  TextInputType keyboardType = TextInputType.text;
  TextEditingController ctrl;
  FormFieldValidator<String> validator;
  final bool isPass;
  final Widget suffixIcon;

  InputData({
    this.verticalMargin = 0,
    this.horizontal = 24,
    this.width = double.infinity,
    this.height = 48.0,
    this.ctrl,
    this.keyboardType,
    this.enabled,
    this.validator,this.isPass, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontal.sp, vertical: verticalMargin.sp),
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        // height: height.sp,
        decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(50),
            border: Border.all(color: const Color(0xFF4D8D8F)),
            borderRadius: new BorderRadius.all(Radius.circular(38.0.sp))),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          enabled: enabled,
          cursorColor: Theme.of(context).primaryColor,
          keyboardType: keyboardType,
          validator: validator,
          controller: ctrl,
          obscureText: isPass,
          decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(
              fontSize: 12.0,
              height: 0.4,
            ),
            labelStyle: TextStyle(
              fontSize: 14.0,
            ),
            hintStyle: TextStyle(
              fontSize: 14.0,
            ),
            suffixIcon: suffixIcon,
          ),
        ));
  }
}
