import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/dialogs/time_up_dialog.dart';
import 'package:projet_ind_log450/dialogs/won_game_dialog.dart';
import 'package:projet_ind_log450/widgets/modified_word.dart';
import '../blocs/play_bloc.dart';
import '../blocs/events/play_event.dart';
import '../blocs/states/play_state.dart';
import '../models/letter.dart';
import '../widgets/alphabet.dart';



class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayBloc>().add(GameStartedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PlayBloc, PlayState>(
        builder: (context, state) {
          if (state is TimeUpState) {
            // Show the time up dialog
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TimeUpDialog(); // Your custom dialog
                },
              );
            });
          }
          if (state is WonGameState) {
            // Show the time up dialog
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return WonGameDialog(); // Your custom dialog
                },
              );
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Start and End Word Box
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.startWord,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 32.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      state.endWord,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Timer Display
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: state.remainingTime <= 10
                        ? [Colors.red, Color.fromARGB(255, 207, 124, 124)]
                        : [Colors.blue, Colors.green],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Time Remaining: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${state.remainingTime} s',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), // Centers the ModifiedWord vertically
              // ModifiedWord centered
              Center(
                // Centers the content of ModifiedWord horizontally
                child: ModifiedWord(
                  modifiedWord: state.modifiedWord,
                  onWordUpdated: (List<Letter> updatedWord) {
                    context.read<PlayBloc>().add(WordUpdatedEvent(updatedWord));
                  },
                ),
              ),
              Spacer(), // Adds symmetry to the layout
              Center(
                child: ElevatedButton(
                  onPressed: () {
                        context.read<PlayBloc>().add(RemoveLetterEvent());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (state.allLettersGreen) {
                          return Colors
                              .transparent; // Transparent button when all letters are green
                        } else {
                          return Colors.red; // Red button otherwise
                        }
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (state.allLettersGreen) {
                          return Colors
                              .transparent; // Transparent text when all letters are green
                        } else {
                          return Colors.white; // White text otherwise
                        }
                      },
                    ),
                    // Remove shadow and splash effect for transparent button
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text('Remove'),
                ),
              ),
              Spacer(), // Adds symmetry to the layout
              // Alphabet
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Alphabet(
                  onLetterAdded: (String letter) {
                    BlocProvider.of<PlayBloc>(context)
                        .add(LetterAddedEvent(letter: letter));
                  },
                  allLettersGreen: state.allLettersGreen,
                  updateAlphabetState: () {
                    // Placeholder for functionality
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
