import 'dart:convert';

import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login_response.dart';
import 'register_response.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signupScreenState();
  }
}

class _signupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordConfirmCtrl = TextEditingController();

  // Switch Password
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  @override
  Widget build(BuildContext mContext) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
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
              ctrl: nameCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'رجاء إدخال الاسم';
                }
                return null;
              },
            ),
            AuthInputData(
              'رقم الهاتف',
              TextInputType.phone,
              ctrl: phoneCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'رجاء إدخال رقم الهاتف';
                }
                return null;
              },
            ),
            AuthInputData(
              "كلمه المرور",
              TextInputType.visiblePassword,
              ctrl: passwordCtrl,
              isPass: !_passwordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'رجاء إدخال كلمة المرور';
                }
                return null;
              },
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
            AuthInputData(
              "تأكيد كلمه المرور",
              TextInputType.visiblePassword,
              ctrl: passwordConfirmCtrl,
              isPass: !_passwordConfirmVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'رجاء تأكيد كلمة المرور';
                }
                return null;
              },
              suffixIcon: Container(
                child: InkWell(
                  onTap: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordConfirmVisible = !_passwordConfirmVisible;
                    });
                  },
                  child: Icon(
                    _passwordConfirmVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(mContext).primaryColor,
                  ),
                ),
              ),
            ),
            // Spacer(),
            Btn(
              'تسجيل',
              height: 178.0,
              fontSize: 62,
              fontWeight: FontWeight.w500,
              horizontal: 50.0,
              verticalMargin: 200,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if((passwordCtrl.text ?? '') != (passwordConfirmCtrl.text ?? '')){
                    showMsg(mContext, 'رجاء تأكيد كلمة المرور');
                    return;
                  }

                  RegisterResponse response = await signupAPIClick(
                    mContext,
                    nameCtrl.text ?? '',
                    phoneCtrl.text ?? '',
                    passwordCtrl.text ?? '',
                  );

                  // if (response != null &&
                  //     (response?.accessToken ?? '').isNotEmpty) {
                  //   Navigator.pop(mContext);
                  // }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<RegisterResponse> signupAPIClick(
      BuildContext mContext, String userName, String phoneNumber, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcm_token = prefs.get("FCM_DEVICE_TOKEN") ?? '';

    final body = {
      'name': userName,
      'phone': phoneNumber,
      'password': password,
      'token': fcm_token,
    };

    showDialogProgress(mContext);
    String baseUrl = 'https://bkamalyoum.com/api/';
    var res = await http.post(
      '${baseUrl}register',
      body: body,
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      print('LoadLoginEvent Response :  ${data.toString()}');
      RegisterResponse response = RegisterResponse.fromJson(data);

      if (res.statusCode == 200) {
        // prefs.setString('token_type', response.tokenType ?? '');
        // prefs.setString('accessToken', response.accessToken ?? '');
        // prefs.setString('refreshToken', response.refreshToken ?? '');

        // Navigator.pop(mContext);
        showMsg(mContext, 'تم تسجيل الحساب، رجاء تسجيل الدخول');
        return response;
      } else {
        showMsg(mContext, response?.emsg ?? '');
        return response;
      }
    } catch (e) {
      print('LoadCurrencyEvent Error :  ' + e.toString());
      showMsg(mContext, 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
      return null;
    }
  }
}
