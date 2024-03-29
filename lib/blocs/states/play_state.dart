import 'package:equatable/equatable.dart';
import '../../models/letter.dart'; // Make sure this path matches the location of your Letter model

abstract class PlayState extends Equatable {
  final List<Letter> modifiedWord;
  final int remainingTime;
  final String startWord;
  final String endWord;
  final bool allLettersGreen;
  final List<String> validWords;

  PlayState(
      {required this.modifiedWord,
      required this.remainingTime,
      required this.startWord,
      required this.endWord,
      required this.allLettersGreen, // Added here to be accessible in any state
      required this.validWords});

  PlayState copyWith({
    List<Letter>? modifiedWord,
    int? remainingTime,
    String? startWord,
    String? endWord,
    bool? allLettersGreen,
    List<String>? validWords,
  });

  @override
  List<Object?> get props =>
      [modifiedWord, remainingTime, startWord, endWord, allLettersGreen];
}

class PlayInitialState extends PlayState {
  PlayInitialState(
      {required List<Letter> modifiedWord,
      required int remainingTime,
      required String startWord,
      required String endWord,
      required bool allLettersGreen,
      required List<String> validWords})
      : super(
            modifiedWord: modifiedWord,
            remainingTime: remainingTime,
            startWord: startWord,
            endWord: endWord,
            allLettersGreen: allLettersGreen,
            validWords: validWords);
  @override
  PlayInitialState copyWith({
    List<Letter>? modifiedWord,
    int? remainingTime,
    String? startWord,
    String? endWord,
    bool? allLettersGreen,
    List<String>? validWords,
  }) {
    return PlayInitialState(
      modifiedWord: modifiedWord ?? this.modifiedWord,
      remainingTime: remainingTime ?? this.remainingTime,
      startWord: startWord ?? this.startWord,
      endWord: endWord ?? this.endWord,
      allLettersGreen: allLettersGreen ?? this.allLettersGreen,
      validWords: validWords ?? this.validWords,
    );
  }
}

class PlayInProgressState extends PlayState {
  PlayInProgressState(
      {required List<Letter> modifiedWord,
      required int remainingTime,
      required String startWord,
      required String endWord,
      required bool allLettersGreen,
      required List<String> validWords})
      : super(
            modifiedWord: modifiedWord,
            remainingTime: remainingTime,
            startWord: startWord,
            endWord: endWord,
            allLettersGreen: allLettersGreen,
            validWords: validWords);
  @override
  PlayInitialState copyWith({
    List<Letter>? modifiedWord,
    int? remainingTime,
    String? startWord,
    String? endWord,
    bool? allLettersGreen,
    List<String>? validWords,
  }) {
    return PlayInitialState(
      modifiedWord: modifiedWord ?? this.modifiedWord,
      remainingTime: remainingTime ?? this.remainingTime,
      startWord: startWord ?? this.startWord,
      endWord: endWord ?? this.endWord,
      allLettersGreen: allLettersGreen ?? this.allLettersGreen,
      validWords: validWords ?? this.validWords,
    );
  }
}
