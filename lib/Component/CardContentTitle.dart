import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TextTitle.dart';

class CardContentTitle extends StatelessWidget {
  // String IconPath;
  String text1, text2, text3;
  TextStyle textStyle;
  String networkUrl;

  final GestureTapCallback onClickBuyBtn;
  final GestureTapCallback onClickSellBtn;

  CardContentTitle(
    // this.IconPath,
    this.text1,
    this.text2,
    this.text3,
    this.textStyle, {
    this.networkUrl,
    this.onClickBuyBtn,
    this.onClickSellBtn,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // SizedBox(width: 80.sp),
                Expanded(
                  child: InkWell(
                    onTap: onClickBuyBtn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // arrow_arrange_down.svg
                        // arrow_arrange_up.svg
                        SvgPicture.asset(
                          'assets/images/arrow_arrange_down.svg',
                          width: 48.sp,
                          height: 48.sp,
                          fit: BoxFit.contain,
                          color: Colors.grey,
                        ),
                        TextTitle(
                          text2 ?? '-',
                          textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onClickBuyBtn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // arrow_arrange_down.svg
                        // arrow_arrange_up.svg
                        SvgPicture.asset(
                          'assets/images/arrow_arrange_up.svg',
                          width: 48.sp,
                          height: 48.sp,
                          fit: BoxFit.contain,
                          color: Colors.grey,
                        ),
                        TextTitle(
                          text3 ?? '-',
                          textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextTitle(
                  text1 ?? '-',
                  textStyle,
                ),
                SizedBox(width: 48.sp),
                // Container(
                //   width: 145.71.sp,
                //   height: 76.72.sp,
                //   child: SvgPicture.asset(
                //     IconPath,
                //   ),
                // ),
                (networkUrl == null)
                    ? SizedBox(
                        width: 156.sp,
                        height: 124.sp,
                      )
                    : Container(
                        width: 156.sp,
                        height: 124.sp,
                        padding: EdgeInsets.all(12.0.sp),
                        child: Image.network(
                          'https://bkamalyoum.com/uploads/small/${networkUrl}',
                          fit: BoxFit.fill,
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
                SizedBox(width: 16.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
