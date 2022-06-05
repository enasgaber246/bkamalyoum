import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputDataWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool isEnable;

  const InputDataWidget(
      {Key key, this.controller, this.keyboardType, this.onChanged,this.isEnable = true})
      : super(key: key);

  @override
  Widget build(BuildContext mcontext) {
    // TODO: implement build
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
      height: 148.67.sp,
      width: 1021.07.sp,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme
                .of(mcontext)
                .primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.sp))),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        enabled: isEnable,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
