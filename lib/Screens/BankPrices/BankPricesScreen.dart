import 'package:bkamalyoum/Component/CardContent.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BankPricesBloc.dart';

class BankPricesScreen extends StatelessWidget {
  final BankPricesBloc bankPricesBloc ;

  const BankPricesScreen({Key key, this.bankPricesBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<BankPricesBloc>(
      create: (context) => bankPricesBloc..add(LoadBankPricesEvent()),
      child: BlocBuilder<BankPricesBloc, BankPricesState>(
          builder: (context, state) {
        if (state is LoadingBankPricesState) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(48.0.sp),
              // child: showProgressLoading(),
            ),
          );
        } else if (state is LoadedBankPricesState) {
          return Column(
            children: [
              TextTitle(
                'تحديث 5 أبريل 11:47 ص',
                Theme.of(context).textTheme.subtitle1,
              ),
              Divider(
                color: Colors.black26,
              ),
              CardContent('assets/images/dolar.svg', ' USA دولار أمريكي',
                  'شراء', 'بيع', Theme.of(context).textTheme.subtitle1),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 2,
              ),
              Expanded(
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
                        '',
                        state.response.ebody[index].nameAr,
                        state.response.ebody[index].buyingPrice,
                        state.response.ebody[index].sellingPrice,
                        Theme.of(context).textTheme.subtitle1,
                        networkUrl: state.response.ebody[index].image,
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
    );
  }
}
