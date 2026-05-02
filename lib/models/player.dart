class Player {
  final String id;
  final String name;
  final int avatarId;
  final bool status;
  final int score;
  final int? roomCode;
  final DateTime lastSeen ;

  Player({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.status,
    this.score = 0,
    this.roomCode,
    required this.lastSeen
  });
  Player copyWith({int? score, DateTime? lastSeen}) {
    return Player(
      id: id,
      name: name,
      avatarId: avatarId,
      status: status,
      roomCode: roomCode,
      score: score ?? this.score,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      avatarId: json['avatar_id'],
      status: json['status'],
      score: json['score'] ?? 0,
      roomCode: json['room_code'],
      lastSeen: DateTime.parse(json['last_seen']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_id': avatarId,
      'status': status,
      'score': score,
      'room_code': roomCode,
      'last_seen': lastSeen.toIso8601String()
    };
  }
}