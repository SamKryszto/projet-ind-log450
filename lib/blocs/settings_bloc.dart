import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/settings_event.dart';
import 'states/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitial()) {
    on<CustomDictionaryUriChanged>((event, emit) {
      // Assuming you want to retain the previous language selection
      final currentState = state;
      emit(SettingsUpdated(
        selectedLanguage: currentState.selectedLanguage,
        customDictionaryUri: event.newUri,
      ));
    });

    // Handling Language Selection changes
    on<LanguageSelected>((event, emit) {
      final currentState = state;
      // Update the state with the new language selection
      emit(SettingsUpdated(
        selectedLanguage: event.languageCode,
        customDictionaryUri: currentState.customDictionaryUri, // Retain the custom dictionary URI if any
      ));
    });
  }
}


