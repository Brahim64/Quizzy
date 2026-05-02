import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnlinePlayersWidget extends StatelessWidget {
  final int roomCode;

  const OnlinePlayersWidget({super.key, required this.roomCode});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

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
              leading: const Icon(Icons.circle, color: Colors.green),
              title: Text(player['name'] ?? 'Unknown'),
              subtitle: Text('Online'),
            );
          },
        );
      },
    );
  }
}