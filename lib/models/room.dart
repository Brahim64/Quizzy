import 'package:quizzy/models/player.dart';

class Room {
  final String id;
  final String hostId;
  final String status;
  final int currentQuestionIndex;
  final DateTime createdAt ;

  Room({
    required this.id,
    required this.hostId,
    required this.status,
    required this.currentQuestionIndex,
    required this.createdAt
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      hostId: json['host_id'],
      status: json['status'],
      currentQuestionIndex: json['current_question_index'] ?? 0,
        createdAt: DateTime.parse(json['last_seen']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host_id': hostId,
      'status': status,
      'current_question_index': currentQuestionIndex,
    };
  }
}