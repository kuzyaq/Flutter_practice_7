import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Добавлен импорт
import 'package:go_router/go_router.dart';
import 'services/service_locator.dart';
import 'services/auth_service.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/workouts/workouts_screen.dart';
import 'screens/exercises/exercises_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/profile_screen.dart';
import 'blocs/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver(); 
  setupLocator();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Фитнес Трекер',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


AuthService get _authService => locator<AuthService>();

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return _authService.isLoggedIn ? '/home' : '/auth';
      },
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainAppScreen(currentIndex: 0),
    ),
    GoRoute(
      path: '/workouts',
      builder: (context, state) => const MainAppScreen(currentIndex: 1),
    ),
    GoRoute(
      path: '/exercises',
      builder: (context, state) => const MainAppScreen(currentIndex: 2),
    ),
    GoRoute(
      path: '/progress',
      builder: (context, state) => const MainAppScreen(currentIndex: 3),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainAppScreen(currentIndex: 4),
    ),
  ],
);

class MainAppScreen extends StatefulWidget {
  final int currentIndex;
  const MainAppScreen({super.key, required this.currentIndex});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const WorkoutsScreen();
      case 2:
        return const ExercisesScreen();
      case 3:
        return const ProgressScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Маршрутизированная навигация между основными экранами
          final routes = ['/home', '/workouts', '/exercises', '/progress', '/profile'];
          context.go(routes[index]);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Тренировки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics),
            label: 'Упражнения',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Прогресс',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}