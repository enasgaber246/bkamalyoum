import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'PrivacyPolicyBloc.dart';
import 'PrivacyPolicyResponse.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final privacy_bloc = PrivacyPolicyBloc();

  @override
  Widget build(BuildContext mContext) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(mContext).primaryColor,
          title: Text(
            'بكام اليوم؟',
            style: TextStyle(fontFamily: 'Lalezar'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(mContext).pop(),
          ),
        ),
        body: BlocProvider<PrivacyPolicyBloc>(
          create: (context) => privacy_bloc..add(LoadPrivacyPolicyEvent()),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is LoadingPrivacyPolicyState) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(48.0.sp),
                  child: showProgressLoading(),
                ),
              );
            } else if (state is LoadedPrivacyPolicyState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: state.response.ebody.length,
                itemBuilder: (context, index) => Container(
                    //padding: EdgeInsets.all(2.0),
                    child: textCard(mContext, state.response.ebody[index])),
              );
            } else if (state is FailedPrivacyPolicyState) {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            } else {
              return TextTitle('', Theme.of(context).textTheme.subtitle1);
            }
          }),
        ));
  }

  Widget textCard(BuildContext context, PrivacyItem item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 56.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     child: TextTitle(
          //       item.name,
          //       Theme.of(context).textTheme.subtitle2,
          //       textAlign: TextAlign.left,
          //     )),
          TextTitle(item.value, Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left),
          SizedBox(height: 56.sp),
        ],
      ),
    );
  }
}
