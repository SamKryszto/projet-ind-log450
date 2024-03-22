import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/language_event.dart';
import 'states/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(currentLanguage: 'en')) { // Default to English
    on<LanguageChanged>((event, emit) => emit(LanguageState(currentLanguage: event.languageCode)));
  }
}
