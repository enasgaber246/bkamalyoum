
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NewsResponse.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(LoadingNewsState());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is LoadNewsEvent) {
      yield LoadingNewsState();

      //String token = await FlutterSession().get("token") ?? '';

      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.get(
        '${baseUrl}news',
      );

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('LoadCurrencyEvent Response :  ${data.toString()}');
        NewsResponse response = NewsResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedNewsState(response: response);
        } else {
          yield FailedNewsState();
        }
      } catch (e) {
        print('LoadCurrencyEvent Error :  ' + e.toString());
        yield FailedNewsState();
      }
    }
  }
}

// Event
abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {
  LoadNewsEvent();
}

// Trip Details States
abstract class NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  NewsResponse response;

  LoadedNewsState({this.response});
}

class FailedNewsState extends NewsState {}
