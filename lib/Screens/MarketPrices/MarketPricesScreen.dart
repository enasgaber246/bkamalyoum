import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/CardContentTitle.dart';
import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'MarketPricesBloc.dart';

class MarketPricesScreen extends StatelessWidget {
  final MarketPricesBloc marketPricesBloc = MarketPricesBloc();

  String getDateFormatted() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM  hh:mm a', 'ar');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar');
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider<MarketPricesBloc>(
            create: (context) => marketPricesBloc..add(LoadMarketPricesEvent()),
            child: BlocBuilder<MarketPricesBloc, MarketPricesState>(
                builder: (context, state) {
              if (state is LoadingMarketPricesState) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(48.0.sp),
                    child: showProgressLoading(),
                  ),
                );
              } else if (state is LoadedMarketPricesState) {
                return Column(
                  children: [
                    TextTitle(
                      ' تحديث ${getDateFormatted()}',
                      Theme.of(context).textTheme.subtitle1,
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                    ),
                    CardContentTitle('assets/images/dolar.svg', ' USA دولار أمريكي',
                        'شراء', 'بيع', Theme.of(context).textTheme.headline2),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                    ),
                    ListView.builder(
                      itemExtent: 42.0,
                      itemCount: state.response.ebody.current.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        //padding: EdgeInsets.all(2.0),
                        child: Material(
                            // elevation: 2.0,
                            //borderRadius: BorderRadius.circular(5.0),F2F8F8
                            color: index % 2 == 0
                                ? Theme.of(context).primaryColorLight
                                : Colors.white,
                            child: CardContentTitle(
                              state.response.ebody?.current[index]?.image ?? '',
                              state.response.ebody?.current[index]?.nameAr ??
                                  '',
                              numberFormat.format(double.parse(state.response
                                          .ebody?.current[index]?.buyingPrice ??
                                      '0')) ??
                                  '-',
                              numberFormat.format(double.parse(state
                                          .response
                                          .ebody
                                          ?.current[index]
                                          ?.sellingPrice ??
                                      '0')) ??
                                  '-',
                              Theme.of(context).textTheme.subtitle1,
                              networkUrl:
                                  state.response.ebody?.current[index].image ??
                                      '',
                            )),
                      ),
                    ),
                    SizedBox(height: 78.sp),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                    ),
                    CardContentTitle(
                        'assets/images/dolar.svg',
                        ' USA دولار أمريكي',
                        'شراء',
                        'بيع',
                        Theme.of(context).textTheme.headline2),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                    ),
                    ListView.builder(
                      itemExtent: 42.0,
                      itemCount: state.response.ebody.expectaions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        //padding: EdgeInsets.all(2.0),
                        child: Material(
                            // elevation: 2.0,
                            //borderRadius: BorderRadius.circular(5.0),F2F8F8
                            color: index % 2 == 0
                                ? Theme.of(context).primaryColorLight
                                : Colors.white,
                            child: CardContentTitle(
                              state.response.ebody?.expectaions[index]?.image ??
                                  '',
                              state.response.ebody?.expectaions[index]
                                      ?.nameAr ??
                                  '',
                              numberFormat.format(double.parse(state.response
                                  .ebody?.expectaions[index]?.buyingPrice ??
                                  '0')) ??
                                  '-',
                              numberFormat.format(double.parse(state
                                  .response
                                  .ebody
                                  ?.expectaions[index]
                                  ?.sellingPrice ??
                                  '0')) ??
                                  '-',
                              Theme.of(context).textTheme.subtitle1,
                              networkUrl: state.response.ebody
                                      ?.expectaions[index].image ??
                                  '',
                            )),
                      ),
                    ),
                  ],
                );
              } else if (state is FailedMarketPricesState) {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              } else {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              }
            }),
          ),
        ],
      ),
    );
  }
}
