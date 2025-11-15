import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/exercices/exercises_cubit.dart';
import '../../services/navigation_service.dart';
import 'exercise_detail_screen.dart';
import '../../blocs/exercices/exercises_cubit.dart';
import '../../models/exercise_model.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExercisesCubit()..fetchExercises(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Упражнения'),
        ),
        body: BlocBuilder<ExercisesCubit, ExercisesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...state.exercises.map((exercise) => ListTile(
                  title: Text(exercise.title),
                  subtitle: Text(exercise.description),
                  onTap: () {
                    NavigationService.pushScreen(
                      context,
                      ExerciseDetailScreen(
                        exerciseName: exercise.title,
                        muscleGroup: 'Неизвестно',
                      ),
                    );
                  },
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}