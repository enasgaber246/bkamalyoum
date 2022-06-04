import 'package:bkamalyoum/Screens/BankPrices/BankPricesResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'TextTitle.dart';

class BankPricesCard extends StatelessWidget {
  // String IconPath;
  // String text1, text2, text3;
  TextStyle textStyle;

  // String networkUrl;
  BankPriceModel model;

  BankPricesCard(
    this.model,
    // this.IconPath,
    // this.text1,
    // this.text2,
    // this.text3,
    this.textStyle,
    // this.networkUrl,
  );

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 8.sp),
                      SvgPicture.asset(
                        'assets/images/arrow_down.svg',
                        width: 36.sp,
                        height: 36.sp,
                        fit: BoxFit.contain,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 8.sp),
                      TextTitle(
                          numberFormat.format(
                                  double.parse(model?.buyingPrice ?? '0')) ??
                              '-',
                          textStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 8.sp),
                      SvgPicture.asset(
                        'assets/images/arrow_up.svg',
                        width: 36.sp,
                        height: 36.sp,
                        fit: BoxFit.contain,
                        color: Colors.green,
                      ),
                      SizedBox(width: 8.sp),
                      TextTitle(
                          numberFormat.format(
                                  double.parse(model?.sellingPrice ?? '0')) ??
                              '-',
                          textStyle),
                    ],
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
                TextTitle(model.nameAr ?? '-', textStyle),
                SizedBox(width: 12.sp),
                SvgPicture.asset(
                  'assets/images/note_notifications.svg',
                  width: 52.sp,
                  height: 52.sp,
                  fit: BoxFit.contain,
                  color: Colors.grey,
                ),
                SizedBox(width: 12.sp),
                (model.image == null)
                    ? SizedBox(
                        width: 100.sp,
                        height: 100.sp,
                      )
                    : Container(
                        width: 100.sp,
                        height: 100.sp,
                        padding: EdgeInsets.all(5.0.sp),
                        child: Image.network(
                          'https://bkamalyoum.com/uploads/small/${model.image}',
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
                SizedBox(width: 12.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
