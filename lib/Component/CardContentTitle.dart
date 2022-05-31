import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TextTitle.dart';

class CardContentTitle extends StatelessWidget {
  String IconPath;
  String text1, text2, text3;
  TextStyle textStyle;
  String networkUrl;

  CardContentTitle(
      this.IconPath,
      this.text1,
      this.text2,
      this.text3,
      this.textStyle, {
        this.networkUrl,
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 80.sp,
              ),
              TextTitle(text2 ?? '-', textStyle),
              SizedBox(
                width: 140.sp,
              ),
              TextTitle(text3 ?? '-', textStyle)
            ],
          ),
          Row(
            children: [
              TextTitle(text1 ?? '-', textStyle),
              SizedBox(
                width: 50.sp,
              ),
              // Container(
              //   width: 145.71.sp,
              //   height: 76.72.sp,
              //   child: SvgPicture.asset(
              //     IconPath,
              //   ),
              // ),
              (networkUrl == null)
                  ? SizedBox(
                width: 100.sp,
                height: 100.sp,
              )
                  :
              Container(
                width: 100.sp,
                height: 100.sp,
                padding: EdgeInsets.all(5.0.sp),
                child: Image.network(
                  'https://bkamalyoum.com/uploads/small/${networkUrl}',
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
