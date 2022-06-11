import 'dart:convert';

import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Screens/Auth/resend_response.dart';
import 'package:bkamalyoum/Screens/Menu/MenuBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ConfirmPhoneNumber/ConfirmPhoneNumberScreen.dart';
import 'login_response.dart';

class SigninScreen extends StatefulWidget {
  final BuildContext homeContext;
  final MenuBloc bloc;

  const SigninScreen({Key key, this.homeContext, this.bloc}) : super(key: key);

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
      child: SingleChildScrollView(
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
            // Spacer(),
            SizedBox(height: 320.sp),
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
                      (response?.edata?.accessToken ?? '').isNotEmpty) {
                    if(widget.bloc!=null){
                      widget.bloc.add(LoadMenuEvent());
                    }
                    Navigator.pop(mContext);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<LoginResponse> loginAPIClick(
      BuildContext mContext, String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String fcm_token = prefs.get("FCM_DEVICE_TOKEN") ?? '';

    final body = {
      'username': userName,
      'password': password,
    };

    showDialogProgress(mContext);
    String baseUrl = 'https://bkamalyoum.com/api/';
    var res = await http.post(
      '${baseUrl}login',
      body: body,
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      LoginResponse response = LoginResponse.fromJson(data);

      print('LoadLoginEvent Response :  ${data.toString()}');
      print('LoadLoginEvent Response Code :  ${response.ecode.toString()}');
      print('LoadLoginEvent Response Msg :  ${response.emsg.toString()}');

      if (response.ecode == 200) {
        prefs.setString('accessToken', response?.edata?.accessToken ?? '');
        prefs.setString('UserName', response?.edata?.user?.name ?? '');
        prefs.setString('UserPhone', response?.edata?.user?.phone ?? '');
        prefs.setString('UserImage', response?.edata?.user?.image ?? '');
        prefs.setString('UserPhoneVerifiedAt', response?.edata?.user?.phoneVerifiedAt?.toString() ?? '');
        return response;
      } else if (response.ecode == 403) {
        // Phone Need To Be Verified,
        // First Send Code Again,
        ResendResponse response =
            await resendCodeAPI(mContext, phoneCtrl.text ?? '');

        if (response != null && response.ecode == 200) {
          Navigator.of(mContext).push(MaterialPageRoute(
              builder: (context) => ConfirmPhoneNumberScreen(
                    phone_number: phoneCtrl.text ?? '',
                    homeContext: widget.homeContext,bloc:widget.bloc,
                  )));
        }
        return null;
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

  Future<ResendResponse> resendCodeAPI(
      BuildContext mContext, String userName) async {
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
