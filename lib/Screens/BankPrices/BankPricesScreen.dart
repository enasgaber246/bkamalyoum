import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/CardContentTitle.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/InputDataWidget.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:link/link.dart';
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
                    itemBuilder: (context, index) => GestureDetector(
                      child: Container(
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
                            state.prefs,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(
                                  context,
                                  state.response.ebody[index],
                                  (selectedCurrency?.nameEn ??
                                      (state.response?.ebody[0]
                                          ?.currencyName ??
                                          '')) +
                                      ' ' +
                                      (selectedCurrency?.nameAr ?? ''),
                                  selectedCurrency?.image ??
                                      state.response?.ebody[0]
                                          ?.currencyImage ??
                                      ''),
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
    );
  }


  Widget _buildPopupDialog(BuildContext context, BankPriceModel model,
      String currency, String currencyImage) {
    return new AlertDialog(
      // title: const Text('Popup example'),
      content: new SingleChildScrollView(child:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(30.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextTitle(
                    model.nameAr ?? '-',
                    //  'البنك العربي الافريقي الدولي',
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
                  (model.image == null)
                      ? SizedBox(
                    width: 100.sp,
                    height: 100.sp,
                  )
                      : Container(
                    width: 100.sp,
                    height: 100.sp,
                    padding: EdgeInsets.all(5.0.sp),
                    child: Image.network(
                      'https://bkamalyoum.com/uploads/small/${model.image}',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(30.0.sp),
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
                    width: 100.sp,
                    height: 100.sp,
                  )
                      : Container(
                    width: 100.sp,
                    height: 100.sp,
                    padding: EdgeInsets.all(5.0.sp),
                    child: Image.network(
                      'https://bkamalyoum.com/uploads/small/${currencyImage}',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Switch(
                    value: false,
                    //onChanged:(),
                    activeColor: Theme.of(context).primaryColor,

                    inactiveThumbColor: Colors.black12,
                  ),
                ),
                TextTitle(
                    ' :  الإشعارات', Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InputDataWidget(
                  //  controller: priceCtrl,
                  width: 500.0,
                  height: 100.0,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: 10,
                ),
                TextTitle(':  المبلغ', Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextTitle( '  جنيه مصري${model.sellingPrice ?? '-'}',
                    Theme.of(context).textTheme.subtitle1),
                TextTitle(
                    ' :  سعر الشراء ', Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextTitle(
                    ' 18.58 جنيه مصري ', Theme.of(context).textTheme.subtitle1),
                TextTitle(
                    ':  سعر البيع ', Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextTitle(
                    ' ٢ يونيو١٢:١٤ م  ', Theme.of(context).textTheme.subtitle1),
                TextTitle(' :  اخر تعديل بالبنك',
                    Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextTitle(
                    ' ٢ يونيو١٢:١٤ م  ', Theme.of(context).textTheme.subtitle1),
                TextTitle(':  تاريخ اخر تحديث',
                    Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.phone_in_talk_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconSize: 24,
                  onPressed: () {},
                ),
                TextTitle('19555', Theme.of(context).textTheme.subtitle1),
                TextTitle(
                    '  : الخط الساخن   ', Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0.sp),
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
                  url: 'https://google.com',
                  //onError: _showErrorSnackBar,
                ),
                TextTitle(':  الموقع الالكتروني ',
                    Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Btn(
            'عرض الرسم البياني',
            height: 600.sp,
            fontSize: 55,
          )
        ],
      ) ,),
    );
  }
}
