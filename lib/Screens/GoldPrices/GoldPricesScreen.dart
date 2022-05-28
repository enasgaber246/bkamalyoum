import 'package:bkamalyoum/Component/GoldCard.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/material.dart';

class GoldPricesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext mContext) {
    // TODO: implement build

    return Column(
      children: [
        TextTitle(
          'تحديث 5 أبريل 11:47 ص',
          Theme.of(mContext).textTheme.subtitle1,
        ),
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
                  TextTitle(
                      'اسعار الذهب', Theme.of(mContext).textTheme.headline2),
                ])),
        Divider(
          color: Theme.of(mContext).primaryColor,
          thickness: 1,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: 42.0,
            itemCount: 1,
            itemBuilder: (context, index) => Container(
              //padding: EdgeInsets.all(2.0),
              child: Material(
                elevation: 2.0,
                //borderRadius: BorderRadius.circular(5.0),F2F8F8
                color: index % 2 == 0
                    ? Theme.of(context).primaryColorLight
                    : Colors.white,
                child: GoldCard('576.00', 'الذهب عيار 21'),
              ),
            ),
          ),
        ),
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
                  TextTitle(
                      'اسعار الفضه', Theme.of(mContext).textTheme.headline2),
                ])),
        Divider(
          color: Theme.of(mContext).primaryColor,
          thickness: 1,
        ),
        Expanded(
          child: ListView.builder(
            itemExtent: 42.0,
            itemCount: 1,
            itemBuilder: (context, index) => Container(
              //padding: EdgeInsets.all(2.0),
              child: Material(
                elevation: 2.0,
                //borderRadius: BorderRadius.circular(5.0),F2F8F8
                color: index % 2 == 0
                    ? Theme.of(context).primaryColorLight
                    : Colors.white,
                child: GoldCard('567.00', 'فضه عيار92.5 (الاسترليني)'),
              ),
            ),
          ),
        )
      ],
    );
    // return Center(
    //   child:Column(
    //     children: [
    //       Text('أسعار الذهب والفضه'),
    //       Text(translator.translate('Welcome')),
    //       InkWell(
    //         onTap: () async {
    //
    //           if (translator.currentLanguage == "ar") {
    //             print("en to ar");
    //             await FlutterSession().set("langu", "en");
    //             translator.setNewLanguage(
    //               mContext,
    //               newLanguage: 'en',
    //               restart: true,
    //               remember: true,
    //             );
    //           } else {
    //             await FlutterSession().set("langu", "ar");
    //             translator.setNewLanguage(
    //               mContext,
    //               newLanguage: 'ar',
    //               restart: true,
    //               remember: true,
    //             );
    //           }
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.all(24.0),
    //           child: Text('Change Language',style: TextStyle(
    //             color: Colors.black
    //           ),),
    //         ),
    //       ),
    //     ],
    //   ) ,
    // );
  }
}
