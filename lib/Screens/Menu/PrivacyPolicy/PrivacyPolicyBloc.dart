
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PrivacyPolicyResponse.dart';



class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  PrivacyPolicyBloc() : super(LoadingPrivacyPolicyState());

  @override
  Stream<PrivacyPolicyState> mapEventToState(PrivacyPolicyEvent event) async* {
    if (event is LoadPrivacyPolicyEvent) {
      yield LoadingPrivacyPolicyState();

      //String token = await FlutterSession().get("token") ?? '';

      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.get(
        '${baseUrl}about_us',
      );

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('Load PrivacyPolicy Event Response :  ${data.toString()}');
        PrivacyPolicyResponse response = PrivacyPolicyResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedPrivacyPolicyState(response: response);
        } else {
          yield FailedPrivacyPolicyState();
        }
      } catch (e) {
        print('LoadPrivacyPolicyEvent Error :  ' + e.toString());
        yield FailedPrivacyPolicyState();
      }
    }
  }
}

// Event
abstract class PrivacyPolicyEvent {}

class LoadPrivacyPolicyEvent extends PrivacyPolicyEvent {
  LoadPrivacyPolicyEvent();
}

// Trip Details States
abstract class PrivacyPolicyState {}

class LoadingPrivacyPolicyState extends PrivacyPolicyState {}

class LoadedPrivacyPolicyState extends PrivacyPolicyState {
  PrivacyPolicyResponse response;

  LoadedPrivacyPolicyState({this.response});
}

class FailedPrivacyPolicyState extends PrivacyPolicyState {}
