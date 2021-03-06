import 'dart:io';

import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/ConfirmationPopUp.dart';
import 'package:bkamalyoum/Component/MenuCard.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/Auth/AuthScreen.dart';
import 'package:bkamalyoum/Screens/ConfirmPhoneNumber/ConfirmPhoneNumberScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Auth/AuthScreen.dart';
import 'MenuBloc.dart';
import 'News/NewsScreen.dart';
import 'PrivacyPolicy/PrivacyPolicyScreen.dart';
import 'Setting/SettingScreen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  final MenuBloc bloc = MenuBloc();

  @override
  Widget build(BuildContext mContext) {
    return BlocProvider<MenuBloc>(
      create: (context) => bloc..add(LoadMenuEvent()),
      child: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
        if (state is LoadedMenuState) {
          return screenContent(mContext, prefs: state.prefs);
        } else {
          return SizedBox();
        }
      }),
    );
  }

  Widget screenContent(BuildContext mContext, {SharedPreferences prefs}) {
    return Scaffold(
      appBar: AppBarCustom(
        mContext: mContext,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 50.sp),
          ((prefs?.getString('accessToken') ?? '').isNotEmpty)
              ? Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextTitle(
                          ' ${(prefs?.getString('UserName') ?? '')} ??????????',
                          Theme.of(mContext).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          MenuCard('?????? ??????????????', 'assets/images/news.svg', () {
            Navigator.push(
              mContext,
              MaterialPageRoute(builder: (context) => NewsScreen()),
            );
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          MenuCard('???????? ??????', 'assets/images/call_us.svg', () async {
            const number = '+201069761802';
            // bool res = await FlutterPhoneDirectCaller.callNumber(number);
            UrlLauncher.launch("tel://${number}");
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          MenuCard('?????? ??????????????', 'assets/images/rate_app.svg', () {
            // rateTheApp(mContext);
            openRateApp();
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          MenuCard('???????? ??????????????', 'assets/images/share_app.svg', () {
            shareAppUrl('https://flutter.dev/');
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          MenuCard('??????????????????', 'assets/images/setting.svg', () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            Navigator.push(
              mContext,
              MaterialPageRoute(
                  builder: (context) => SettingScreen(prefs: prefs)),
            );
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          MenuCard('Privacy Policy', 'assets/images/privacyandpolicy.svg', () {
            Navigator.push(
              mContext,
              MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
            );
          }),
          Divider(
            color: Theme.of(mContext).dividerColor,
            thickness: 1,
          ),
          ((prefs?.getString('accessToken') ?? '').isNotEmpty)
              ? MenuCard('?????????? ????????', 'assets/images/logo.svg', () {
                  showDialog(
                      context: mContext,
                      builder: (BuildContext context) =>
                          ConfirmationPopUp('?????????? ????????', () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.setString('token_type', '');
                            prefs.setString('accessToken', '');
                            prefs.setString('refreshToken', '');

                            bloc..add(LoadMenuEvent());
                            Navigator.pop(mContext);
                          }));
                })
              : MenuCard('?????????? ????????', 'assets/images/logo.svg', () {
                  Navigator.push(
                    mContext,
                    MaterialPageRoute(
                        builder: (context) => AuthScreen(
                              bloc: bloc,
                              // phone_number: '123456789',
                            )),
                  );
                }),
        ],
      ),
    );
  }

  void openRateApp() {
    if (Platform.isAndroid) {
      openAppAndroid();
    } else if (Platform.isIOS) {
      openAppIOS();
    }
  }

  void openAppIOS() {}

  void openAppAndroid() {
    String appPackageName = 'com.bkamalyoum.bkamalyoum';
    try {
      launch("market://details?id=" + appPackageName);
    } on PlatformException catch (e) {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    } finally {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    }
  }

  Future<void> shareAppUrl(String appUrl) async {
    await FlutterShare.share(
        title: '???????? ??????????????',
        text: '???????? ?????????????? ???? ??????????????',
        linkUrl: appUrl,
        chooserTitle: 'Example Chooser Title');
  }

  rateTheApp(BuildContext context) {
    // In this snippet, I'm giving a value to all parameters.
    // Please note that not all are required (those that are required are marked with the @required annotation).

    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 7,
      minLaunches: 10,
      remindDays: 7,
      remindLaunches: 10,
      googlePlayIdentifier: 'com.bkamalyoum.bkamalyoum',
      appStoreIdentifier: '1491556149',
    );

    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this app',
          // The dialog title.
          message:
              'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
          // The dialog message.
          rateButton: 'RATE',
          // The dialog "rate" button text.
          noButton: 'NO THANKS',
          // The dialog "no" button text.
          laterButton: 'MAYBE LATER',
          // The dialog "later" button text.
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreNativeDialog: Platform.isAndroid,
          // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle(),
          // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );

        // Or if you prefer to show a star rating bar :

        rateMyApp.showStarRateDialog(
          context,
          title: 'Rate this app',
          // The dialog title.
          message:
              'You like this app ? Then take a little bit of your time to leave a rating :',
          // The dialog message.
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          actionsBuilder: (context, stars) {
            // Triggered when the user updates the star rating.
            return [
              // Return a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  print('Thanks for the ' +
                      (stars == null ? '0' : stars.round().toString()) +
                      ' star(s) !');
                  // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                  // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                  await rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(
                      context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
          ignoreNativeDialog: Platform.isAndroid,
          // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle(
            // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          starRatingOptions: StarRatingOptions(),
          // Custom star bar rating options.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      }
    });
  }
}
