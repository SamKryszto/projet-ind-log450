import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class CustomDictionaryUriChanged extends SettingsEvent {
  final String newUri;

  const CustomDictionaryUriChanged({required this.newUri});

  @override
  List<Object> get props => [newUri];
}

class LanguageSelected extends SettingsEvent {
  final String languageCode;

  const LanguageSelected({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}
