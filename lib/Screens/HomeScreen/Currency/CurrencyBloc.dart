import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'currencylistResponse.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(LoadingCurrencyState());

  @override
  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is LoadCurrencyEvent) {
      yield LoadingCurrencyState();

      //String token = await FlutterSession().get("token") ?? '';

      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.get(
        '${baseUrl}currency',
      );

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('LoadCurrencyEvent Response :  ${data.toString()}');
        CurrencylistResponse response = CurrencylistResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedCurrencyState(response: response);
        } else {
          yield FailedCurrencyState();
        }
      } catch (e) {
        print('LoadCurrencyEvent Error :  ' + e.toString());
        yield FailedCurrencyState();
      }
    }
  }
}

// Event
abstract class CurrencyEvent {}

class LoadCurrencyEvent extends CurrencyEvent {
  LoadCurrencyEvent();
}

// Trip Details States
abstract class CurrencyState {}

class LoadingCurrencyState extends CurrencyState {}

class LoadedCurrencyState extends CurrencyState {
  CurrencylistResponse response;

  LoadedCurrencyState({this.response});
}

class FailedCurrencyState extends CurrencyState {}
