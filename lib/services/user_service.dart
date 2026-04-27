import 'package:quizzy/core/supabase_client.dart';
import 'package:quizzy/models/player.dart';
import 'package:logger/logger.dart';
final supabase = SupabaseService.client;


// Create a logger instance
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,       // Number of method calls to be displayed
    errorMethodCount: 8,  // Number of method calls if stacktrace is provided
    lineLength: 120,      // Width of the output
    colors: true,         // Colorful log messages
    printEmojis: true,    // Print an emoji for each log message
    printTime: false,     // Should each log print contain a timestamp
  ),
);
Future<Player> createPlayer(Map<String, dynamic> json) async {
  final response=await supabase.from('players').insert({
    'name': json['name'],
    'avatar_id': json['avatar_id'],
    'status': json['status'],
    'score': json['score'] ?? 0,
    'room_id': json['room_id']
  }).select().single();
  logger.d(response);
  final player = Player.fromJson(response);
  return player;
}

Future<void> updatePresence(String playerId) async {
  await supabase
      .from('players')
      .update({
    'is_online': true,
    'last_seen': DateTime.now().toIso8601String(),
  })
      .eq('id', playerId);
}