import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TextTitle.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoldCard extends StatelessWidget{
  String text1,text2;

  GoldCard(this.text1, this.text2);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextTitle(text1,Theme.of(context).textTheme.subtitle2),
          TextTitle(text2,Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }

}