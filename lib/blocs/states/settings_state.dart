import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  final String selectedLanguage;
  final String customDictionaryUri;

  const SettingsState({required this.selectedLanguage, required this.customDictionaryUri});

  @override
  List<Object> get props => [selectedLanguage, customDictionaryUri];
}


class SettingsInitial extends SettingsState {
  const SettingsInitial({String selectedLanguage = 'English', String customDictionaryUri = ''})
      : super(selectedLanguage: selectedLanguage, customDictionaryUri: customDictionaryUri);
}

class SettingsUpdated extends SettingsState {
  const SettingsUpdated({required String selectedLanguage, required String customDictionaryUri})
      : super(selectedLanguage: selectedLanguage, customDictionaryUri: customDictionaryUri);
}

