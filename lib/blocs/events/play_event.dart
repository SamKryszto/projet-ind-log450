import 'package:equatable/equatable.dart';

abstract class PlayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStartedEvent extends PlayEvent {}

class LetterSelectedEvent extends PlayEvent {
  final String letter;

  LetterSelectedEvent({required this.letter});

  @override
  List<Object?> get props => [letter];
}

class TimerTickedEvent extends PlayEvent {}
