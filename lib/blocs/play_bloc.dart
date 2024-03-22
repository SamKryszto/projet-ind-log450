import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/play_event.dart'; // Update this import to where your PlayEvent is located
import 'states/play_state.dart'; // Update this import to where your PlayState is located
import '../models/letter.dart'; // Update this import to where your Letter model is located

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc()
      : super(PlayInitialState(modifiedWord: [], remainingTime: 60)) {
    on<GameStartedEvent>(_onGameStarted);
    on<LetterSelectedEvent>(_onLetterSelected);
    on<TimerTickedEvent>(_onTimerTicked);
  }

  void _onGameStarted(GameStartedEvent event, Emitter<PlayState> emit) {
    // Initialize the game
    emit(PlayInitialState(modifiedWord: [], remainingTime: 60));
    // Start the timer or set up the initial word, etc.
  }

  void _onLetterSelected(LetterSelectedEvent event, Emitter<PlayState> emit) {
    if (state is PlayInProgressState) {
      // Handle the logic for when a letter is selected
      final currentState = state as PlayInProgressState;
      final modifiedWord = List<Letter>.from(currentState.modifiedWord)
        ..add(Letter(value: event.letter, index: currentState.modifiedWord.length, isStart: false));
      // ... Your logic to update the modified word
      emit(PlayInProgressState(
        modifiedWord: modifiedWord,
        remainingTime: currentState.remainingTime,
      ));
    }
  }

  void _onTimerTicked(TimerTickedEvent event, Emitter<PlayState> emit) {
    if (state is PlayInProgressState) {
      final currentState = state as PlayInProgressState;
      // Decrement the remaining time and emit a new state
      emit(PlayInProgressState(
        modifiedWord: currentState.modifiedWord,
        remainingTime: currentState.remainingTime - 1,
      ));
    }
  }
}
