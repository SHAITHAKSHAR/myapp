class Challenge {
  final String id;
  final String title;
  final String description;
  final int goal;
  final int reward;
  int progress;
  bool isCompleted;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.reward,
    this.progress = 0,
    this.isCompleted = false,
  });
}
