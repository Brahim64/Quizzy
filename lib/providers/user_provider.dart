import 'package:flutter_riverpod/legacy.dart';
import '../models/player.dart';


class UserNotifier extends StateNotifier<Player?> {
  UserNotifier() : super(null);


  Future<void> setUser(Player user) async {
    state = user;
  }

  Future<void> clearUser() async {
    state = null;
  }
}

final userProvider =
StateNotifierProvider<UserNotifier, Player?>(
        (ref) => UserNotifier());