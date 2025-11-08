import 'package:flutter/material.dart';
import '../../services/navigation_service.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workoutTitle;
  final String workoutDescription;
  final IconData icon;
  final Color color;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutTitle,
    required this.workoutDescription,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Действие редактирования
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок тренировки
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(icon, size: 50, color: color),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workoutTitle,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            workoutDescription,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Упражнения в тренировке
            const Text(
              'Упражнения:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildExerciseItem('Отжимания', '3 подхода × 15 повторений'),
            _buildExerciseItem('Приседания', '4 подхода × 20 повторений'),
            _buildExerciseItem('Планка', '3 подхода × 60 секунд'),
            _buildExerciseItem('Берпи', '3 подхода × 10 повторений'),

            const SizedBox(height: 20),

            // Кнопка начала тренировки
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Начало тренировки
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Начать тренировку',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseItem(String name, String sets) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.play_arrow, color: Colors.green),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(sets),
        trailing: const Icon(Icons.timer),
      ),
    );
  }
}