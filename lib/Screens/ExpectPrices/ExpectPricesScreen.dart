import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/DropDown.dart';
import 'package:bkamalyoum/Component/InputDataWidget.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Component/TextWithDot.dart';
import 'package:bkamalyoum/Screens/Auth/AuthScreen.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/CurrencyBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpectPricesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExpectPricesScreenState();
  }
}

class ExpectPricesScreenState extends State<ExpectPricesScreen> {
  final currency_bloc = CurrencyBloc();
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              child: TextTitle(
                  'ادخل توقعك للاسعار', Theme.of(context).textTheme.subtitle2),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
            ),
            TextWithDot('اختر العمله', Theme.of(context).textTheme.subtitle2),
            BlocProvider<CurrencyBloc>(
              create: (context) => currency_bloc..add(LoadCurrencyEvent()),
              child: BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                if (state is LoadingCurrencyState) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(148.0.sp),
                      child: showProgressLoading(),
                    ),
                  );
                } else if (state is LoadedCurrencyState) {
                  for (int i = 0;
                      i < state.response.ebody.current.length;
                      i++) {
                    dropdownItem.add(state.response.ebody.current[i].nameAr);
                  }
                  return DropDown(dropdownItem);
                } else if (state is FailedCurrencyState) {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                } else {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                }
              }),
            ),
            TextWithDot('نوع العملية', Theme.of(context).textTheme.subtitle2),
            DropDown(['بيع', 'شراء']),
            TextWithDot('ما هو توقعك لسعر العملة بالسوق صعود ام هبوط؟',
                Theme.of(context).textTheme.subtitle2),
            DropDown(['صعود', 'هبوط']),
            TextWithDot('ادخل توقعك لسعر العملة بالسوق',
                Theme.of(context).textTheme.subtitle2),
            InputDataWidget(),
            TextWithDot('نسبة التغير عن سعر السوق الحاليه',
                Theme.of(context).textTheme.subtitle2),
            InputDataWidget(),
            TextWithDot(
              'الحدود السعريه لسعر العملة المتوقع والذي يمكن للمشترك ادخاله هو 3% صعود\n .وهبوط من سعر السوق الحالي',
              Theme.of(context).textTheme.headline3,
              fontSize: 10.sp,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextWithDot(
                '.يمكن للمشترك ادخال سعر متوقع واحد لكل عملة وذلك عن كل ثلاث ساعات',
                Theme.of(context).textTheme.headline3,
                fontSize: 10.sp),
            Btn(
              'إرسال',
              height: 178.0,
              fontSize: 62,
              fontWeight: FontWeight.w500,
              horizontal: 50.0,
              verticalMargin: 80,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                if ((prefs?.getString('AuthToken') ?? '').isEmpty) {
                  Navigator.push(
                    mContext,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                } else {

                }
              },
            )
          ],
        ),
      ),
    );
  }
}
