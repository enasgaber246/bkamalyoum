import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Btn extends StatelessWidget {
  String text;
  double width, height, fontSize;
  VoidCallback onPressed;
  Color color = Color(0xFF4D8D8F), textColor = Colors.white;
  FontWeight fontWeight;

  double verticalMargin = 0, horizontal;

  Btn(this.text,
      {this.width = double.infinity,
      this.height = 48.0,
      this.verticalMargin = 0,
      this.horizontal = 24,
      this.color = const Color(0xFF4D8D8F),
      this.textColor = Colors.white,
      this.onPressed,
      this.fontSize = 10,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontal.sp, vertical: verticalMargin.sp),
      height: height.sp,
      width: width.sp,
      // color: color,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: new BoxDecoration(
              color: color,
              borderRadius: new BorderRadius.all(Radius.circular(38.0.sp))),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                      fontSize: fontSize.sp,
                      color: textColor,
                      fontWeight: fontWeight,
                      fontFamily: 'Dubai'))),
        ),
      ),
    );
  }
}
