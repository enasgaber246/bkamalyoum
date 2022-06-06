import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BankPricesResponse.dart';

class BankPricesBloc extends Bloc<BankPricesEvent, BankPricesState> {
  BankPricesBloc() : super(LoadingBankPricesState());
  BankPricesResponse _bankPricesResponse;

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

        response.ebody = response.ebody
            .where((i) => (i.buyingPrice != null && i.sellingPrice != null))
            .toList();

        _bankPricesResponse = response;

        if (_bankPricesResponse.ecode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          yield LoadedBankPricesState(
              response: _bankPricesResponse, prefs: prefs);
        } else {
          yield FailedBankPricesState();
        }
      } catch (e) {
        print('LoadCurrencyEvent Error :  ' + e.toString());
        yield FailedBankPricesState();
      }
    } else if (event is RearrangeBankPricesEvent) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event.id == 1) {
        // 1 Buying large first
        _bankPricesResponse.ebody.sort((b, a) =>
            double.parse(b.buyingPrice ?? '0')
                .compareTo(double.parse(a.buyingPrice) ?? '0'));
      } else if (event.id == 2) {
        // 2 Buying small first
        _bankPricesResponse.ebody.sort((a, b) =>
            double.parse(b.buyingPrice ?? '0')
                .compareTo(double.parse(a.buyingPrice) ?? '0'));
      } else if (event.id == 3) {
        // 3 Selling large first
        _bankPricesResponse.ebody.sort((b, a) =>
            double.parse(b.sellingPrice ?? '0')
                .compareTo(double.parse(a.sellingPrice) ?? '0'));
      } else {
        // 4 Selling small first
        _bankPricesResponse.ebody.sort((a, b) =>
            double.parse(b.sellingPrice ?? '0')
                .compareTo(double.parse(a.sellingPrice) ?? '0'));
      }

      yield LoadedBankPricesState(response: _bankPricesResponse, prefs: prefs);
    }
  }
}

// Event
abstract class BankPricesEvent {}

class LoadBankPricesEvent extends BankPricesEvent {
  final int id;

  // 1 Buying large first
  // 2 Buying small first
  // 3 Selling large first
  // 4 Selling small first

  LoadBankPricesEvent({this.id});
}

class RearrangeBankPricesEvent extends BankPricesEvent {
  final int id;

  RearrangeBankPricesEvent({this.id});
}

// Trip Details States
abstract class BankPricesState {}

class LoadingBankPricesState extends BankPricesState {}

class LoadedBankPricesState extends BankPricesState {
  BankPricesResponse response;
  SharedPreferences prefs;

  LoadedBankPricesState({
    this.response,
    this.prefs,
  });
}

class FailedBankPricesState extends BankPricesState {}
