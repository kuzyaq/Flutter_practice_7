import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/service_locator.dart';
import '../../services/auth_service.dart';

class ProfileState {
  final String name;
  final int workoutCount;
  final int dayCount;
  final int achievementCount;

  ProfileState({
    required this.name,
    required this.workoutCount,
    required this.dayCount,
    required this.achievementCount,
  });

  ProfileState copyWith({
    String? name,
    int? workoutCount,
    int? dayCount,
    int? achievementCount,
  }) {
    return ProfileState(
      name: name ?? this.name,
      workoutCount: workoutCount ?? this.workoutCount,
      dayCount: dayCount ?? this.dayCount,
      achievementCount: achievementCount ?? this.achievementCount,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(name: '', workoutCount: 0, dayCount: 0, achievementCount: 0));

  void updateName(String newName) {
    emit(state.copyWith(name: newName));
  }

  void incrementWorkoutCount() {
    emit(state.copyWith(workoutCount: state.workoutCount + 1));
  }

  // Метод для логаута
  void logout() {
    // Сбрасываем локальное состояние
    emit(ProfileState(name: '', workoutCount: 0, dayCount: 0, achievementCount: 0));
    // Вызываем глобальный логаут
    if (locator.isRegistered<AuthService>()) {
      locator<AuthService>().logout();
    }
  }
}