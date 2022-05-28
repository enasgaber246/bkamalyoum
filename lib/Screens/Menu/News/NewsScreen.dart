import 'package:bkamalyoum/Component/NewsCard.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'NewsBloc.dart';

class NewsScreen extends StatelessWidget {
  final currency_bloc = NewsBloc();
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
      body: SingleChildScrollView(
      child:Column(
        children: [
          TextTitle(
            'اهم الاخبار',
            Theme.of(context).textTheme.subtitle2,
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
          ),
          BlocProvider<NewsBloc>(
            create: (context) => currency_bloc..add(LoadNewsEvent()),
            child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
              if (state is LoadingNewsState) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(48.0.sp),
                    //child: showProgressLoading(),
                  ),
                );
              } else if (state is LoadedNewsState) {
                return ListView.builder(
                 shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.response.ebody.length,
                  itemBuilder: (context, index) => Container(
                      //padding: EdgeInsets.all(2.0),
                      child: NewsCard(
                          state.response.ebody[index].title,
                          state.response.ebody[index].body,
                          state.response.ebody[index].image)),
                );
              } else if (state is FailedNewsState) {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              } else {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              }
            }),
          ),
        ],
      ),
    ));
  }
}
