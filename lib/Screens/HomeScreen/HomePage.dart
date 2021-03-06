import 'dart:io';
import 'dart:typed_data';

import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/ChoiseCoinCard.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/BankPrices/BankPricesBloc.dart';
import 'package:bkamalyoum/Screens/Menu/MenuScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BankPrices/BankPricesScreen.dart';
import '../ExpectPrices/ExpectPricesScreen.dart';
import '../GoldPrices/GoldPricesScreen.dart';
import '../MarketPrices/MarketPricesScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Splash/PushNotification.dart';
import 'Currency/CurrencyBloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  // final currency_bloc = CurrencyBloc();
  // final BankPricesBloc bankPricesBloc = BankPricesBloc();

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  Color selectedItemColor;
  Color unselectedItemColor;
  Color selectedBgColor;
  Color unselectedBgColor;
  int _selectedIndex = 0;

  // final widgetOptions = [
  //   BankPricesScreen(),
  //   MarketPricesScreen(),
  //   ExpectPricesScreen(),
  //   GoldPricesScreen(),
  //   MenuScreen(),
  // ];
  final key = GlobalKey();

  @override
  Widget build(BuildContext mContext) {
    initFCMNotifications();

    selectedItemColor = Colors.white;
    unselectedItemColor = Colors.white;
    selectedBgColor = Theme.of(context).primaryColor;
    unselectedBgColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: key,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: Text(
      //     '???????? ????????????',
      //     style: TextStyle(fontFamily: 'Lalezar'),
      //   ),
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     _imageFileScreenShot != null
      //         ? Image.memory(_imageFileScreenShot)
      //         : Container(),
      //     Container(
      //         padding: EdgeInsets.only(right: 20.0, left: 20.0),
      //         child: GestureDetector(
      //           onTap: () {},
      //           child: SvgPicture.asset(
      //             'assets/images/refersh.svg',
      //             width: 82.sp,
      //             height: 85.sp,
      //             fit: BoxFit.contain,
      //           ),
      //         )),
      //     Container(
      //         padding: EdgeInsets.only(right: 12),
      //         child: GestureDetector(
      //           onTap: () {
      //             screenshotController
      //                 .capture(pixelRatio: 1.5)
      //                 .then((Uint8List image) {
      //               //Capture Done
      //               setState(() {
      //                 _imageFileScreenShot = image;
      //                 _imageFile = File.fromRawPath(_imageFileScreenShot);
      //                 _shareImage(_imageFileScreenShot);
      //               });
      //             }).catchError((onError) {
      //               print(onError);
      //             });
      //
      //             // final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
      //             // String fileName = DateTime.now().microsecondsSinceEpoch;
      //             // String path = '$directory';
      //             //
      //             // screenshotController.captureAndSave(
      //             // path //set path where screenshot will be saved
      //             // fileName:fileName
      //             // );
      //           },
      //           child: SvgPicture.asset(
      //             'assets/images/camera.svg',
      //             width: 107.sp,
      //             height: 77.sp,
      //             fit: BoxFit.contain,
      //           ),
      //         )),
      //     PopupMenuButton(
      //       icon: SvgPicture.asset(
      //         'assets/images/choiseCoin.svg',
      //         width: 131.sp,
      //         height: 85.sp,
      //         fit: BoxFit.contain,
      //       ),
      //       itemBuilder: (context) {
      //         return [
      //           PopupMenuItem<int>(
      //             value: 0,
      //             child: Column(
      //               children: [
      //                 Container(
      //                     margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
      //                     child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Container(
      //                             width: 145.71.sp,
      //                             height: 76.72.sp,
      //                             child: SvgPicture.asset(
      //                               'assets/images/coin.svg',
      //                             ),
      //                           ),
      //                           TextTitle('???????? ????????????',
      //                               Theme.of(context).textTheme.subtitle2),
      //                         ])),
      //                 Divider(
      //                   color: Theme.of(context).primaryColor,
      //                   thickness: 2,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           PopupMenuItem<int>(
      //             value: 1,
      //             child: Container(
      //               // height: 663.14.sp, // Change as per your requirement
      //               width: 1141.32.sp, // Change as per your requirement
      //               child: BlocProvider<CurrencyBloc>(
      //                 create: (context) =>
      //                     currency_bloc..add(LoadCurrencyEvent()),
      //                 child: BlocBuilder<CurrencyBloc, CurrencyState>(
      //                     builder: (context, state) {
      //                   if (state is LoadingCurrencyState) {
      //                     return Center(
      //                       child: Container(
      //                         padding: EdgeInsets.all(48.0.sp),
      //                         child: showProgressLoading(),
      //                       ),
      //                     );
      //                   } else if (state is LoadedCurrencyState) {
      //                     return ListView.builder(
      //                       shrinkWrap: true,
      //                       itemExtent: 42.0,
      //                       itemCount:
      //                           state.response.ebody?.current?.length ?? 0,
      //                       itemBuilder: (context, index) => Container(
      //                         //padding: EdgeInsets.all(2.0),
      //                         child: Material(
      //                           elevation: 2.0,
      //                           //borderRadius: BorderRadius.circular(5.0),F2F8F8
      //                           color: index % 2 == 0
      //                               ? Theme.of(context).primaryColorLight
      //                               : Colors.white,
      //                           child: ChoiseCoinCard(
      //                             state.response.ebody?.current[index].image ??
      //                                 '',
      //                             state.response.ebody?.current[index].nameAr,
      //                             state.response.ebody?.current[index].nameEn,
      //                             onPressed: () {
      //                               SelectedCurrency(state
      //                                   .response.ebody?.current[index].id);
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                     );
      //                   } else if (state is FailedCurrencyState) {
      //                     return TextTitle(
      //                         '', Theme.of(context).textTheme.subtitle1);
      //                   } else {
      //                     return TextTitle(
      //                         '', Theme.of(context).textTheme.subtitle1);
      //                   }
      //                 }),
      //               ),
      //             ),
      //           ),
      //         ];
      //       },
      //       onSelected: (value) {
      //         if (value == 0) {
      //           // print("My account menu is selected.");
      //         } else if (value == 1) {
      //           // print("Settings menu is selected.");
      //         }
      //       },
      //     ),
      //     SizedBox(width: 12.0)
      //   ],
      // ),
      body: Screenshot(
        controller: screenshotController,
        child: Center(
          child: [
            BankPricesScreen(),
            MarketPricesScreen(),
            ExpectPricesScreen(),
            GoldPricesScreen(),
            MenuScreen(),
          ].elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: unselectedBgColor,
        type: BottomNavigationBarType.fixed,
        // Fixed
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/bankPrices.svg', '?????????? ?????????????? \n??????????????', 0),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/marketPrice.svg', '?????????? ??????????????\n ????????????', 1),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/expectPrices.svg', '???????? ??????????\n ??????????????', 2),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/goldandSelver.svg', '?????????? ??????????\n ????????????', 3),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/more.svg', '????????????', 4),
            title: SizedBox.shrink(),
          ),
        ],
        elevation: 0,
        //         currentIndex: _selectedIndex,
        //         selectedItemColor: selectedItemColor,
        //         unselectedItemColor: unselectedItemColor,
        //         //  backgroundColor: Colors.teal,
        //         //  fixedColor: Colors.white,
        // // selectedItemColor: Colors.amber,
        // unselectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  Color _getBgColor(int index) =>
      _selectedIndex == index ? selectedBgColor : unselectedBgColor;

  Color _getItemColor(int index) =>
      _selectedIndex == index ? selectedItemColor : unselectedItemColor;

  Widget _buildIcon(String icon, String text, int index,
          {bool isSelected = false}) =>
      Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 28.0,
                  height: 28.0,
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
                Text(text,
                    style: TextStyle(
                        fontSize: 8,
                        color: _getItemColor(index),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            //onTap: () => _onItemTapped(index),
          ),
        ),
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('INDEX :::  ${index}');
    });
  }

  _shareImage(Uint8List uint8list) async {
    try {
      // final ByteData bytes = await rootBundle.load('assets/image.jpg');
      // final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(uint8list);

      final channel = const MethodChannel('channel:me.albie.share/share');
      channel.invokeMethod('shareFile', 'image.jpg');
    } catch (e) {
      print('Share error: $e');
    }
  }

  // FCM Notifications
  FirebaseMessaging _messaging;

  void initFCMNotifications() {
    if (_messaging != null) {
      return;
    }
    registerNotification();
    // checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('FirebaseMessaging : OpenedApp');

      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    await subscribeAllChannels();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    String token = await _messaging.getToken();
    prefs.setString('FCM_DEVICE_TOKEN', token);

    _messaging.onTokenRefresh.listen((newToken) async {
      prefs.setString('FCM_DEVICE_TOKEN', token);
    });

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
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  void fcmSubscribe(String TopicToListen) {
    firebaseMessaging.subscribeToTopic(TopicToListen);
  }

  void fcmUnSubscribe(String TopicToListen) {
    firebaseMessaging.unsubscribeFromTopic(TopicToListen);
  }

  Future<void> subscribeAllChannels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    firebaseMessaging.subscribeToTopic('Public');
    firebaseMessaging.subscribeToTopic('NotificationSound');

    prefs.setBool('Public', true);
    prefs.setBool('NotificationSound', true);

    // if first time subscribe to these
    if (prefs.getBool('NewsTopic') == null) {
      firebaseMessaging.subscribeToTopic('NewsTopic');
      prefs.setBool('NewsTopic', true);
    }
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
