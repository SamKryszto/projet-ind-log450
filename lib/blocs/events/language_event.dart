import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageChanged extends LanguageEvent {
  final String languageCode;

  const LanguageChanged({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}
