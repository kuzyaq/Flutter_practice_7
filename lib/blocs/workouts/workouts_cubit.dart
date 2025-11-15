import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/workout_model.dart';

class WorkoutsState {
  final List<Workout> workouts;
  final bool isLoading;

  WorkoutsState({required this.workouts, this.isLoading = false});

  WorkoutsState copyWith({List<Workout>? workouts, bool? isLoading}) {
    return WorkoutsState(
      workouts: workouts ?? this.workouts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit() : super(WorkoutsState(workouts: []));

  void loadWorkouts(List<Workout> workouts) {
    emit(WorkoutsState(workouts: workouts));
  }

  void addWorkout(Workout workout) {
    final currentWorkouts = List<Workout>.from(state.workouts);
    currentWorkouts.add(workout);
    emit(WorkoutsState(workouts: currentWorkouts));
  }

  void removeWorkout(String id) {
    final currentWorkouts = List<Workout>.from(state.workouts);
    currentWorkouts.removeWhere((workout) => workout.id == id);
    emit(WorkoutsState(workouts: currentWorkouts));
  }

  void updateWorkout(Workout updatedWorkout) {
    final currentWorkouts = List<Workout>.from(state.workouts);
    final index = currentWorkouts.indexWhere((workout) => workout.id == updatedWorkout.id);
    if (index != -1) {
      currentWorkouts[index] = updatedWorkout;
      emit(WorkoutsState(workouts: currentWorkouts));
    }
  }

  // Пример асинхронного метода, например, для загрузки с "сервера"
  Future<void> fetchWorkouts() async {
    emit(state.copyWith(isLoading: true));
    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));
    final mockWorkouts = [
      Workout(
        id: '1',
        title: 'Утренняя зарядка',
        description: 'Начните день с энергии',
        duration: '15 мин',
        difficulty: 'Легкая',
        imageUrl: '',
        exercises: [],
      ),
      Workout(
        id: '2',
        title: 'Силовая тренировка',
        description: 'Укрепление мышц',
        duration: '45 мин',
        difficulty: 'Средняя',
        imageUrl: '',
        exercises: [],
      ),
    ];
    emit(WorkoutsState(workouts: mockWorkouts, isLoading: false));
  }
}