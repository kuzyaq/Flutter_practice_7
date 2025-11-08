import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';
import 'exercise_detail_screen.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Упражнения'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExerciseCategory(
            context,
            'Грудь',
            Icons.fitness_center,
            Colors.red,
            ['Жим штанги лежа', 'Разведение гантелей', 'Отжимания', 'Жим в тренажере'],
          ),
          _buildExerciseCategory(
            context,
            'Ноги',
            Icons.directions_run,
            Colors.green,
            ['Приседания', 'Выпады', 'Становая тяга', 'Подъем на носки'],
          ),
          _buildExerciseCategory(
            context,
            'Спина',
            Icons.accessibility,
            Colors.blue,
            ['Тяга верхнего блока', 'Тяга штанги в наклоне', 'Гиперэкстензия', 'Подтягивания'],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCategory(BuildContext context, String category, IconData icon, Color color, List<String> exercises) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: color),
        title: Text(
          category,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: exercises.map((exercise) => ListTile(
          leading: const Icon(Icons.play_circle_outline, color: Colors.green),
          title: Text(exercise),
          trailing: const Icon(Icons.info_outline),
          onTap: () {
            // СТРАНИЧНАЯ НАВИГАЦИЯ - вертикальный переход к деталям упражнения
            NavigationService.pushScreen(
              context,
              ExerciseDetailScreen(
                exerciseName: exercise,
                muscleGroup: category,
              ),
            );
          },
        )).toList(),
      ),
    );
  }
}