import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnlinePlayersWidget extends StatelessWidget {
  final int roomCode;

  const OnlinePlayersWidget({super.key, required this.roomCode});



  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final Map<int, String> userpics = {
      0: "assets/images/userpic1.png",
      1: "assets/images/userpic2.png",
      2: "assets/images/userpic6.png",
      3: "assets/images/userpic7.png",
      4: "assets/images/userpic8.png",
      5: "assets/images/userpic9.png",
    };
    final stream = supabase
        .from('players')
        .stream(primaryKey: ['id'])
        .eq('room_code', roomCode);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final players = snapshot.data ?? [];

        if (players.isEmpty) {
          return const Text("No players online");
        }

        return ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];

            return ListTile(
              leading: Image.asset(userpics[player['avatar_id']]!, width: 40, height: 40),
              title: Text(player['name'] ?? 'Unknown'),
              subtitle: player['status']==true ? Text('Online') :Text('Offline'),
            );
          },
        );
      },
    );
  }
}