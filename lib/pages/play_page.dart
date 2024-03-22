import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/widgets/modified_word.dart';
import '../blocs/play_bloc.dart';
import '../blocs/events/play_event.dart';
import '../blocs/states/play_state.dart';
import '../models/letter.dart';
import '../widgets/alphabet.dart';

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PlayBloc, PlayState>(
        builder: (context, state) {
          if (state is PlayInitialState) {
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
                        state.startWord, // Using state
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10), // Add some spacing between the words
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(width: 10), // Add some spacing between the arrow and the word
                      Text(
                        state.endWord, // Using state
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
                        '${state.remainingTime} s', // Using state
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ModifiedWord
                Expanded(
                  child: ModifiedWord(
                    modifiedWord: state.modifiedWord, // Using state
                    onLetterAdded: (Letter letter, int index) {
                      // This needs to be implemented based on your game logic
                    },
                  ),
                ),
                // Add padding at the bottom
                SizedBox(height: 16.0),
                // Alphabet
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Alphabet(
                    onLetterSelected: (String letter) {
                      BlocProvider.of<PlayBloc>(context).add(LetterSelected(letter));
                    },
                    allLettersGreen: state.blueLetter, // Using state
                    updateAlphabetState: () {
                      // This might be triggered by state updates based on game logic
                    },
                  ),
                ),
              ],
            );
          } else {
            // Placeholder for other states or return an appropriate widget
            return Center(child: Text('Game State Not Handled'));
          }
        },
      ),
    );
  }
}
