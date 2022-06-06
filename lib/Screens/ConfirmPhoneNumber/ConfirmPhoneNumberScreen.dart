import 'dart:convert';

import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Screens/Auth/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfirmPhoneNumberScreen extends StatelessWidget {
  final String phone_number;
  String currentCode = '';

  // CountdownTimerController timerController =
  //     CountdownTimerController(endTime: 1);

  // AuthForgotEnterCodeBloc bloc = AuthForgotEnterCodeBloc();
  final _formKey = GlobalKey<FormState>();

  ConfirmPhoneNumberScreen({Key key, this.phone_number}) : super(key: key);

  @override
  Widget build(BuildContext mContext) {
    // timerController.start();

    return screenContent(mContext);
  }

  Widget screenContent(mContext) {
    return Scaffold(
      backgroundColor: Theme.of(mContext).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 124.sp),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 85.0.sp),
                padding: EdgeInsets.symmetric(vertical: 56.sp),
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: Theme.of(mContext).primaryColorLight, fontSize: 60.sp),
                  child: Text('Enter Verification Code',
                      textAlign: TextAlign.center),
                )),
            Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 42.0.sp, vertical: 8.0.sp),
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: Theme.of(mContext).primaryColorLight,
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
                  color: Theme.of(mContext).primaryColorLight),
              keyboardType: TextInputType.number,
              underlineUnfocusedColor: Theme.of(mContext).accentColor,
              underlineColor: Theme.of(mContext).primaryColorLight,
              // If this is null it will use primaryColor: Colors.red from Theme
              length: 6,
              cursorColor: Theme.of(mContext).primaryColorLight,
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
                  onPressed: () {},
                  child: Text(
                    "Send Again In",
                    style: TextStyle(
                        color: Theme.of(mContext).primaryColorLight,
                        fontSize: 55.0.sp),
                  ),
                ),
                // CountDown
                Text(
                  "00:00",
                  style: TextStyle(
                      color: Theme.of(mContext).primaryColorLight,
                      fontSize: 55.0.sp),
                ),
              ],
            ),
            Spacer(),
            btnContainer(mContext),
            SizedBox(height: 32.sp),
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
      horizontal: 50.0,
      verticalMargin: 200,
      color: Theme.of(mContext).primaryColorLight,
      textColor: Theme.of(mContext).primaryColor,
      onPressed: () async {
        LoginResponse response =
            await loginAPIClick(mContext, phone_number, currentCode);

        if (response != null && (response?.accessToken ?? '').isNotEmpty) {
          Navigator.pop(mContext);
          Navigator.pop(mContext);
          showMsg(mContext, 'تم التسجيل بنجاح');
        }
      },
    );
  }

  Future<LoginResponse> loginAPIClick(
      BuildContext mContext, String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcm_token = prefs.get("FCM_DEVICE_TOKEN") ?? '';

    final body = {
      'grant_type': 'password',
      'client_id': '2',
      'client_secret': 'B6SvApwz5nGuDxqrPEwFzgPLfFT14PhLOJECfljx',
      'username': userName,
      'password': password,
      'scope': '',
    };

    showDialogProgress(mContext);
    String baseUrl = 'https://bkamalyoum.com/';
    var res = await http.post(
      '${baseUrl}oauth/token',
      body: body,
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      print('LoadLoginEvent Response :  ${data.toString()}');
      LoginResponse response = LoginResponse.fromJson(data);

      if (res.statusCode == 200) {
        prefs.setString('token_type', response.tokenType ?? '');
        prefs.setString('accessToken', response.accessToken ?? '');
        prefs.setString('refreshToken', response.refreshToken ?? '');
        return response;
      } else {
        showMsg(mContext, response?.message ?? '');
        return response;
      }
    } catch (e) {
      print('LoadCurrencyEvent Error :  ' + e.toString());
      showMsg(mContext, 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
      return null;
    }
  }
}
