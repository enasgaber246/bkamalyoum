import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Component/switchWithText.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/CurrencyBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _settingScreenState();
  }
}

class _settingScreenState extends State<SettingScreen> {
  final currency_bloc = CurrencyBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
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
            switchWithText("صوت الاشعارات", true, (val) {}),
            switchWithText("صوت الاشعارات", false, (val) {}),
            switchWithText("صوت الاشعارات", false, (val) {}),
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
                      //child: showProgressLoading(),
                    ),
                  );
                } else if (state is LoadedCurrencyState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 42.0,
                    itemCount: state.response.ebody.length,
                    itemBuilder: (context, index) => Container(
                      //padding: EdgeInsets.all(2.0),

                      child: switchWithText(
                          state.response.ebody[index].nameAr, true, (val) {}),
                    ),
                  );
                } else if (state is FailedCurrencyState) {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                } else {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                }
              }),
            ),

            // switchWithText("صوت الاشعارات",true,(val){}),
            // switchWithText("صوت الاشعارات",false,(val){}),
            // switchWithText("صوت الاشعارات",false,(val){}),
            // switchWithText("صوت الاشعارات",false,(val){}),
            // switchWithText("صوت الاشعارات",false,(val){}),
          ],
        ));
  }
}
