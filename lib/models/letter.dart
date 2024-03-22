class Letter {
  final String value;
  final int index;
  final bool isStart;

  Letter({
    required this.value,
    required this.index,
    this.isStart = false, // Default value is false
  });
}
