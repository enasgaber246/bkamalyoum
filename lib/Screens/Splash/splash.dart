import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/HomeScreen/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PushNotification.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splashState();
  }
}

class _splashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController motionController;
  Animation motionAnimation;
  double size = 20;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
    });

    motionController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        size = motionController.value * 250;
      });
    });
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String imgUrl = 'assets/images/splash.svg';
    String imgUrlLogo = 'assets/images/logo.svg';
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Stack(children: <Widget>[
                    Center(
                        child: Container(
                      height: size,
                      width: 575.01.sp,
                      child: SvgPicture.asset(
                        imgUrlLogo,
                      ),
                    )),
                  ]),
                  height: 200,
                ),

                Container(
                  child: Stack(children: <Widget>[
                    Center(
                        child: Container(
                            height: size,
                            //width: 575.01.sp,
                            child: TextTitle(
                              'بكام اليوم؟',
                              Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                              horizontal: 0.0,
                              vertical: 0.0,
                            ))),
                  ]),
                  height: 200,
                ),
                // Center(
                //   child: Container(
                //     height: 659.47.sp,
                //     width: 575.01.sp,
                //     child: SvgPicture.asset(
                //       imgUrlLogo,
                //     ),
                //   ),
                // ),
                // Container(
                //     child: TextTitle(
                //   'بكام اليوم؟',
                //   Theme.of(context).textTheme.headline1,
                //   textAlign: TextAlign.center,
                //   horizontal: 0.0,
                //   vertical: 0.0,
                // )),
                Container(
                    margin: EdgeInsets.only(top: 500.sp),
                    child: TextTitle(
                      'الأسعار اللحظية لجميع العملات\n في البنوك والأسواق السودانية',
                      Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    )),
              ],
            )));
  }
}
