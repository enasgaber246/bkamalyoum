import 'package:bkamalyoum/Component/Components.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'PrivacyPolicyBloc.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final privacy_bloc = PrivacyPolicyBloc();
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
          child: BlocProvider<PrivacyPolicyBloc>(
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
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextTitle(
                              state.response.ebody[3].name,
                              Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.left,
                            )),
                        TextTitle(state.response.ebody[3].value,
                            Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextTitle(state.response.ebody[4].name,
                                Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.left)),
                        TextTitle(state.response.ebody[4].value,
                            Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left),
                      ],
                    ));
              } else if (state is FailedPrivacyPolicyState) {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              } else {
                return TextTitle('', Theme.of(context).textTheme.subtitle1);
              }
            }),
          ),
        ));
  }
}
