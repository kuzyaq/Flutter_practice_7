import 'package:get_it/get_it.dart';
import 'auth_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
}