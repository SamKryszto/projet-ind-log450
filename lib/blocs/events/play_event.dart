import 'package:equatable/equatable.dart';
import 'package:projet_ind_log450/models/letter.dart';

abstract class PlayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStartedEvent extends PlayEvent {}

class RemoveLetterEvent extends PlayEvent {}

class LetterAddedEvent extends PlayEvent {
  final String letter;

  LetterAddedEvent({required this.letter});

  @override
  List<Object?> get props => [letter];
}

class WordUpdatedEvent extends PlayEvent {
  final List<Letter> updatedWord;

  WordUpdatedEvent(this.updatedWord);

  @override
  List<Object?> get props => [updatedWord];
}

class TimerTickedEvent extends PlayEvent {}

class LetterDragStartedEvent extends PlayEvent {
  final Letter letter;
  final int startIndex;

  LetterDragStartedEvent({required this.letter, required this.startIndex});

  @override
  List<Object?> get props => [letter, startIndex];
}

class LetterDragCompletedEvent extends PlayEvent {
  final Letter letter;
  final int startIndex;
  final int endIndex;

  LetterDragCompletedEvent({
    required this.letter,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  List<Object?> get props => [letter, startIndex, endIndex];
}

class TimerCanceledEvent extends PlayEvent {}

