import 'package:quizzy/models/roomStatus.dart';

class Room {
  final String id;
  final int roomCode;
  final String hostUserId;
  final int maxPlayers;
  final RoomStatus status;
  final int currentQuestion;
  final DateTime createdAt ;
  final DateTime? startedAt ;
  final DateTime? endedAt ;

  Room({
    required this.id,
    required this.roomCode,
    required this.hostUserId,
    required this.maxPlayers,
    required this.status,
    required this.currentQuestion,
    required this.createdAt,
    this.startedAt,
    this.endedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as String,
      roomCode: json['room_code'] as int,
      hostUserId: json['host_user_id'] as String,
      maxPlayers: json['max_players'] as int,
      status: RoomStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => RoomStatus.waiting,
      ),
      currentQuestion: json['current_question'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      endedAt: json['ended_at'] != null
          ? DateTime.parse(json['ended_at'])
          : null,
    );
  }

}