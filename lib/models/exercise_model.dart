class Exercise {
  final String id;
  final String title;
  final String description;
  final String sets; // Количество подходов
  final String reps; // Количество повторений
  final String restTime; // Время отдыха между подходами

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.sets,
    required this.reps,
    required this.restTime,
  });
}