import 'dart:typed_data';

import 'package:bkamalyoum/Component/AppBarCustom.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/GoldCard.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

import 'GoldPricesBloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'metal_prices_response.dart';

class GoldPricesScreen extends StatelessWidget {
  final GoldPricesBloc bloc = GoldPricesBloc();

  // ScreenShot
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imageFileScreenShot;

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
        onTapCamera: () async {
          screenshotController
              .capture(pixelRatio: 1.5)
              .then((Uint8List image) async {
            //Capture Done
            _imageFileScreenShot = image;
            await Share.file(
                'بكام اليوم', 'bkamelyoum.jpg', _imageFileScreenShot, 'image/jpg');
          }).catchError((onError) {
            print(onError);
          });
        },
        onReloadTap: () async {
          bloc.add(LoadMetalPricesEvent());
        },
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: BlocProvider<GoldPricesBloc>(
              create: (context) => bloc..add(LoadMetalPricesEvent()),
              child: BlocBuilder<GoldPricesBloc, MetalPricesState>(
                  builder: (context, state) {
                if (state is LoadingMetalPricesState) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(148.0.sp),
                      child: showProgressLoading(),
                    ),
                  );
                } else if (state is LoadedMetalPricesState) {
                  return Column(
                    children: [
                      TextTitle(
                        '  تحديث ${getDateFormatted()}',
                        Theme.of(mContext).textTheme.subtitle1,
                      ),
                      ListView.builder(
                        // itemExtent: 42.0,
                        itemCount: state.response?.ebody?.length ?? 0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            metalCard(mContext, state.response?.ebody[index]),
                      ),
                      SizedBox(height: 124.sp),
                    ],
                  );
                } else if (state is FailedMetalPricesState) {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                } else {
                  return TextTitle('', Theme.of(context).textTheme.subtitle1);
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget metalCard(BuildContext mContext, MetalCategoryModel categoryModel) {
    return Container(
      child: Column(
        children: [
          Divider(
            color: Theme.of(mContext).primaryColor,
            thickness: 1,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextTitle(
                        'جنيه سوداني', Theme.of(mContext).textTheme.headline2),
                    TextTitle('اسعار ${categoryModel.nameAr ?? ''}',
                        Theme.of(mContext).textTheme.headline2),
                  ])),
          Divider(
            color: Theme.of(mContext).primaryColor,
            thickness: 1,
          ),
          ListView.builder(
            itemExtent: 42.0,
            itemCount: categoryModel.metals?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              //padding: EdgeInsets.all(2.0),
              child: Material(
                // elevation: 2.0,
                //borderRadius: BorderRadius.circular(5.0), F2F8F8
                color: index % 2 == 0
                    ? Theme.of(context).primaryColorLight
                    : Colors.white,
                child: GoldCard(categoryModel.metals[index]),
              ),
            ),
          ),
          // Divider(
          //   color: Theme.of(mContext).primaryColor,
          //   thickness: 1,
          // ),
          SizedBox(height: 186.sp),
        ],
      ),
    );
  }
}
