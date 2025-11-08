import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';
import 'workout_detail_screen.dart';
import 'create_workout_screen.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои тренировки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWorkoutCard(
            context,
            'Утренняя зарядка',
            '15 минут • Легкая',
            'Начните день с энергии',
            Icons.wb_sunny,
            Colors.orange,
          ),
          _buildWorkoutCard(
            context,
            'Силовая тренировка',
            '45 минут • Средняя',
            'Укрепление мышц',
            Icons.fitness_center,
            Colors.red,
          ),
          _buildWorkoutCard(
            context,
            'Кардио тренировка',
            '30 минут • Высокая',
            'Сжигание калорий',
            Icons.directions_run,
            Colors.green,
          ),
          _buildWorkoutCard(
            context,
            'Йога и растяжка',
            '20 минут • Легкая',
            'Гибкость и релаксация',
            Icons.self_improvement,
            Colors.purple,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // СТРАНИЧНАЯ НАВИГАЦИЯ - вертикальный переход к созданию тренировки
          NavigationService.pushScreen(
            context,
            const CreateWorkoutScreen(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, String title, String duration, String description, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(duration),
            Text(description, style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // СТРАНИЧНАЯ НАВИГАЦИЯ - вертикальный переход к деталям тренировки
          NavigationService.pushScreen(
            context,
            WorkoutDetailScreen(
              workoutTitle: title,
              workoutDescription: description,
              icon: icon,
              color: color,
            ),
          );
        },
      ),
    );
  }
}