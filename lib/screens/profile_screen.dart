import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import '../services/service_locator.dart';
import '../blocs/profile/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authService = locator<AuthService>();

        final cubit = ProfileCubit();
        if (authService.isLoggedIn) {
          cubit.updateName(authService.currentUserName ?? 'Пользователь');
        }
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Мой профиль')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.person, size: 50, color: Colors.white),
                                ),
                                const SizedBox(height: 16),
                                Text(state.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Используем state.name
                                const SizedBox(height: 4),
                                const Text('Участник фитнес сообщества', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildProfileStat(state.workoutCount.toString(), 'Тренировок'), // Используем state.workoutCount
                                    _buildProfileStat(state.dayCount.toString(), 'Дней'), // Используем state.dayCount
                                    _buildProfileStat(state.achievementCount.toString(), 'Достижений'), // Используем state.achievementCount
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              _buildSettingsItem(Icons.person, 'Редактировать профиль', 'Изменить имя и данные', context), // Передаем context
                              _buildSettingsItem(Icons.notifications, 'Уведомления', 'Настройка оповещений', context), // Передаем context
                              _buildSettingsItem(Icons.settings, 'Настройки', 'Настройки приложения', context), // Передаем context
                              _buildSettingsItem(Icons.help, 'Помощь', 'Часто задаваемые вопросы', context), // Передаем context
                              _buildSettingsItem(Icons.info, 'О приложении', 'Версия 1.0.0', context), // Передаем context
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _logout(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Выйти из аккаунта'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Добавлен BlocListener для обработки событий логаута
            BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // Предположим, что после logout() в Cubit устанавливается пустое имя
                if (state.name.isEmpty) {
                  context.go('/auth');
                }
              },
              child: const SizedBox.shrink(), // Пустой виджет, так как логика в listener
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Text(label),
      ],
    );
  }

  // Исправленная функция _buildSettingsItem с 4 аргументами
  Widget _buildSettingsItem(IconData icon, String title, String subtitle, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Пример действия: открытие экрана редактирования профиля
        if (title == 'Редактировать профиль') {
          // Открываем диалоговое окно для изменения имени
          _showEditNameDialog(context);
        }
        // Здесь можно добавить логику для других пунктов
      },
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final nameController = TextEditingController(text: context.read<ProfileCubit>().state.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактировать имя'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Введите новое имя"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  context.read<ProfileCubit>().updateName(newName);
                  // Обновляем имя в AuthService
                  final authService = locator<AuthService>();
                  if (authService.isLoggedIn) {
                    // В текущей реализации AuthService не изменяет имя напрямую.
                    // Мы синхронизируем состояние Cubit с AuthService при инициализации.
                    // Для полной синхронизации, AuthService должен иметь метод updateName.
                  }
                }
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }


  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Вызов метода logout в Cubit
                context.read<ProfileCubit>().logout();
                // Навигация будет выполнена в BlocListener выше
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Выйти'),
            ),
          ],
        );
      },
    );
  }
}