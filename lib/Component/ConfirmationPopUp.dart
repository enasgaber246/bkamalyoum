import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Btn.dart';
import 'TextTitle.dart';

class ConfirmationPopUp extends StatelessWidget {
  String _title;
  VoidCallback onPressed;

  ConfirmationPopUp(this._title, this.onPressed);

  @override
  Widget build(BuildContext mContext) {
    // TODO: implement build
    return new AlertDialog(
        backgroundColor: Theme.of(mContext).dialogBackgroundColor,
        content: Container(
          // padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
          color: Theme.of(mContext).dialogBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextTitle(_title,
                Theme.of(mContext).textTheme.headline1,
              ),
              SizedBox(height: 104.0.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: Btn(
                        'إلغاء',
                        height: 148.0,
                        fontSize: 62,
                        fontWeight: FontWeight.w500,
                        horizontal: 50.0,
                        verticalMargin: 0,
                        onPressed: () {
                          Navigator.pop(mContext);
                        },
                      )),
                  SizedBox(width: 10.0.sp),
                  Flexible(
                    flex: 1,
                    child: Btn(
                      'تأكيد',
                      height: 148.0,
                      fontSize: 62,
                      fontWeight: FontWeight.w500,
                      horizontal: 50.0,
                      verticalMargin: 0,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
