import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/models/roomStatus.dart';
import 'package:quizzy/providers/room_provider.dart';
import 'package:quizzy/providers/user_provider.dart';
import 'package:quizzy/services/room_service.dart';
import 'package:quizzy/services/user_service.dart';
import 'package:quizzy/utils/generation.dart';

final gameControllerProvider = Provider((ref) {
  return GameController(ref);
});

class GameController {
  final Ref ref;
  GameController(this.ref);


  Future<void> createGame({required String name,required int avatarId,int maxPlayers=4}) async {
    final roomId=generateFourDigitNumber();
    final player=await createPlayer({
      'name': name,
      'avatar_id': avatarId,
      'status': true,
    });

    final room= await createRoom({
      'room_code': roomId,
      'host_user_id': player.id,
      'status': RoomStatus.waiting.name,
      'max_players': maxPlayers,
      'current_question': 0,
    });
    await joinRoom(roomId, player.id);
    ref.read(userProvider.notifier).setUser(player);
    ref.read(roomProvider.notifier).setRoom(room);
  }

}