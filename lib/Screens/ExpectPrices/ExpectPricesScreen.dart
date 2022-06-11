import 'dart:convert';

import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/DropDown.dart';
import 'package:bkamalyoum/Component/DropDownCurrency.dart';
import 'package:bkamalyoum/Component/DropDownModel.dart';
import 'package:bkamalyoum/Component/InputDataWidget.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Component/TextWithDot.dart';
import 'package:bkamalyoum/Screens/Auth/AuthScreen.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/CurrencyBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'send_expectation_response.dart';

class ExpectPricesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpectPricesScreenState();
  }
}

class ExpectPricesScreenState extends State<ExpectPricesScreen> {
  final _formKey = GlobalKey<FormState>();

  final priceExpectedCtrl = TextEditingController();
  final changePercentageCtrl = TextEditingController();

  final currency_bloc = CurrencyBloc();

  DropDownCurrency dropDownCurrency;
  DropDown dropDownTypeBuySell = DropDown([
    DropDownModel('شراء', 0),
    DropDownModel('بيع', 1),
  ]);
  DropDown dropDownUpOrDown = DropDown([
    DropDownModel('صعود', 0),
    DropDownModel('هبوط', 1),
  ]);

  List<String> dropdownItem = [];

  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      appBar: AppBarCustom(
        mContext: mContext,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(50.0.sp),
                alignment: Alignment.centerRight,
                child: TextTitle('ادخل توقعك للاسعار',
                    Theme.of(context).textTheme.subtitle2),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 2,
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.all(50.0.sp),
                child: Column(
                  children: [
                    TextWithDot(
                        'اختر العمله', Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 50.0.sp),
                    BlocProvider<CurrencyBloc>(
                      create: (context) =>
                          currency_bloc..add(LoadCurrencyEvent()),
                      child: BlocBuilder<CurrencyBloc, CurrencyState>(
                          builder: (context, state) {
                        if (state is LoadingCurrencyState) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 48.0.sp),
                              child: showProgressLoading(),
                            ),
                          );
                        } else if (state is LoadedCurrencyState) {
                          // for (int i = 0;
                          //     i < state.response.ebody.current.length;
                          //     i++) {
                          //   dropdownItem.add(state.response.ebody.current[i].nameAr);
                          // }
                          dropDownCurrency = DropDownCurrency(
                              state.response?.ebody?.current ?? []);
                          return dropDownCurrency;
                        } else if (state is FailedCurrencyState) {
                          return TextTitle(
                              '', Theme.of(context).textTheme.subtitle1);
                        } else {
                          return TextTitle(
                              '', Theme.of(context).textTheme.subtitle1);
                        }
                      }),
                    ),
                    SizedBox(height: 110.0.sp),
                    TextWithDot(
                        'نوع العملية', Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 50.0.sp),
                    dropDownTypeBuySell,
                    SizedBox(height: 110.0.sp),
                    TextWithDot('ما هو توقعك لسعر العملة بالسوق صعود ام هبوط؟',
                        Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 50.0.sp),
                    dropDownUpOrDown,
                    SizedBox(height: 110.0.sp),
                    TextWithDot('ادخل توقعك لسعر العملة بالسوق',
                        Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 50.0.sp),
                    InputDataWidget(
                      controller: priceExpectedCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        double price = 0.0;
                        if (dropDownTypeBuySell.dropdownvalue.index == 0) {
                          // Buying
                          price = (double.parse(
                                  dropDownCurrency.dropdownvalue.buyingPrice) ??
                              0);
                        } else {
                          // Selling
                          price = (double.parse(dropDownCurrency
                                  .dropdownvalue.sellingPrice) ??
                              0);
                        }

                        if ((value ?? '').isEmpty) {
                          double enteredValue = double.parse('0') ?? 0;
                          double percentageValue =
                              -1 * (1 - (enteredValue / price)) * 100;

                          print('percentageValue :  ${percentageValue}');
                          changePercentageCtrl.text =
                              percentageValue.toStringAsFixed(3)+'%';
                          return;
                        }

                        double enteredValue = double.parse(value) ?? 0;
                        double percentageValue =
                            -1 * (1 - (enteredValue / price)) * 100;

                        print('percentageValue :  ${percentageValue}');
                        changePercentageCtrl.text =
                            percentageValue.toStringAsFixed(3)+'%';
                      },
                    ),
                    SizedBox(height: 110.0.sp),
                    TextWithDot('نسبة التغير عن سعر السوق الحاليه',
                        Theme.of(context).textTheme.subtitle2),
                    SizedBox(height: 50.0.sp),
                    InputDataWidget(
                      controller: changePercentageCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      isEnable: false,
                    ),
                    SizedBox(height: 124.0.sp),
                    TextWithDot(
                      'الحدود السعريه لسعر العملة المتوقع\n والذي يمكن للمشترك ادخاله\n. هو 3% صعود، وهبوط من سعر السوق الحالي',
                      Theme.of(context).textTheme.headline3,
                      fontSize: 10.sp,
                    ),
                    SizedBox(height: 50.0.sp),
                    TextWithDot(
                        'يمكن للمشترك ادخال سعر متوقع واحد لكل عملة \n.وذلك عن كل ثلاث ساعات',
                        Theme.of(context).textTheme.headline3,
                        fontSize: 10.sp),
                    Btn(
                      'إرسال',
                      height: 178.0,
                      width: 1021.07,
                      fontSize: 62,
                      fontWeight: FontWeight.w500,
                      horizontal: 50.0,
                      verticalMargin: 80,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        if ((prefs?.getString('accessToken') ?? '').isEmpty) {
                          Navigator.push(
                            mContext,
                            MaterialPageRoute(
                                builder: (context) => AuthScreen(
                                      homeContext: mContext,
                                    )),
                          );
                        } else {
                          if (_formKey.currentState.validate()) {
                            if (dropDownCurrency == null) {
                              showMsg(mContext, 'رجاء إختيار العملة أولا');
                              return;
                            }
                            if (dropDownTypeBuySell == null) {
                              showMsg(mContext, 'رجاء إختيار نوع العملية');
                              return;
                            }
                            if ((priceExpectedCtrl.text ?? '').isEmpty) {
                              showMsg(mContext, 'أدخل توقعك');
                              return;
                            }

                            SendExpectationResponse response =
                                await sendExpectationAPIClick(
                              mContext,
                              dropDownCurrency.dropdownvalue.id.toString(),
                              (dropDownTypeBuySell.dropdownvalue.index == 1),
                              (priceExpectedCtrl.text ?? ''),
                            );

                            if (response.ecode == 200) {
                            } else {}
                            //   LoginResponse response = await loginAPIClick(
                            //     mContext,
                            //     phoneCtrl.text ?? '',
                            //     passwordCtrl.text ?? '',
                            //   );
                            //
                            //   if (response != null &&
                            //       (response?.accessToken ?? '').isNotEmpty) {
                            //     Navigator.pop(mContext);
                            //   }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<SendExpectationResponse> sendExpectationAPIClick(BuildContext mContext,
      String currency_id, bool isSelling, String price) async {
    final body = {
      'currency_id': currency_id,
    };

    if (isSelling) {
      body['selling_price'] = price;
    } else {
      body['buying_price'] = price;
    }
    print('LoadLoginEvent body :  ${body.toString()}');

    showDialogProgress(mContext);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl = 'https://bkamalyoum.com/api/';
    var res = await http.post(
      '${baseUrl}user/expectation/add',
      body: body,
      headers: {
        "authorization": 'Bearer ' + (prefs?.getString('accessToken') ?? ''),
        // "Content-Type": "application/json",
        "Accept-Language": translator.currentLanguage ?? 'ar',
      },
    );
    Navigator.pop(mContext);

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      print('LoadLoginEvent Response :  ${data.toString()}');
      SendExpectationResponse response = SendExpectationResponse.fromJson(data);

      showMsg(mContext, response?.emsg ?? '');
      if (response.ecode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      print('LoadCurrencyEvent Error :  ' + e.toString());
      showMsg(mContext, 'حدث خطأ داخلي، يرجي المحاولة مرة أخري لاحقا.');
      return null;
    }
  }
}
