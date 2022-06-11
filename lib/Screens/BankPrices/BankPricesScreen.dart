import 'dart:io';
import 'dart:typed_data';

import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/CardContentTitle.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/InputDataWidget.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:link/link.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BankPriceDetails.dart';
import 'BankPricesBloc.dart';
import 'BankPricesBloc.dart';
import 'BankPricesResponse.dart';

class BankPricesScreen extends StatefulWidget {
  static Current selectedCurrency;

  @override
  _BankPricesScreenState createState() => _BankPricesScreenState();
}

class _BankPricesScreenState extends State<BankPricesScreen> {
  final BankPricesBloc bankPricesBloc = BankPricesBloc();

  // ScreenShot
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imageFileScreenShot;

  String getDateFormatted() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM  hh:mm a', 'ar');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  int arrangeType = 0;

  @override
  Widget build(BuildContext mContext) {
    initializeDateFormatting('ar');

    return Scaffold(
      appBar: AppBarCustom(
        mContext: mContext,
        automaticallyImplyLeading: false,
        onTapCamera: () async {
          screenshotController
              .capture(pixelRatio: 1.5)
              .then((Uint8List image) async {
            //Capture Done
            _imageFileScreenShot = image;
            await Share.file('بكام اليوم', 'bkamelyoum.jpg',
                _imageFileScreenShot, 'image/jpg');
          }).catchError((onError) {
            print(onError);
          });
        },
        onSelectCurrency: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          int id = prefs.getInt('LastSelectedCurrencyId');
          bankPricesBloc.add(LoadBankPricesEvent(id: id));

          Navigator.pop(mContext);
        },
        onReloadTap: () async {
          bankPricesBloc.add(LoadBankPricesEvent());
        },
      ),
      body: Screenshot(
        controller: screenshotController,
        child: BlocProvider<BankPricesBloc>(
          create: (context) => bankPricesBloc..add(LoadBankPricesEvent()),
          child: BlocBuilder<BankPricesBloc, BankPricesState>(
              builder: (context, state) {
            if (state is LoadingBankPricesState) {
              return Container(
                padding: EdgeInsets.all(148.0.sp),
                child: Center(child: showProgressLoading()),
              );
            } else if (state is LoadedBankPricesState) {
              return Column(
                children: [
                  // _imageFileScreenShot != null
                  //     ? Image.memory(
                  //         _imageFileScreenShot,
                  //         height: 300.sp,
                  //       )
                  //     : Container(
                  //         height: 120.sp,
                  //         color: Colors.grey,
                  //       ),
                  TextTitle(
                    ' تحديث ${getDateFormatted()}',
                    Theme.of(context).textTheme.subtitle1,
                  ),
                  Divider(
                    color: Colors.black26,
                  ),
                  (state.response?.ebody ?? []).isNotEmpty
                      ? CardContentTitle(
                          (BankPricesScreen.selectedCurrency?.nameEn ??
                                  (state.response?.ebody[0]?.currencyName ??
                                      '')) +
                              '  ' +
                              (BankPricesScreen.selectedCurrency?.nameAr ??
                                  (state.response?.ebody[0]?.currencyNameAr ??
                                      '') ??
                                  ''),
                          'شراء',
                          'بيع',
                          Theme.of(context).textTheme.subtitle1,
                          networkUrl:
                              BankPricesScreen.selectedCurrency?.image ??
                                  state.response?.ebody[0]?.currencyImage ??
                                  '',
                          onClickBuyBtn: () {
                            if (arrangeType == 3 ||
                                arrangeType == 4 ||
                                arrangeType == 2) {
                              arrangeType = 1;
                            } else {
                              arrangeType = 2;
                            }
                            bankPricesBloc
                                .add(RearrangeBankPricesEvent(id: arrangeType));
                          },
                          onClickSellBtn: () {
                            if (arrangeType == 1 ||
                                arrangeType == 2 ||
                                arrangeType == 4) {
                              arrangeType = 3;
                            } else {
                              arrangeType = 4;
                            }
                            bankPricesBloc
                                .add(RearrangeBankPricesEvent(id: arrangeType));
                          },
                          arrangeType: arrangeType,
                        )
                      : SizedBox(),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemExtent: 42.0,
                        itemCount: state.response.ebody.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              child: Container(
                                //padding: EdgeInsets.all(2.0),
                                child: Material(
                                  elevation: 2.0,
                                  //borderRadius: BorderRadius.circular(5.0),F2F8F8
                                  color: (state.response.ebody[index]
                                              .is_special ==
                                          '1')
                                      ? Color(0xFFFDF5D2)
                                      : ((index % 2 == 0)
                                          ? Theme.of(context).primaryColorLight
                                          : Colors.white),
                                  child: BankPricesCard(
                                    state.response.ebody[index],
                                    Theme.of(context).textTheme.subtitle1,
                                    state.prefs,
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      BankPriceDetails(
                                    context: context,
                                    model: state.response.ebody[index],
                                    currency: (BankPricesScreen
                                                .selectedCurrency?.nameEn ??
                                            (state.response?.ebody[0]
                                                    ?.currencyName ??
                                                '')) +
                                        ' ' +
                                        (BankPricesScreen
                                                .selectedCurrency?.nameAr ??
                                            (state.response?.ebody[0]
                                                    ?.currencyNameAr ??
                                                '') ??
                                            ''),
                                    currencyImage: BankPricesScreen
                                            .selectedCurrency?.image ??
                                        state.response?.ebody[0]
                                            ?.currencyImage ??
                                        '',
                                    prefs: state.prefs,
                                    currency_id:
                                        state.response?.ebody[0]?.currencyId ??
                                            '',
                                  ),
                                );
                              },
                            )),
                  )
                ],
              );
            } else if (state is FailedBankPricesState) {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            } else {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            }
          }),
        ),
      ),
    );
  }
}
