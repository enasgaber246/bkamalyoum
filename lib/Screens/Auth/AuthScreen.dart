import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'SignInSreen.dart';
import 'SignUpScreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _authScreenState();
  }
}

class _authScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'بكام اليوم؟',
            style: TextStyle(fontFamily: 'Lalezar'),
          ),
        ),
        body: Stack(children: <Widget>[
          SvgPicture.asset(
            'assets/images/splash.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  margin: EdgeInsets.only(top: 50.0),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: "تسجيل الدخول",
                      ),
                      Tab(
                        text: "حساب جديد",
                      ),
                    ],
                    labelStyle: Theme.of(context).textTheme.subtitle1,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 6.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                Expanded(
                  child: Container(
                    child:
                        TabBarView(children: [SigninScreen(), SignupScreen()]),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
