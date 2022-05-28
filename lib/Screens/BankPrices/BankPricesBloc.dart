import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BankPricesResponse.dart';

class BankPricesBloc extends Bloc<BankPricesEvent, BankPricesState> {
  BankPricesBloc() : super(LoadingBankPricesState());

  @override
  Stream<BankPricesState> mapEventToState(BankPricesEvent event) async* {
    if (event is LoadBankPricesEvent) {
      yield LoadingBankPricesState();

      //String token = await FlutterSession().get("token") ?? '';
      final body = {
        'currency': event.id?.toString() ?? '',
      };
      // if (event.id != null) {
      //   body['currency'] = event.id.toString();
      // }else{
      //   body['currency'] = '2';
      // }

      print('LoadBankPricesEvent Body :  ${body.toString()}');

      // final jsonString = json.encode(body);
      String baseUrl = 'https://bkamalyoum.com/api/';
      var res = await http.post('${baseUrl}currency/prices', body: body);

      try {
        final data = jsonDecode(res.body) as Map<String, dynamic>;

        print('LoadBankPricesEvent Response :  ${data.toString()}');
        BankPricesResponse response = BankPricesResponse.fromJson(data);

        if (response.ecode == 200) {
          yield LoadedBankPricesState(response: response);
        } else {
          yield FailedBankPricesState();
        }
      } catch (e) {
        print('LoadCurrencyEvent Error :  ' + e.toString());
        yield FailedBankPricesState();
      }
    }
  }
}

// Event
abstract class BankPricesEvent {}

class LoadBankPricesEvent extends BankPricesEvent {
  final int id;

  LoadBankPricesEvent({this.id});
}

// Trip Details States
abstract class BankPricesState {}

class LoadingBankPricesState extends BankPricesState {}

class LoadedBankPricesState extends BankPricesState {
  BankPricesResponse response;

  LoadedBankPricesState({this.response});
}

class FailedBankPricesState extends BankPricesState {}
