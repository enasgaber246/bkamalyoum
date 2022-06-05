import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'ChoiseCoinCard.dart';

class DropDownCurrency extends StatefulWidget {
  List<Current> dropdownItem = [];
  Current dropdownvalue;

  DropDownCurrency(this.dropdownItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    dropdownvalue = dropdownItem[0];
    return DropDownCurrencyState();
  }
}

class DropDownCurrencyState extends State<DropDownCurrency> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 15.0.sp),
        padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
        height: 124.67.sp,
        width: 1021.07.sp,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(80.sp))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // Initial Value
            // Down Arrow Icon

            // isExpanded: true,
            icon: SvgPicture.asset(
              'assets/images/arrow.svg',
              width: 42.sp,
              height: 32.sp,
              fit: BoxFit.fill,
              color: Theme.of(context).primaryColor,
            ),

            value: widget.dropdownvalue,
            // Array list of items
            items: widget.dropdownItem.map((Current item) {
              return DropdownMenuItem(
                value: item,
                child: Container(
                  width: 800.07.sp,
                  child: Text(
                    item.nameAr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 55.sp,),
                  ),
                  // child: ChoiseCoinCard(
                  //   item.image ??
                  //       '',
                  //   item.nameAr,
                  //   item.nameEn,
                  //   onPressed: () async {
                  //   },
                  // ),
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (Current newValue) {
              setState(() {
                widget.dropdownvalue = newValue;
              });
            },
          ),
        ));
  }
}
