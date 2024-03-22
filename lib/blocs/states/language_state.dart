import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final String currentLanguage;

  const LanguageState({required this.currentLanguage});

  @override
  List<Object> get props => [currentLanguage];
}
