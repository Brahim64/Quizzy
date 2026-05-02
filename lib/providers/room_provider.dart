import 'package:flutter_riverpod/legacy.dart';
import 'package:quizzy/models/room.dart';

class RoomNotifier extends StateNotifier<Room?>{
  RoomNotifier():super(null);
  Future<void> setRoom(Room room)async{
    state=room;
  }

  Future<void> clearRoom()async{
    state=null;
  }


}

final roomProvider=
    StateNotifierProvider<RoomNotifier,Room?>(
        (ref)=>RoomNotifier()
    );