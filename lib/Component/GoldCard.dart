import 'package:bkamalyoum/Screens/GoldPrices/metal_prices_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'TextTitle.dart';

class GoldCard extends StatelessWidget {
  // String text1,text2;
  MetalModel model;

  GoldCard(
    this.model,
  );

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextTitle(numberFormat.format(double.parse(model?.price ?? '0')) ?? '-', Theme.of(context).textTheme.subtitle2),
          TextTitle(model.nameAr ?? '-', Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }
}
