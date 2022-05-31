import 'dart:convert';
import 'package:bkamalyoum/Screens/HomeScreen/Currency/currencylistResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketPricesBloc extends Bloc<MarketPricesEvent, MarketPricesState> {
  MarketPricesBloc() : super(LoadingMarketPricesState());

  @override
  Stream<MarketPricesState> mapEventToState(MarketPricesEvent event) async* {
    if (event is LoadMarketPricesEvent) {
      yield LoadingMarketPricesState();

      //String token = await FlutterSession().get("token") ?? '';

      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.get(
        '${baseUrl}currency',
      );

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('LoadMarketPricesEvent Response :  ${data.toString()}');
        CurrencylistResponse response = CurrencylistResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedMarketPricesState(response: response);
        } else {
          yield FailedMarketPricesState();
        }
      } catch (e) {
        print('LoadMarketPricesEvent Error :  ' + e.toString());
        yield FailedMarketPricesState();
      }
    }
  }
}

// Event
abstract class MarketPricesEvent {}

class LoadMarketPricesEvent extends MarketPricesEvent {
  LoadMarketPricesEvent();
}

// Trip Details States
abstract class MarketPricesState {}

class LoadingMarketPricesState extends MarketPricesState {}

class LoadedMarketPricesState extends MarketPricesState {
  CurrencylistResponse response;

  LoadedMarketPricesState({this.response});
}

class FailedMarketPricesState extends MarketPricesState {}
