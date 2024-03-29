import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/blocs/play_bloc.dart'; // Adjust the import path as necessary
import 'package:projet_ind_log450/blocs/events/play_event.dart'; // Adjust the import path as necessary
import 'package:projet_ind_log450/models/letter.dart'; // Adjust the import path as necessary

class ModifiedWord extends StatefulWidget {
  final List<Letter> modifiedWord;
  final Function(List<Letter>) onWordUpdated; // Callback for when the word is updated


  const ModifiedWord({
    Key? key,
    required this.modifiedWord,
    required this.onWordUpdated,

  }) : super(key: key);

  @override
  State<ModifiedWord> createState() => _ModifiedWordState();
}

class _ModifiedWordState extends State<ModifiedWord> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.modifiedWord
          .asMap()
          .entries
          .map((entry) => _buildLetterTile(context, entry.key, entry.value))
          .toList(),
    );
  }

  Widget _buildLetterTile(BuildContext context, int index, Letter letter) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDragTarget(context, index - 0.5), // Target before the letter
        Draggable<Letter>(
          data: letter,
          feedback: Material(
            child: _buildLetterVisual(letter),
            elevation: 4.0,
          ),
          childWhenDragging: Container(),
          child: _buildLetterVisual(letter),
          onDragCompleted: () {}, // Prevents the disappearance on drop
        ),
        _buildDragTarget(context, index + 0.5), // Target after the letter
      ],
    );
  }

  Widget _buildLetterVisual(Letter letter) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: letter.isCorrect ? Colors.green : Colors.blueAccent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.value.toUpperCase(),
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Widget _buildDragTarget(BuildContext context, double targetIndex) {
  return DragTarget<Letter>(
    onWillAcceptWithDetails: (data) => true,
    onAcceptWithDetails: (details) {
      final Letter letter = details.data; // Extract the letter from details
      final newIndex = targetIndex.round();
      // You might have intended to find the old index from the list, but
      // DragTargetDetails doesn't directly give you the old index.
      // You'll need a way to track the dragged Letter's original index if it's not part of the Letter model.
      final oldIndex = widget.modifiedWord.indexOf(letter);

      context.read<PlayBloc>().add(LetterDragCompletedEvent(
        letter: letter,
        startIndex: oldIndex,
        endIndex: newIndex,
      ));
    },
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 8.0,
        height: 48.0,
        color: Colors.transparent, // For debugging, you can temporarily change this to a visible color
      );
    },
  );
}

}
