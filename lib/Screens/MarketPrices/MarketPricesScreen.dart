import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MarketPricesBloc.dart';

class MarketPricesScreen extends StatelessWidget {
  final MarketPricesBloc marketPricesBloc = MarketPricesBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextTitle(
          'تحديث 5 أبريل 11:47 ص',
          Theme.of(context).textTheme.subtitle1,
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 1,
        ),
        CardContent('assets/images/dolar.svg', ' USA دولار أمريكي', 'شراء',
            'بيع', Theme.of(context).textTheme.headline2),
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 1,
        ),
        BlocProvider<MarketPricesBloc>(
          create: (context) => marketPricesBloc..add(LoadMarketPricesEvent()),
          child: BlocBuilder<MarketPricesBloc, MarketPricesState>(
              builder: (context, state) {
            if (state is LoadingMarketPricesState) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(48.0.sp),
                  //child: showProgressLoading(),
                ),
              );
            } else if (state is LoadedMarketPricesState) {
              return Expanded(
                child: ListView.builder(
                  itemExtent: 42.0,
                  itemCount: state.response.ebody.length,
                  itemBuilder: (context, index) => Container(
                    //padding: EdgeInsets.all(2.0),
                    child: Material(
                      elevation: 2.0,
                      //borderRadius: BorderRadius.circular(5.0),F2F8F8
                      color: index % 2 == 0
                          ? Theme.of(context).primaryColorLight
                          : Colors.white,
                      child: CardContent(
                          state.response.ebody[index].image?? '',
                          state.response.ebody[index].nameAr,
                          '580.00',
                          '580.00',
                          Theme.of(context).textTheme.subtitle1,networkUrl: state.response.ebody[index].image?? '',)
                    ),
                  ),
                ),
              );
            } else if (state is FailedMarketPricesState) {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            } else {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            }
          }),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 1,
        ),
        CardContent('assets/images/dolar.svg', ' USA دولار أمريكي', 'شراء',
            'بيع', Theme.of(context).textTheme.headline2),
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 1,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: 42.0,
            itemBuilder: (context, index) => Container(
              //padding: EdgeInsets.all(2.0),
              child: Material(
                  elevation: 2.0,
                  //borderRadius: BorderRadius.circular(5.0),F2F8F8
                  color: index % 2 == 0
                      ? Theme.of(context).primaryColorLight
                      : Colors.white,
                  child: Text("data")
                  // CardContent('assets/images/bank.svg',
                  //     'البنك الاهلي السوداني', '580.00', '580.00',Theme.of(context).textTheme.subtitle1),
                  ),
            ),
          ),
        )
      ],
    );
  }
}
