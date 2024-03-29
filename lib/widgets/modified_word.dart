import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/blocs/play_bloc.dart'; // Adjust the import path as necessary
import 'package:projet_ind_log450/blocs/events/play_event.dart'; // Adjust the import path as necessary
import 'package:projet_ind_log450/models/letter.dart'; // Adjust the import path as necessary

class ModifiedWord extends StatefulWidget {
  final List<Letter> modifiedWord;
  final Function(List<Letter>)
      onWordUpdated; // Callback for when the word is updated

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
      spacing: 0.0, // Keeps tiles close together
      runSpacing: 0.0, // Keeps rows close together, if Wrap is vertical
      children: widget.modifiedWord
          .asMap()
          .entries
          .map((entry) => _buildLetterTile(context, entry.key, entry.value))
          .toList(),
    );
  }

  Widget _buildLetterTile(BuildContext context, int index, Letter letter) {
    bool isFirst = index == 0;
    bool isLast = index == widget.modifiedWord.length - 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isFirst)
          _buildDragTarget(context, index - 0.5,
              true), // Enhanced target before the first letter
        Draggable<Letter>(
          data: letter,
          feedback: Material(
            child: _buildLetterVisual(letter),
            elevation: 4.0,
          ),
          childWhenDragging: Container(),
          child: _buildLetterVisual(letter),
        ),
        if (isLast)
          _buildDragTarget(context, index + 1.5,
              true), // Enhanced target after the last letter
        if (!isLast)
          _buildDragTarget(
              context, index + 0.5, false), // Normal target after the letter
      ],
    );
  }

  Widget _buildLetterVisual(Letter letter) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: letter.isCorrect ? Colors.green : Colors.blueAccent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.value.toUpperCase(),
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildDragTarget(
      BuildContext context, double targetIndex, bool isExtended) {
    return DragTarget<Letter>(
      onWillAcceptWithDetails: (data) => true,
      onAcceptWithDetails: (details) {
        final Letter letter = details.data;
        final int newIndex = (targetIndex < 0)
            ? 0
            : (targetIndex > widget.modifiedWord.length)
                ? widget.modifiedWord.length
                : targetIndex.round();
        final int oldIndex = widget.modifiedWord.indexOf(letter);

        // Adjust your logic if needed based on the newIndex calculation for extended targets
        context.read<PlayBloc>().add(LetterDragCompletedEvent(
              letter: letter,
              startIndex: oldIndex,
              endIndex: newIndex,
            ));
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: isExtended
              ? 50.0
              : 20.0, // Double size for the first and last targets
          height: 70.0,
          color: Colors
              .transparent, // Make visible for debugging or keep transparent
        );
      },
    );
  }
}
