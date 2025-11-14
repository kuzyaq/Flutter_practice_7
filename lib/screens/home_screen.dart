import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/navigation_service.dart';
import 'workouts/workout_detail_screen.dart';
import '../services/app_inherited_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppInheritedState.of(context);
    final authService = appState?.authService;
    final userName = authService?.currentUserName ?? 'Пользователь';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Фитнес Трекер'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(context, userName),
            const SizedBox(height: 24),
            _buildQuickStats(),
            const SizedBox(height: 24),
            _buildRecommendedWorkouts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, String userName) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.fitness_center, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Привет, $userName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Начните свой путь к здоровому образу жизни',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/workouts'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Начать тренировку'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сегодня',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard('0', 'Тренировок', Icons.sports_gymnastics, Colors.blue),
            _buildStatCard('0', 'Калорий', Icons.local_fire_department, Colors.orange),
            _buildStatCard('0', 'Минут', Icons.timer, Colors.green),
            _buildStatCard('0', 'Шагов', Icons.directions_walk, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendedWorkouts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Рекомендуемые тренировки',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildRecommendationCard(
          context,
          'Утренняя зарядка',
          '15 минут легких упражнений для пробуждения',
          Icons.wb_sunny,
          Colors.orange,
        ),
        _buildRecommendationCard(
          context,
          'Силовая тренировка',
          '45 минут для развития силы',
          Icons.fitness_center,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // СТРАНИЧНАЯ НАВИГАЦИЯ - вертикальный переход к деталям тренировки
          NavigationService.pushScreen(
            context,
            WorkoutDetailScreen(
              workoutTitle: title,
              workoutDescription: subtitle,
              icon: icon,
              color: color,
            ),
          );
        },
      ),
    );
  }
}