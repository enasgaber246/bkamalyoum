import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(LoadedMenuState());

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is LoadMenuEvent) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      yield LoadedMenuState(prefs: prefs);
    }
  }
}

// Event
abstract class MenuEvent {}

class LoadMenuEvent extends MenuEvent {
  LoadMenuEvent();
}

// Trip Details States
abstract class MenuState {}


class LoadedMenuState extends MenuState {
  final SharedPreferences prefs;

  LoadedMenuState({this.prefs});
}
