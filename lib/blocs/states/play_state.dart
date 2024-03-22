import 'package:equatable/equatable.dart';
import '../../models/letter.dart'; // Make sure this path matches the location of your Letter model

abstract class PlayState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayInitialState extends PlayState {
  final List<Letter> modifiedWord;
  final int remainingTime;

  PlayInitialState({
    required this.modifiedWord,
    required this.remainingTime,
  });

  @override
  List<Object?> get props => [modifiedWord, remainingTime];
}

class PlayInProgressState extends PlayState {
  final List<Letter> modifiedWord;
  final int remainingTime;

  PlayInProgressState({
    required this.modifiedWord,
    required this.remainingTime,
  });

  @override
  List<Object?> get props => [modifiedWord, remainingTime];
}

