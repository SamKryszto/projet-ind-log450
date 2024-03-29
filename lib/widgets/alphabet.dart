import 'package:flutter/material.dart';

class Alphabet extends StatelessWidget {
  final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
  final Function(String) onLetterAdded;
  final bool allLettersGreen;
  final VoidCallback updateAlphabetState;
  
  Alphabet({
    Key? key,
    required this.onLetterAdded,
    required this.allLettersGreen,
    required this.updateAlphabetState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 6.0, // Adjust spacing to match ModifiedWord
        runSpacing: 6.0, // Adjust runSpacing to match ModifiedWord
        children: letters.map((letter) => _buildLetterButton(letter, context)).toList(),
      ),
    );
  }

  Widget _buildLetterButton(String letter, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4), // Margin around each tile
      child: ElevatedButton(
        onPressed: allLettersGreen ? () => onLetterAdded(letter) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: allLettersGreen ? Colors.blueAccent : Colors.grey, // Adjusted colors to match ModifiedWord
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.zero, // Remove padding to allow the Container to control the size
          // Specify minimum size to be zero to allow for smaller sizes
          minimumSize: Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimize the tap target size
        ),
        child: Container(
          width: 40, // Specified width to match ModifiedWord tiles
          height: 48, // Specified height to match ModifiedWord tiles
          alignment: Alignment.center, // Ensure the letter is centered
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
