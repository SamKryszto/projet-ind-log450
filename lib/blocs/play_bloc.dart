import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/language_bloc.dart'; // Import the path correctly
import 'events/play_event.dart'; // Update this import to where your PlayEvent is located
import 'states/play_state.dart'; // Update this import to where your PlayState is located
import '../models/letter.dart'; // Update this import to where your Letter model is located
import 'package:flutter/services.dart' show rootBundle;


class PlayBloc extends Bloc<PlayEvent, PlayState> {
  Timer? _timer;
  final LanguageBloc languageBloc;
  PlayBloc({required this.languageBloc})
      : super(PlayInitialState(
            modifiedWord: [],
            remainingTime: 30,
            startWord: "",
            endWord: "",
            allLettersGreen: true,
            validWords: [])) {
    on<GameStartedEvent>(_onGameStarted);
    on<LetterAddedEvent>(_onLetterAdded);
    on<TimerTickedEvent>(_onTimerTicked);
    on<LetterDragStartedEvent>(_onLetterDragStarted);
    on<LetterDragCompletedEvent>(_onLetterDragCompleted);
    on<RemoveLetterEvent>(_onRemoveLetter);
  }

  Future<void> _onGameStarted(GameStartedEvent event, Emitter<PlayState> emit) async {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        add(TimerTickedEvent());
    });

    String currentLanguage = languageBloc.state.currentLanguage;

    /// Determine the correct path for the dictionary file
    String dictionaryPath = (currentLanguage == "fr") 
        ? 'dictionaries/french_dictionary.csv' 
        : 'dictionaries/english_dictionary.csv';

    // Load the dictionary content using rootBundle
    String dictionaryContent = await rootBundle.loadString(dictionaryPath);
    List<String> lines = dictionaryContent.trim().split('\n');

    // Filter out empty lines
    List<String> nonEmptyLines = lines.where((line) => line.trim().isNotEmpty).toList();

    if (nonEmptyLines.isEmpty) {
        // Handle the case where no non-empty lines are found
        print('No non-empty lines found in the dictionary.');
        return; // Exit the function or use a fallback approach
    }

    Random random = Random();
    // Select a random non-empty line
    List<String> validWords = nonEmptyLines[random.nextInt(nonEmptyLines.length)].split(',');

    // Clean the words list from empty entries and trim each word
    validWords = validWords.where((word) => word.trim().isNotEmpty).map((word) => word.trim()).toList();

    // Ensure there's at least one word in validWords before proceeding
    if (validWords.isEmpty) {
        print('Selected line is empty after trimming.');
        return; // Exit the function or use a fallback approach
    }

    // Set startWord and endWord from the validWords list
    String startWord = validWords.first;
    String endWord = validWords.last;

    // Map the startWord to List<Letter>
    List<Letter> initialWord = startWord.split('').asMap().entries.map((entry) {
        return Letter(value: entry.value, index: entry.key, isCorrect: true);
    }).toList();

    emit(PlayInitialState(
        modifiedWord: initialWord,
        remainingTime: 30,
        startWord: startWord,
        endWord: endWord,
        allLettersGreen: true,
        validWords: validWords));
}


  void _onLetterDragStarted(
      LetterDragStartedEvent event, Emitter<PlayState> emit) {
    // This might not need to change the state but is here if you need to react to the start of a drag.
  }

  void _onLetterDragCompleted(
      LetterDragCompletedEvent event, Emitter<PlayState> emit) {
    final currentState = state;
    List<Letter> modifiedWord = List<Letter>.from(currentState.modifiedWord);
    Letter letterToMove = modifiedWord.firstWhere(
        (letter) => letter == event.letter,
        orElse: () => Letter(value: '', index: 0, isCorrect: false));

    if (letterToMove.value != '') {
      modifiedWord.remove(letterToMove);
      if (event.endIndex >= modifiedWord.length) {
        modifiedWord.add(
            letterToMove); // Add to the end if the index exceeds the list size
      } else {
        modifiedWord.insert(
            event.endIndex, letterToMove); // Insert at specific index
      }

      final newWord = modifiedWord.map((l) => l.value).join('');
      final isValid = currentState.validWords.contains(newWord);

      if (isValid) {
        modifiedWord.forEach((letter) {
          letter.isCorrect =
              isValid; // Update correctness based on the new word
        });
      }

      if (checkWinCondition(modifiedWord, currentState.endWord)) {
        _timer?.cancel();
        emit(WonGameState(
          modifiedWord: currentState.modifiedWord,
          remainingTime: currentState.remainingTime,
          startWord: currentState.startWord,
          endWord: currentState.endWord,
          allLettersGreen: true,
          validWords: currentState.validWords,
        ));
      } else {
        emit(currentState.copyWith(
          modifiedWord: modifiedWord,
          allLettersGreen: modifiedWord.every((letter) => letter.isCorrect),
        ));
      }
    }
  }

  void _onLetterAdded(LetterAddedEvent event, Emitter<PlayState> emit) {
    final currentState = state;
    List<Letter> modifiedWord = List<Letter>.from(currentState.modifiedWord);

    // Potential new word with the new letter added
    String newModifiedWordStr =
        modifiedWord.map((l) => l.value).join('') + event.letter;

    // Determine if the new letter makes the modified word a correct prefix or a complete word
    bool isLetterCorrect = currentState.validWords
        .any((word) => word.startsWith(newModifiedWordStr));

    // Add the new letter to modifiedWord with its correctness determined
    modifiedWord.add(Letter(
        value: event.letter,
        index: modifiedWord.length,
        isCorrect: isLetterCorrect));

    // Check if all letters are correct up to the current point in the valid word
    bool allLettersGreen = modifiedWord.every((letter) => letter.isCorrect) &&
        currentState.validWords.any((word) => word == newModifiedWordStr);

    if (checkWinCondition(modifiedWord, currentState.endWord)) {
      _timer?.cancel();
      emit(WonGameState(
        modifiedWord: currentState.modifiedWord,
        remainingTime: currentState.remainingTime,
        startWord: currentState.startWord,
        endWord: currentState.endWord,
        allLettersGreen: true,
        validWords: currentState.validWords,
      ));
    } else {
      emit(PlayInProgressState(
          modifiedWord: modifiedWord,
          remainingTime: currentState.remainingTime,
          startWord: currentState.startWord,
          endWord: currentState.endWord,
          allLettersGreen: allLettersGreen,
          validWords: currentState.validWords));
    }
  }

  void _onTimerTicked(TimerTickedEvent event, Emitter<PlayState> emit) {
    final currentState = state;
    if (currentState.remainingTime > 0) {
      emit(
          currentState.copyWith(remainingTime: currentState.remainingTime - 1));
    } else {
      _timer?.cancel();
      emit(TimeUpState(
        modifiedWord: currentState.modifiedWord,
        remainingTime: currentState.remainingTime,
        startWord: currentState.startWord,
        endWord: currentState.endWord,
        allLettersGreen: true,
        validWords: currentState.validWords,
      ));
    }
  }

  void _onRemoveLetter(RemoveLetterEvent event, Emitter<PlayState> emit) {
    final currentState = state;

    // Create a new list containing only the correct letters
    List<Letter> modifiedWord =
        currentState.modifiedWord.where((letter) => letter.isCorrect).toList();

    // Emit a new state with the updated modifiedWord list
    emit(PlayInProgressState(
      modifiedWord: modifiedWord,
      remainingTime: currentState.remainingTime,
      startWord: currentState.startWord,
      endWord: currentState.endWord,
      allLettersGreen: true,
      validWords: currentState.validWords,
    ));
  }

  bool checkWinCondition(modifiedWord, endWord) {
    String word = modifiedWord.map((l) => l.value).join('');
    if (endWord == word) {
      return true;
    } else
      return false;
  }
}
