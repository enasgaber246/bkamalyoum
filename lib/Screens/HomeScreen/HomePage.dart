import 'package:bkamalyoum/Component/ChoiseCoinCard.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:bkamalyoum/Screens/BankPrices/BankPricesBloc.dart';
import 'package:bkamalyoum/Screens/Menu/MenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BankPrices/BankPricesScreen.dart';
import '../ExpectPrices/ExpectPricesScreen.dart';
import '../GoldPrices/GoldPricesScreen.dart';
import '../MarketPrices/MarketPricesScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Currency/CurrencyBloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final currency_bloc = CurrencyBloc();
  final BankPricesBloc bankPricesBloc = BankPricesBloc();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Color selectedItemColor;
  Color unselectedItemColor;
  Color selectedBgColor;
  Color unselectedBgColor;
  int _selectedIndex = 0;

  // final widgetOptions = [
  //   BankPricesScreen(),
  //   MarketPricesScreen(),
  //   ExpectPricesScreen(),
  //   GoldPricesScreen(),
  //   MenuScreen(),
  // ];
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    selectedItemColor = Colors.white;
    unselectedItemColor = Colors.white;
    selectedBgColor = Colors.transparent;
    unselectedBgColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'بكام اليوم؟',
          style: TextStyle(fontFamily: 'Lalezar'),
        ),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/images/refersh.svg',
                  width: 82.sp,
                  height: 85.sp,
                  fit: BoxFit.contain,
                ),
              )),
          Container(
              padding: EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/images/camera.svg',
                  width: 107.sp,
                  height: 77.sp,
                  fit: BoxFit.contain,
                ),
              )),
          PopupMenuButton(
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
                                child: Material(
                                  elevation: 2.0,
                                  //borderRadius: BorderRadius.circular(5.0),F2F8F8
                                  color: index % 2 == 0
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.white,
                                  child: ChoiseCoinCard(
                                    state.response.ebody[index].image?? '',
                                    state.response.ebody[index].nameAr,
                                    state.response.ebody[index].nameEn,
                                    onPressed: () {
                                      SelectedCurrency(
                                          state.response.ebody[index].id);
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
              }),
          SizedBox(
            width: 12.0,
          )
        ],
      ),
      body: Center(
        child: [
          BankPricesScreen(bankPricesBloc: bankPricesBloc),
          MarketPricesScreen(),
          ExpectPricesScreen(),
          GoldPricesScreen(),
          MenuScreen(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: unselectedBgColor,
        type: BottomNavigationBarType.fixed,
        // Fixed
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/bankPrices.svg', 'أسعار العملات \nبالبنوك', 0),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/marketPrice.svg', 'أسعار العملات\n بالسوق', 1),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/expectPrices.svg', 'ادخل توقعك\n للاسعار', 2),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(
                'assets/images/goldandSelver.svg', 'أسعار الذهب\n والفضه', 3),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/images/more.svg', 'المزيد', 4),
            title: SizedBox.shrink(),
          ),
        ],
        elevation: 0,
        //         currentIndex: _selectedIndex,
        //         selectedItemColor: selectedItemColor,
        //         unselectedItemColor: unselectedItemColor,
        //         //  backgroundColor: Colors.teal,
        //         //  fixedColor: Colors.white,
        // // selectedItemColor: Colors.amber,
        // unselectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  Color _getBgColor(int index) =>
      _selectedIndex == index ? selectedBgColor : unselectedBgColor;

  Color _getItemColor(int index) =>
      _selectedIndex == index ? selectedItemColor : unselectedItemColor;

  Widget _buildIcon(String icon, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 28.0,
                  height: 28.0,
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
                Text(text,
                    style: TextStyle(
                        fontSize: 8,
                        color: _getItemColor(index),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            //onTap: () => _onItemTapped(index),
          ),
        ),
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('INDEX :::  ${index}');
    });
  }

  SelectedCurrency(int id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('LastSelectedCurrencyId', id);
    print('LastSelectedCurrencyId :  ${id}');
    bankPricesBloc..add(LoadBankPricesEvent(id: id));

    Navigator.pop(context);
  }
}
