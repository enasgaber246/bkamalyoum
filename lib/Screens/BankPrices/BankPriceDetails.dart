import 'package:bkamalyoum/Component/InputDataWidget.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:link/link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'BankPricesResponse.dart';
import 'BankPricesScreen.dart';

class BankPriceDetails extends StatefulWidget {
  final SharedPreferences prefs;
  final BuildContext context;
  final BankPriceModel model;
  final String currency_id;
  final String currency;
  final String currencyImage;

  const BankPriceDetails({
    Key key,
    this.context,
    this.model,
    this.currency,
    this.currencyImage,
    this.prefs,
    this.currency_id,
  }) : super(key: key);

  @override
  _BankPriceDetailsState createState() => _BankPriceDetailsState(
      context: context,
      model: model,
      currency: currency,
      currencyImage: currencyImage,
      currency_id: currency_id);
}

class _BankPriceDetailsState extends State<BankPriceDetails> {
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  final BuildContext context;
  final BankPriceModel model;
  final String currency_id;

  final String currency;
  final String currencyImage;
  final priceCtrl = TextEditingController(text: '1');

  // priceCtrl.text = '1';
  String currentCurrencyPrice;

  NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

  _BankPriceDetailsState(
      {this.context,
      this.model,
      this.currency,
      this.currencyImage,
      this.currency_id});

  @override
  Widget build(BuildContext context) {
    // String currentCurrencyPrice = model.buyingPrice;

    DateTime parseDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(model.lastUpdate);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MMM hh:mm aa', 'ar');
    var outputDate = outputFormat.format(inputDate);

    return new AlertDialog(
      contentPadding: EdgeInsets.all(32.sp),
      // insetPadding: EdgeInsets.all(24.sp),
      // title: const Text('Popup example'),
      content: new SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextTitle(
                      (model.nameAr ?? '-'),
                      Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 50.sp),
                    // Container(
                    //   width: 145.71.sp,
                    //   height: 76.72.sp,
                    //   child: SvgPicture.asset(
                    //     IconPath,
                    //   ),
                    // ),
                    (model.image == null)
                        ? SizedBox(
                            width: 124.sp,
                            height: 124.sp,
                          )
                        : Container(
                            width: 124.sp,
                            height: 124.sp,
                            padding: EdgeInsets.all(5.0.sp),
                            child: Image.network(
                              'https://bkamalyoum.com/uploads/small/${model.image}',
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                )),
            SizedBox(height: 30.0.sp),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextTitle(
                      currency,
                      Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(
                      width: 50.sp,
                    ),
                    // Container(
                    //   width: 145.71.sp,
                    //   height: 76.72.sp,
                    //   child: SvgPicture.asset(
                    //     IconPath,
                    //   ),
                    // ),
                    (currencyImage == null)
                        ? SizedBox(
                            width: 124.sp,
                            height: 124.sp,
                          )
                        : Container(
                            width: 124.sp,
                            height: 124.sp,
                            padding: EdgeInsets.all(5.0.sp),
                            child: Image.network(
                              'https://bkamalyoum.com/uploads/small/${currencyImage}',
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                )),
            SizedBox(height: 30.0.sp),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                    child: Switch(
                      value: widget.prefs?.getBool('Currency' +
                          currency_id) ??
                          false,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveThumbColor: Colors.black12,
                      onChanged: (bool val) {

                        setState(() {
                          widget.prefs.setBool(
                              'Currency' +
                                  currency_id,
                              val);
                        });

                        if (val) {
                          fcmSubscribe('Currency' +
                              currency_id);
                        } else {
                          fcmUnSubscribe('Currency' +
                              currency_id);
                        }
                      },
                    ),
                  ),
                  TextTitle(
                      ' :  الإشعارات', Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            SizedBox(height: 48.0.sp),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InputDataWidget(
                    controller: priceCtrl,
                    width: 600.0,
                    height: 224.0,
                    maxLength: 7,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (priceCtrl.text.isEmpty) {
                        currentCurrencyPrice =
                            (double.parse(model.buyingPrice) ?? 0).toString();
                        setState(() {});
                        return;
                      }
                      double price = 0.0;

                      // if (dropDownTypeBuySell.dropdownvalue.index == 0) {
                      //   // Buying
                      price = (double.parse(model.buyingPrice) ?? 0);
                      // } else {
                      //   // Selling
                      //   price = (double.parse(model.sellingPrice) ?? 0);
                      // }

                      double enteredValue = double?.parse(value) ?? 1;
                      double finalValue = (enteredValue ?? 1) * price;

                      print('finalPriceValue :  ${finalValue.toString()}');

                      currentCurrencyPrice = finalValue.toString();
                      setState(() {});
                    },
                  ),
                  SizedBox(width: 56.sp),
                  TextTitle(':  المبلغ', Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            SizedBox(height: 78.0.sp),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextTitle(
                      'جنيه سوداني', Theme.of(context).textTheme.subtitle1),
                  SizedBox(width: 12.0.sp),
                  TextTitle(
                      numberFormat.format(double.parse(
                              '${currentCurrencyPrice ?? model?.buyingPrice ?? ''} ')) ??
                          '-',
                      Theme.of(context).textTheme.headline2),
                  SizedBox(width: 12.0.sp),
                  TextTitle(
                      ' :  سعر الشراء', Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            SizedBox(height: 30.0.sp),
            // Container(
            // margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       TextTitle('  جنيه سوداني ',
            //           Theme.of(context).textTheme.subtitle1),
            //       TextTitle('${model.sellingPrice ?? ''} ',
            //           Theme.of(context).textTheme.subtitle1),
            //       TextTitle(
            //           ' :  سعر البيع ', Theme.of(context).textTheme.subtitle1),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.all(30.0.sp),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       TextTitle(' ٢ يونيو١٢:١٤ م  ',
            //           Theme.of(context).textTheme.subtitle1),
            //       TextTitle(' :  اخر تعديل بالبنك',
            //           Theme.of(context).textTheme.subtitle1),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextTitle(outputDate, Theme.of(context).textTheme.subtitle1),
                  TextTitle(':  تاريخ اخر تحديث',
                      Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            SizedBox(height: 30.0.sp),
            (model.hotLine ?? '').isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.phone_in_talk_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          iconSize: 24,
                          onPressed: () {
                            UrlLauncher.launch("tel://${model.hotLine ?? ''}");
                          },
                        ),
                        TextTitle(model.hotLine ?? '',
                            Theme.of(context).textTheme.subtitle1),
                        TextTitle('  : الخط الساخن  ',
                            Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 30.0.sp),
            (model.webUrl ?? '').isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Link(
                          child: Text('تصفح الموقع الالكتروني',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 50.sp,
                                  color: Theme.of(context).primaryColor
                                  // add add underline in text
                                  )),
                          url: model.webUrl ?? '',
                          //onError: _showErrorSnackBar,
                        ),
                        TextTitle(':  الموقع الالكتروني ',
                            Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  )
                : SizedBox(),
            // SizedBox(height:  30.0.sp),
            // Btn(
            //   'عرض الرسم البياني',
            //   height: 600.sp,
            //   fontSize: 55,
            // )
          ],
        ),
      ),
    );
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
