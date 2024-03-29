class Letter {
  final String value;
  final int index;
  bool isCorrect;

  Letter({
    required this.value,
    required this.index,
    this.isCorrect = false, // Default value is false
  });
}
