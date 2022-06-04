import 'dart:convert';

import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login_response.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signinScreenState();
  }
}

class _signinScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  // Switch Password
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext mContext) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          Spacer(),
          Btn(
            'دخول',
            height: 178.0,
            fontSize: 62,
            fontWeight: FontWeight.w500,
            horizontal: 50.0,
            verticalMargin: 400,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                LoginResponse response = await loginAPIClick(
                  mContext,
                  phoneCtrl.text ?? '',
                  passwordCtrl.text ?? '',
                );

                if (response != null &&
                    (response?.accessToken ?? '').isNotEmpty) {
                  Navigator.pop(mContext);
                }
              }
            },
          ),
        ],
      ),
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
