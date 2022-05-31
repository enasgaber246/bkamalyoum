import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/HomeScreen/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';

import 'PushNotification.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splashState();
  }
}

class _splashState extends State<Splash> {
  FirebaseMessaging _messaging;

  @override
  void initState() {
    registerNotification();
    checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('FirebaseMessaging : OpenedApp');

      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });

    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String imgUrl = 'assets/images/splash.svg';
    String imgUrlLogo = 'assets/images/logo.svg';
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        SvgPicture.asset(
          'assets/images/splash.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 659.47.sp,
                width: 575.01.sp,
                child: SvgPicture.asset(
                  imgUrlLogo,
                ),
              ),
            ),
            Center(
                child: TextTitle(
              'بكام اليوم؟',
              Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            )),
            Container(
                margin: EdgeInsets.only(top: 400.sp),
                child: TextTitle(
                  'الأسعار اللحظية لجميع العملات\n في البنوك والأسواق السودانية',
                  Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                )),
          ],
        )
      ],
    ));
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    String token = await _messaging.getToken();

    print('FirebaseMessaging : Token ${token}');

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('FirebaseMessaging : OnMessage');

        // _showNotification();

        showSimpleNotification(
          Row(
            children: [
              Center(
                child: Container(
                  height: 148.sp,
                  width: 148.sp,
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextTitle(
                    message.notification?.title ?? '-',
                    Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  TextTitle(
                    message.notification?.body ?? '-',
                    Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          background: Theme.of(context).primaryColorLight,
          duration: Duration(seconds: 30),
        );

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          // _notificationInfo = notification;
          // _totalNotifications++;
        });
      });
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

// For handling notification when the app is in terminated state
Future checkForInitialMessage() async {
  await Firebase.initializeApp();
  RemoteMessage initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notification = PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
    );
    // setState(() {
    //   _notificationInfo = notification;
    //   _totalNotifications++;
    // });
  }
}
