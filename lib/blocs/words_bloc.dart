import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class WordsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWords extends WordsEvent {}

// State
abstract class WordsState extends Equatable {
  @override
  List<Object> get props => [];
}

class WordsInitial extends WordsState {}

class WordsLoaded extends WordsState {
  final List<String> words;

  WordsLoaded({required this.words});

  @override
  List<Object> get props => [words];
}

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(WordsInitial()) {
    on<FetchWords>((event, emit) {
      // Ideally, fetch words from a repository or a service
      List<String> words = ['pan', 'plan', 'plant', 'plante', 'planter'];
      emit(WordsLoaded(words: words));
    });
  }
}
