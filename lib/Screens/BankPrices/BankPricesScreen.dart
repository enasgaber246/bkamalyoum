import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/CardContentTitle.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BankPricesBloc.dart';
import 'BankPricesResponse.dart';

class BankPricesScreen extends StatelessWidget {
  final BankPricesBloc bankPricesBloc = BankPricesBloc();
  static Current selectedCurrency;

  BankPricesScreen({Key key}) : super(key: key);

  String getDateFormatted() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM  hh:mm a', 'ar');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext mContext) {
    initializeDateFormatting('ar');

    return Scaffold(
      appBar: AppBarCustom(
        mContext: mContext,
        automaticallyImplyLeading: false,
        onTapCamera: () async {},
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
      body: BlocProvider<BankPricesBloc>(
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
                TextTitle(
                  ' تحديث ${getDateFormatted()}',
                  Theme.of(context).textTheme.subtitle1,
                ),
                Divider(
                  color: Colors.black26,
                ),
                CardContentTitle(
                  (selectedCurrency?.nameEn ??
                          (state.response?.ebody[0]?.currencyName ?? '')) +
                      ' ' +
                      (selectedCurrency?.nameAr ?? ''),
                  'شراء',
                  'بيع',
                  Theme.of(context).textTheme.subtitle1,
                  networkUrl: selectedCurrency?.image ??
                      state.response?.ebody[0]?.currencyImage ??
                      '',
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    itemExtent: 42.0,
                    itemCount: state.response.ebody.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      //padding: EdgeInsets.all(2.0),
                      child: Material(
                        elevation: 2.0,
                        //borderRadius: BorderRadius.circular(5.0),F2F8F8
                        color: index % 2 == 0
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: BankPricesCard(
                          state.response.ebody[index],
                          Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
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
    );
  }
}
