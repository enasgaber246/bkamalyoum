import 'dart:convert';

import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/Auth/login_response.dart';
import 'package:bkamalyoum/Screens/Auth/resend_response.dart';
import 'package:bkamalyoum/Screens/Menu/MenuBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfirmPhoneNumberScreen extends StatelessWidget {
  final BuildContext homeContext;
  final MenuBloc bloc;
  final String phone_number;
  String currentCode = '';

  // CountdownTimerController timerController =
  //     CountdownTimerController(endTime: 1);

  // AuthForgotEnterCodeBloc bloc = AuthForgotEnterCodeBloc();
  // final _formKey = GlobalKey<FormState>();

  ConfirmPhoneNumberScreen({Key key, this.phone_number, this.homeContext, this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext mContext) {
    // timerController.start();

    return screenContent(mContext);
  }

  Widget screenContent(mContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/splash.svg',
              alignment: Alignment.center,
              fit: BoxFit.cover,
              width: MediaQuery
                  .of(mContext)
                  .size
                  .width,
              height: MediaQuery
                  .of(mContext)
                  .size
                  .height,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 124.sp),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 85.0.sp),
                  padding: EdgeInsets.symmetric(vertical: 56.sp),
                  child: TextTitle('أدخل كود التفعيل',
                    Theme
                        .of(mContext)
                        .textTheme
                        .headline1,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 42.0.sp, vertical: 8.0.sp),
                    alignment: Alignment.center,
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: Theme
                              .of(mContext)
                              .primaryColor,
                          fontSize: 60.sp),
                      child: Text(
                        '$phone_number',
                        textAlign: TextAlign.center,
                      ),
                    )),
                SizedBox(height: 78.0.sp),
                VerificationCode(
                  autofocus: true,
                  textStyle: TextStyle(
                      fontSize: 85.0.sp,
                      color: Theme
                          .of(mContext)
                          .primaryColor),
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor: Theme
                      .of(mContext)
                      .accentColor,
                  underlineColor: Theme
                      .of(mContext)
                      .primaryColor,
                  // If this is null it will use primaryColor: Colors.red from Theme
                  length: 6,
                  cursorColor: Theme
                      .of(mContext)
                      .primaryColor,
                  onCompleted: (String value) {
                    currentCode = value;
                  },
                  onEditing: (bool value) {
                    if (value) {}
                  },
                ),
                SizedBox(height: 56.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        resendCodeAPI(mContext, phone_number);
                      },
                      child: Text(
                        "إعادة الإرسال",
                        style: TextStyle(
                            color: Theme
                                .of(mContext)
                                .primaryColor,
                            fontSize: 55.0.sp),
                      ),
                    ),
                    // CountDown
                    Text(
                      "00:00",
                      style: TextStyle(
                          color: Theme
                              .of(mContext)
                              .primaryColor,
                          fontSize: 55.0.sp),
                    ),
                  ],
                ),
                Spacer(),
                btnContainer(mContext),
                SizedBox(height: 32.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget btnContainer(mContext) {
    return Btn(
      'تسجيل',
      height: 178.0,
      fontSize: 62,
      fontWeight: FontWeight.w500,
      horizontal: 100.0,
      verticalMargin: 200,
      color: Theme
          .of(mContext)
          .primaryColor,
      textColor: Theme
          .of(mContext)
          .primaryColorLight,
      onPressed: () async {
        LoginResponse response =
        await confirmPhoneAPIClick(mContext, phone_number, currentCode);

        if (response != null &&
            (response?.edata?.accessToken ?? '').isNotEmpty) {
          // Navigator.pop(mContext);
          if(bloc!=null){
            bloc.add(LoadMenuEvent());
          }
          Navigator.pop(mContext);
          Navigator.pop(mContext);
          showMsg(homeContext, 'تم التسجيل بنجاح');
        }
      },
    );
  }

  Future<LoginResponse> confirmPhoneAPIClick(BuildContext mContext,
      String userName, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String fcm_token = prefs.get("FCM_DEVICE_TOKEN") ?? '';

    final body = {
      'phone': userName,
      'code': code,
    };

    showDialogProgress(mContext);
    String baseUrl = 'https://bkamalyoum.com/api/';
    var res = await http.post(
      '${baseUrl}register/confirm_number',
      body: body,
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      print('LoadLoginEvent Response :  ${data.toString()}');
      LoginResponse response = LoginResponse.fromJson(data);

      if (response.ecode == 200) {
        prefs.setString('accessToken', response?.edata?.accessToken ?? '');
        prefs.setString('UserName', response?.edata?.user?.name ?? '');
        prefs.setString('UserPhone', response?.edata?.user?.phone ?? '');
        prefs.setString('UserImage', response?.edata?.user?.image ?? '');
        prefs.setString('UserPhoneVerifiedAt',
            response?.edata?.user?.phoneVerifiedAt?.toString() ?? '');
        return response;
      } else {
        showMsg(mContext,
            response?.emsg ?? 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
        return response;
      }
    } catch (e) {
      print('LoadCurrencyEvent Error :  ' + e.toString());
      showMsg(mContext, 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
      return null;
    }
  }

  Future<ResendResponse> resendCodeAPI(BuildContext mContext,
      String userName) async {
    final body = {
      'phone': userName,
    };

    showDialogProgress(mContext);
    String baseUrl = 'https://bkamalyoum.com/api/';
    var res = await http.post(
      '${baseUrl}register/resend',
      body: body,
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      print('LoadLoginEvent Response :  ${data.toString()}');
      ResendResponse response = ResendResponse.fromJson(data);

      if (response.ecode == 200) {
        return response;
      } else {
        showMsg(mContext,
            response?.emsg ?? 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
        return null;
      }
    } catch (e) {
      print('LoadCurrencyEvent Error :  ' + e.toString());
      showMsg(mContext, 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
      return null;
    }
  }
}
