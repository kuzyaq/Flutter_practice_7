class Workout {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final String imageUrl;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.imageUrl,
    required this.exercises,
  });
}

class Exercise {
  final String id;
  final String title;
  final String description;
  final String sets;
  final String reps;
  final String restTime;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.sets,
    required this.reps,
    required this.restTime,
  });
}