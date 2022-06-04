import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Component/switchWithText.dart';
import 'package:bkamalyoum/Screens/GoldPrices/GoldPricesBloc.dart';
import 'package:bkamalyoum/Screens/GoldPrices/metal_prices_response.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/CurrencyBloc.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const SettingScreen({Key key, this.prefs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _settingScreenState();
  }
}

class _settingScreenState extends State<SettingScreen> {
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final CurrencyBloc currency_bloc = CurrencyBloc();
  final GoldPricesBloc gold_bloc = GoldPricesBloc();
  List<Current> currentCurrenciesList;
  List<MetalCategoryModel> metalCategoryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    subscribeAllChannels();
  }

  @override
  Widget build(BuildContext mContext) {
    // bool NotificationsSound = true;
    // bool NotificationsMetals = true;
    // bool NotificationsNews = true;

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(mContext).primaryColor,
          title: Text(
            'بكام اليوم؟',
            style: TextStyle(fontFamily: 'Lalezar'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(mContext).pop(),
          ),
        ),
        body: Column(
          children: [
            TextTitle(
              'الإعدادات',
              Theme.of(context).textTheme.subtitle2,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              color: Theme.of(context).primaryColorLight,
              child: TextTitle(
                'الإعدادات',
                Theme.of(context).textTheme.headline2,
              ),
            ),
            switchWithText(
              "صوت الاشعارات",
              widget.prefs?.getBool('NotificationSound') ?? false,
              (val) {
                setState(() {
                  widget.prefs.setBool('NotificationSound', val);
                });

                if (val) {
                  fcmSubscribe('NotificationSound');
                } else {
                  fcmUnSubscribe('NotificationSound');
                }
              },
            ),
            switchWithText(
              "إشعارات أهم الأخبار",
              widget.prefs?.getBool('NewsTopic') ?? false,
              (val) {
                setState(() {
                  widget.prefs.setBool('NewsTopic', val);
                });

                if (val) {
                  fcmSubscribe('NewsTopic');
                } else {
                  fcmUnSubscribe('NewsTopic');
                }
              },
            ),
            // switchWithText("إشعارات أسعار الذهب",
            //     widget.prefs?.getBool('MetalNotifications') ?? false, (val) {
            //   setState(() {
            //     widget.prefs.setBool('MetalNotifications', val);
            //   });
            // }),

            SizedBox(height: 48.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              color: Theme.of(context).primaryColorLight,
              child: TextTitle(
                'إشعارات الذهب والفضة',
                Theme.of(context).textTheme.headline2,
              ),
            ),
            BlocProvider<GoldPricesBloc>(
              create: (context) => gold_bloc..add(LoadMetalPricesEvent()),
              child: BlocBuilder<GoldPricesBloc, MetalPricesState>(
                  builder: (context, state) {
                if (state is LoadingMetalPricesState) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(124.0.sp),
                      child: showProgressLoading(),
                    ),
                  );
                } else if (state is LoadedMetalPricesState) {
                  metalCategoryList = state.response?.ebody ?? [];
                  return ListView.builder(
                    // itemExtent: 42.0,
                    itemCount: metalCategoryList?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      child: switchWithText(
                        metalCategoryList[index].nameAr,
                        widget.prefs?.getBool('MetalCategory' +
                                metalCategoryList[index].id.toString()) ??
                            false,
                        (val) async {
                          metalCategoryList[index].isSubscribed = val;

                          setState(() {
                            widget.prefs.setBool(
                                'MetalCategory' +
                                    metalCategoryList[index].id.toString(),
                                val);
                          });
                          // int id = prefs.getInt('LastSelectedCurrencyId');

                          if (val) {
                            fcmSubscribe('MetalCategory' +
                                metalCategoryList[index].id.toString());
                          } else {
                            fcmUnSubscribe('MetalCategory' +
                                metalCategoryList[index].id.toString());
                          }
                        },
                      ),
                    ),
                  );
                } else if (state is FailedMetalPricesState) {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                } else {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                }
              }),
            ),
            SizedBox(height: 48.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              color: Theme.of(context).primaryColorLight,
              child: TextTitle(
                'إشعارات العملات',
                Theme.of(context).textTheme.headline2,
              ),
            ),

            BlocProvider<CurrencyBloc>(
              create: (context) => currency_bloc..add(LoadCurrencyEvent()),
              child: BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                if (state is LoadingCurrencyState) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(48.0.sp),
                      child: showProgressLoading(),
                    ),
                  );
                } else if (state is LoadedCurrencyState) {
                  currentCurrenciesList = state.response?.ebody?.current ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 42.0,
                    itemCount: currentCurrenciesList.length,
                    itemBuilder: (context, index) => Container(
                      //padding: EdgeInsets.all(2.0),

                      child: switchWithText(
                        currentCurrenciesList[index].nameAr,
                        widget.prefs?.getBool('Currency' +
                                currentCurrenciesList[index].id.toString()) ??
                            false,
                        (val) async {
                          currentCurrenciesList[index].isSubscribed = val;

                          setState(() {
                            widget.prefs.setBool(
                                'Currency' +
                                    currentCurrenciesList[index].id.toString(),
                                val);
                          });

                          if (val) {
                            fcmSubscribe('Currency' +
                                currentCurrenciesList[index].id.toString());
                          } else {
                            fcmUnSubscribe('Currency' +
                                currentCurrenciesList[index].id.toString());
                          }
                          // int id = prefs.getInt('LastSelectedCurrencyId');
                        },
                      ),
                    ),
                  );
                } else if (state is FailedCurrencyState) {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                } else {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                }
              }),
            ),
          ],
        ));
  }

  void fcmSubscribe(String TopicToListen) {
    firebaseMessaging.subscribeToTopic(TopicToListen);
  }

  void fcmUnSubscribe(String TopicToListen) {
    firebaseMessaging.unsubscribeFromTopic(TopicToListen);
  }

  void subscribeAllChannels() {
    fcmSubscribe('Public');
    fcmSubscribe('NotificationSound');
    fcmSubscribe('NewsTopic');

    widget.prefs.setBool('Public', true);
    widget.prefs.setBool('NotificationSound', true);
    widget.prefs.setBool('NewsTopic', true);

    //TODO:  Subscribe to Metals and Currencies
  }
}
