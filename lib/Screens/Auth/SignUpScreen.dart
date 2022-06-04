import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signupScreenState();
  }
}

class _signupScreenState extends State<SignupScreen> {
  // Switch Password
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext mContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            margin:
                EdgeInsets.symmetric(horizontal: 60.0.sp, vertical: 60.0.sp),
            child: TextTitle(
              'يرجي تعبئة المعلومات التالية',
              Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.end,
            )),
        AuthInputData(
          'الاسم',
          TextInputType.name,
        ),
        AuthInputData(
          'رقم الهاتف',
          TextInputType.phone,
        ),
        AuthInputData(
          "كلمه المرور",
          TextInputType.visiblePassword,
          isPass: !_passwordVisible,
          suffixIcon: Container(
            child: InkWell(
              onTap: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(mContext).primaryColor,
              ),
            ),
          ),
        ),
        Spacer(),
        Btn(
          'تسجيل',
          height: 178.0,
          fontSize: 62,
          fontWeight: FontWeight.w500,
          horizontal: 50.0,
          verticalMargin: 200,
          onPressed: () {},
        )
      ],
    );
  }
}
