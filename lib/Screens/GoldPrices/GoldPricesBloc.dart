import 'dart:convert';
import 'package:bkamalyoum/Screens/GoldPrices/metal_prices_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class GoldPricesBloc extends Bloc<MetalPricesEvent, MetalPricesState> {
  GoldPricesBloc() : super(LoadingMetalPricesState());

  @override
  Stream<MetalPricesState> mapEventToState(MetalPricesEvent event) async* {
    if (event is LoadMetalPricesEvent) {
      yield LoadingMetalPricesState();

      //String token = await FlutterSession().get("token") ?? '';
      final body = {
        '-': '-',
      };
      // if (event.id != null) {
      //   body['currency'] = event.id.toString();
      // }else{
      //   body['currency'] = '2';
      // }

      print('LoadBankPricesEvent Body :  ${body.toString()}');

      // final jsonString = json.encode(body);
      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.get(
        '${baseUrl}metal',
      );

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('LoadBankPricesEvent Response :  ${data.toString()}');
        MetalPricesResponse response = MetalPricesResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedMetalPricesState(response: response);
        } else {
          yield FailedMetalPricesState();
        }
      } catch (e) {
        print('LoadCurrencyEvent Error :  ' + e.toString());
        yield FailedMetalPricesState();
      }
    }
  }
}

// Event
abstract class MetalPricesEvent {}

class LoadMetalPricesEvent extends MetalPricesEvent {
  LoadMetalPricesEvent();
}

// Trip Details States
abstract class MetalPricesState {}

class LoadingMetalPricesState extends MetalPricesState {}

class LoadedMetalPricesState extends MetalPricesState {
  MetalPricesResponse response;

  LoadedMetalPricesState({this.response});
}

class FailedMetalPricesState extends MetalPricesState {}
