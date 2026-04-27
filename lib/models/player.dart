class Player {
  final String id;
  final String name;
  final int avatarId;
  final bool status;
  final int score;
  final int? roomId;
  final DateTime lastSeen ;

  Player({
    required this.id,
    required this.name,
    required this.avatarId,
    required this.status,
    this.score = 0,
    this.roomId,
    required this.lastSeen
  });
  Player copyWith({int? score, DateTime? lastSeen}) {
    return Player(
      id: id,
      name: name,
      avatarId: avatarId,
      status: status,
      roomId: roomId,
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
      roomId: json['room_id'],
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
      'room_id': roomId,
      'last_seen': lastSeen.toIso8601String()
    };
  }
}