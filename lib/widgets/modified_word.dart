import 'package:flutter/material.dart';
import 'package:projet_ind_log450/models/letter.dart';

class ModifiedWord extends StatelessWidget {
  final List<Letter> modifiedWord;
  final Function(Letter, int) onLetterAdded;

  const ModifiedWord({
    Key? key,
    required this.modifiedWord,
    required this.onLetterAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 8.0, // space between letters
        children: modifiedWord.map((letter) => _buildLetterTile(letter)).toList(),
      ),
    );
  }

  Widget _buildLetterTile(Letter letter) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.value.toUpperCase(),
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
