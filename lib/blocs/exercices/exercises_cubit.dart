import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/exercise_model.dart';

class ExercisesState {
  final List<Exercise> exercises;
  final bool isLoading;

  ExercisesState({required this.exercises, this.isLoading = false});

  ExercisesState copyWith({List<Exercise>? exercises, bool? isLoading}) {
    return ExercisesState(
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit() : super(ExercisesState(exercises: []));

  void loadExercises(List<Exercise> exercises) {
    emit(ExercisesState(exercises: exercises));
  }

  void addExercise(Exercise exercise) {
    final currentExercises = List<Exercise>.from(state.exercises);
    currentExercises.add(exercise);
    emit(ExercisesState(exercises: currentExercises));
  }

  void removeExercise(String id) {
    final currentExercises = List<Exercise>.from(state.exercises);
    currentExercises.removeWhere((exercise) => exercise.id == id);
    emit(ExercisesState(exercises: currentExercises));
  }

  void updateExercise(Exercise updatedExercise) {
    final currentExercises = List<Exercise>.from(state.exercises);
    final index = currentExercises.indexWhere((exercise) => exercise.id == updatedExercise.id);
    if (index != -1) {
      currentExercises[index] = updatedExercise;
      emit(ExercisesState(exercises: currentExercises));
    }
  }

  Future<void> fetchExercises() async {
    emit(state.copyWith(isLoading: true));
    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));
    final mockExercises = [
      Exercise(
        id: '1',
        title: 'Отжимания',
        description: 'Упражнение на грудь, трицепс и плечи',
        sets: '3',
        reps: '15',
        restTime: '60',
      ),
      Exercise(
        id: '2',
        title: 'Приседания',
        description: 'Упражнение на ноги и ягодицы',
        sets: '4',
        reps: '20',
        restTime: '90',
      ),
    ];
    emit(ExercisesState(exercises: mockExercises, isLoading: false));
  }
}