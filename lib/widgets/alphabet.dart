import 'package:flutter/material.dart';

class Alphabet extends StatelessWidget {
  final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
  final Function(String) onLetterSelected;
  final bool allLettersGreen;
  final VoidCallback updateAlphabetState;
  

  Alphabet({
    Key? key,
    required this.onLetterSelected,
    required this.allLettersGreen,
    required this.updateAlphabetState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( // Wrap in a Center widget to align in the middle
      child: Wrap(
        alignment: WrapAlignment.center, // Align wrap contents to center
        spacing: 5,
        runSpacing: 5,
        children: letters.map((letter) => _buildLetterButton(letter, context)).toList(),
      ),
    );
  }

  Widget _buildLetterButton(String letter, BuildContext context) {
    return ElevatedButton(
      onPressed: allLettersGreen ? null : () => onLetterSelected(letter),
      style: ElevatedButton.styleFrom(
        backgroundColor: allLettersGreen ? Colors.grey : Colors.blue,
        shape: CircleBorder(), // Added for rounded buttons
        padding: EdgeInsets.all(16), // Padding inside the button
      ),
      child: Text(
        letter,
        style: TextStyle(color: Colors.white, fontSize: 16), // Text style with white color
      ),
    );
  }
}
