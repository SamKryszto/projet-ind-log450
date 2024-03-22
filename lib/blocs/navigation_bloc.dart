import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent { toHome, toGame, toScore }
enum NavigationState { home, game, score }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.home);

  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.toHome:
        yield NavigationState.home;
        break;
      case NavigationEvent.toGame:
        yield NavigationState.game;
        break;
      case NavigationEvent.toScore:
        yield NavigationState.score;
        break;
    }
  }
}
