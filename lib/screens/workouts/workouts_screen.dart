import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/navigation_service.dart';
import 'workout_detail_screen.dart';
import 'create_workout_screen.dart';
import '../../blocs/workouts/workouts_cubit.dart';
import '../../models/workout_model.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutsCubit()..fetchWorkouts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Мои тренировки'),
        ),
        body: BlocBuilder<WorkoutsCubit, WorkoutsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state.workouts.map((workout) => _buildWorkoutCard(
                context,
                workout.title,
                '${workout.duration} • ${workout.difficulty}',
                workout.description,
                _getIconForWorkout(workout.title),
                _getColorForWorkout(workout.title),
                workout.id, // Передаем ID для удаления
              )).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final createdWorkout = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateWorkoutScreen()),
            );
            if (createdWorkout != null) {
              context.read<WorkoutsCubit>().addWorkout(createdWorkout);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, String title, String duration, String description, IconData icon, Color color, String id) {
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
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              context.read<WorkoutsCubit>().removeWorkout(id);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'delete', child: Text('Удалить')),
          ],
        ),
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

  IconData _getIconForWorkout(String title) {
    if (title.toLowerCase().contains('зарядка')) return Icons.wb_sunny;
    if (title.toLowerCase().contains('силовая')) return Icons.fitness_center;
    if (title.toLowerCase().contains('кардио')) return Icons.directions_run;
    if (title.toLowerCase().contains('йога')) return Icons.self_improvement;
    return Icons.fitness_center;
  }

  Color _getColorForWorkout(String title) {
    if (title.toLowerCase().contains('зарядка')) return Colors.orange;
    if (title.toLowerCase().contains('силовая')) return Colors.red;
    if (title.toLowerCase().contains('кардио')) return Colors.green;
    if (title.toLowerCase().contains('йога')) return Colors.purple;
    return Colors.blue;
  }
}