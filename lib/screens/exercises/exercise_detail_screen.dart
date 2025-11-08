import 'package:flutter/material.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String exerciseName;
  final String muscleGroup;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseName,
    required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение упражнения
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.fitness_center, size: 80, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Информация об упражнении
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exerciseName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Группа мышц: $muscleGroup',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Описание упражнения:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Это упражнение направлено на развитие целевой группы мышц. '
                          'Выполняйте его с правильной техникой для максимальной эффективности '
                          'и предотвращения травм.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Техника выполнения
            const Text(
              'Техника выполнения:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTechniqueStep('1. Исходное положение', 'Займите правильное исходное положение'),
            _buildTechniqueStep('2. Выполнение', 'Медленно и контролируемо выполните движение'),
            _buildTechniqueStep('3. Возврат', 'Вернитесь в исходное положение'),

            const SizedBox(height: 20),

            // Рекомендации
            const Text(
              'Рекомендации:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildRecommendation('Подходы: 3-4'),
            _buildRecommendation('Повторения: 8-12'),
            _buildRecommendation('Отдых: 60-90 секунд'),
          ],
        ),
      ),
    );
  }

  Widget _buildTechniqueStep(String step, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.check, color: Colors.white, size: 16),
        ),
        title: Text(step, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildRecommendation(String text) {
    return ListTile(
      leading: const Icon(Icons.arrow_forward_ios, size: 16),
      title: Text(text),
    );
  }
}