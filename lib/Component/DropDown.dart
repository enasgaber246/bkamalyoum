import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'DropDownModel.dart';

class DropDown extends StatefulWidget {
  List<DropDownModel> dropdownItem = [];
  DropDownModel dropdownvalue;

  DropDown(this.dropdownItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    dropdownvalue = dropdownItem[0];
    return DropDownState();
  }
}

class DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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

            isExpanded: true,
            icon: SvgPicture.asset(
              'assets/images/arrow.svg',
              width: 42.sp,
              height: 32.sp,
              fit: BoxFit.contain,
              color: Theme.of(context).primaryColor,
            ),

            value: widget.dropdownvalue,
            // Array list of items
            items: widget.dropdownItem.map((DropDownModel item) {
              return DropdownMenuItem(
                value: item,
                child: Container(
                  width: 800.07.sp,
                  child: Text(
                    item.title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 55.sp),
                  ),
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (DropDownModel newValue) {
              setState(() {
                widget.dropdownvalue = newValue;
              });
            },
          ),
        ));
  }
}
