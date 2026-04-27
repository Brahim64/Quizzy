import 'package:flutter_riverpod/legacy.dart';
import 'package:quizzy/services/user_local_storage.dart';
import '../models/player.dart';


class UserNotifier extends StateNotifier<Player?> {
  UserNotifier() : super(null);

  /// Load user from local storage
  Future<void> loadUser() async {
    final user = await UserLocalStorage.getUser();
    state = user;
  }

  /// Set user (on onboarding)
  Future<void> setUser(Player user) async {
    state = user;
    await UserLocalStorage.saveUser(user);
  }

  /// Clear user
  Future<void> clearUser() async {
    state = null;
    await UserLocalStorage.clearUser();
  }
}

final userProvider =
StateNotifierProvider<UserNotifier, Player?>(
        (ref) => UserNotifier());