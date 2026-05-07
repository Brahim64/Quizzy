import 'package:flutter/material.dart';
import 'package:quizzy/models/player.dart';

class PlayerProfile extends StatefulWidget {
  
  final Player player;
  const PlayerProfile({super.key,required this.player});

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('this is the player screen'),
    );
  }
}
