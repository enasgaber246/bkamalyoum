import 'package:bkamalyoum/Screens/BankPrices/BankPricesBloc.dart';
import 'package:bkamalyoum/Screens/BankPrices/BankPricesScreen.dart';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/CurrencyBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChoiseCoinCard.dart';
import 'Components.dart';
import 'TextTitle.dart';

AppBar AppBarCustom({
  // BankPricesBloc bankPricesBloc,
  BuildContext mContext,
  bool automaticallyImplyLeading,
  GestureTapCallback onTapCamera,
  GestureTapCallback onSelectCurrency,
  GestureTapCallback onReloadTap,
}) {
  final CurrencyBloc currency_bloc = CurrencyBloc();

  return AppBar(
    backgroundColor: Theme.of(mContext).primaryColor,
    title: Text(
      'بكام اليوم؟',
      style: TextStyle(fontFamily: 'Lalezar'),
    ),
    automaticallyImplyLeading: false,
    actions: [
      // _imageFileScreenShot != null
      //     ? Image.memory(_imageFileScreenShot)
      //     : Container(),
      (onReloadTap != null)
          ? Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: GestureDetector(
                onTap: onReloadTap,
                child: SvgPicture.asset(
                  'assets/images/refersh.svg',
                  width: 82.sp,
                  height: 85.sp,
                  fit: BoxFit.contain,
                ),
              ))
          : SizedBox(),

      (onTapCamera != null)
          ? Container(
          padding: EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              // screenshotController
              //     .capture(pixelRatio: 1.5)
              //     .then((Uint8List image) {
              //   //Capture Done
              //   setState(() {
              //     _imageFileScreenShot = image;
              //     _imageFile = File.fromRawPath(_imageFileScreenShot);
              //     _shareImage(_imageFileScreenShot);
              //   });
              // }).catchError((onError) {
              //   print(onError);
              // });

              // final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
              // String fileName = DateTime.now().microsecondsSinceEpoch;
              // String path = '$directory';
              //
              // screenshotController.captureAndSave(
              // path //set path where screenshot will be saved
              // fileName:fileName
              // );
            },
            child: SvgPicture.asset(
              'assets/images/camera.svg',
              width: 107.sp,
              height: 77.sp,
              fit: BoxFit.contain,
            ),
          ))
          : SizedBox(),
      (onSelectCurrency != null)
          ? PopupMenuButton(
              icon: SvgPicture.asset(
                'assets/images/choiseCoin.svg',
                width: 131.sp,
                height: 85.sp,
                fit: BoxFit.contain,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 145.71.sp,
                                    height: 76.72.sp,
                                    child: SvgPicture.asset(
                                      'assets/images/coin.svg',
                                    ),
                                  ),
                                  TextTitle('إختر العملة',
                                      Theme.of(context).textTheme.subtitle2),
                                ])),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Container(
                      // height: 663.14.sp, // Change as per your requirement
                      width: 1141.32.sp, // Change as per your requirement
                      child: BlocProvider<CurrencyBloc>(
                        create: (context) =>
                            currency_bloc..add(LoadCurrencyEvent()),
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
                            return ListView.builder(
                              shrinkWrap: true,
                              itemExtent: 42.0,
                              itemCount:
                                  state.response.ebody?.current?.length ?? 0,
                              itemBuilder: (context, index) => Container(
                                //padding: EdgeInsets.all(2.0),
                                child: Material(
                                  elevation: 2.0,
                                  //borderRadius: BorderRadius.circular(5.0),F2F8F8
                                  color: index % 2 == 0
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.white,
                                  child: ChoiseCoinCard(
                                    state.response.ebody?.current[index]
                                            .image ??
                                        '',
                                    state.response.ebody?.current[index].nameAr,
                                    state.response.ebody?.current[index].nameEn,
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt(
                                          'LastSelectedCurrencyId',
                                          state.response.ebody?.current[index]
                                              .id);

                                      BankPricesScreen.selectedCurrency = state.response.ebody?.current[index];

                                      Future.delayed(
                                          const Duration(milliseconds: 50),
                                          onSelectCurrency);
                                    },
                                  ),
                                ),
                              ),
                            );
                          } else if (state is FailedCurrencyState) {
                            return TextTitle(
                                '', Theme.of(context).textTheme.subtitle1);
                          } else {
                            return TextTitle(
                                '', Theme.of(context).textTheme.subtitle1);
                          }
                        }),
                      ),
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  // print("My account menu is selected.");
                } else if (value == 1) {
                  // print("Settings menu is selected.");
                }
              },
            )
          : SizedBox(),
      SizedBox(width: 12.0)
    ],
  );
}
