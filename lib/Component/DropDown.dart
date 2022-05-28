import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DropDown extends StatefulWidget {
  List<String> dropdownItem=[];
  String dropdownvalue;

  DropDown(this.dropdownItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     dropdownvalue = dropdownItem[0];
    return DropDownState();
  }
}

class DropDownState extends State<DropDown> {


  // List of items in our dropdown menu
  // var items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 104.67.sp,
     // width: 1021.07.sp,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: DropdownButtonHideUnderline(
    child: DropdownButton(
        // Initial Value
        // Down Arrow Icon

      isExpanded: true,
        icon: SvgPicture.asset(
          'assets/images/arrow.svg',
          width: 42.sp,
          height: 25.sp,
          fit: BoxFit.contain,
          color: Theme.of(context).primaryColor,
        ),

        value: widget.dropdownvalue,
        // Array list of items
        items: widget.dropdownItem.map((String items) {
          return DropdownMenuItem(
            value: items,
            child:Container(

              child: Text(items)),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String newValue) {
          setState(() {
            widget.dropdownvalue = newValue;
          });
        },
      ),
    ));
  }
}
