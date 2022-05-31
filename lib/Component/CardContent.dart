import 'package:bkamalyoum/Screens/BankPrices/BankPricesResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              TextTitle(model.buyingPrice ?? '-', textStyle),
              SizedBox(
                width: 140.sp,
              ),
              TextTitle(model.sellingPrice?? '-', textStyle)
            ],
          ),
          Row(
            children: [
              TextTitle(model.nameAr?? '-', textStyle),
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
              (model.image == null)
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
                  'https://bkamalyoum.com/uploads/small/${model.image}',
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
