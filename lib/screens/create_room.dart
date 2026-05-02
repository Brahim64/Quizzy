import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/providers/room_provider.dart';
import 'package:quizzy/providers/user_provider.dart';
import 'package:quizzy/services/user_service.dart';
import 'package:quizzy/widgets/app_background.dart';
import 'package:quizzy/widgets/online_players.dart';

class CreateRoom extends ConsumerStatefulWidget {

  @override
  ConsumerState<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends ConsumerState<CreateRoom> {
  @override
  void initState() {
    super.initState();
    // Consume the load logic once
   // _initUser();
  }




  @override
  Widget build(BuildContext context) {
    final player = ref.watch(userProvider);
    final room=ref.watch(roomProvider);
    if (player == null) {
      return Placeholder();
    }

    return AppBackground(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50,),
        Row(
          children: [
            IconButton(onPressed: () {
              deleteAccount(player.id);
            Navigator.pop(context);
        }
        , icon: Icon(Icons.arrow_circle_left,color: Colors.white,size: 40,)),
            SizedBox(width: 20,),
            Text('Room Lobby',style: TextStyle(color: Colors.white,fontSize: 30,
                decoration: TextDecoration.none),),
          ],
        ),
        SizedBox(height: 10,),
        Padding(padding: EdgeInsetsGeometry.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              spacing: 10,
              children: [
              Text('ROOM CODE',style: TextStyle(color: Colors.grey.shade400,fontSize: 16,
                  decoration: TextDecoration.none),),
              Text(room!.roomCode.toString(),style: TextStyle(color: Colors.white,fontSize: 30,
                decoration: TextDecoration.none,fontWeight: FontWeight.bold,),),
            ],),
            OutlinedButton(onPressed: (){},style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white),), child: Row(
              spacing: 4,
              children: [
                Icon(Icons.share),
                Text('Share')
              ],
            ))
          ],

        ),),
        Center(
          child: Material(
            child: SizedBox(
              height: 300,
              width: 400,
              child: OnlinePlayersWidget(roomCode: room.roomCode),
            ),
          ),
        )

      ],

    ));
  }
}
