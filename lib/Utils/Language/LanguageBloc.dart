import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class LanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  LanguageBloc() : super(InitialAppLanguageState());

  @override
  Stream<AppLanguageState> mapEventToState(AppLanguageEvent event) async* {
    if (event is ChangeAppLanguageEvent) {

      if (event.newAppLanguage == 'en') {
        print("en to ar");
        await FlutterSession().set("langu", "en");
        translator.setNewLanguage(
          event.mContext,
          newLanguage: 'en',
          restart: true,
          remember: true,
        );

        yield EnglishAppLanguageState();
      } else {
        await FlutterSession().set("langu", "ar");
        translator.setNewLanguage(
          event.mContext,
          newLanguage: 'ar',
          restart: true,
          remember: true,
        );

        yield ArabicAppLanguageState();
      }
    }
  }
}

// Event
abstract class AppLanguageEvent {}

class ChangeAppLanguageEvent extends AppLanguageEvent {
  String newAppLanguage = '';
  BuildContext mContext;

  ChangeAppLanguageEvent(this.mContext, this.newAppLanguage);
}

// States
abstract class AppLanguageState {}

class InitialAppLanguageState extends AppLanguageState {}

class EnglishAppLanguageState extends AppLanguageState {}

class ArabicAppLanguageState extends AppLanguageState {}
