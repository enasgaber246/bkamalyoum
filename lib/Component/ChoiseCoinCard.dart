import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'TextTitle.dart';

class ChoiseCoinCard extends StatelessWidget {
  String networkUrl;
  String text1, text2;
  VoidCallback onPressed;

  ChoiseCoinCard(this.networkUrl, this.text1, this.text2, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextTitle(text2, Theme.of(context).textTheme.subtitle2),
              Row(
                children: [
                  TextTitle(text1, Theme.of(context).textTheme.subtitle2),
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
                      : Container(
                          width: 100.sp,
                          height: 100.sp,
                          padding: EdgeInsets.all(5.0.sp),
                          child: Image.network(
                            'https://bkamalyoum.com/uploads/small/${networkUrl}',
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
        ));
  }
}
