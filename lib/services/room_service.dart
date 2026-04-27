import 'package:logger/logger.dart';
import 'package:quizzy/core/supabase_client.dart';
import 'package:quizzy/models/room.dart';

import '../models/player.dart';

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
Future<Room> createRoom(Map<String, dynamic> json) async {
  final response=await supabase.from('rooms').insert({
    'id': json['id'],
    'avatar_id': json['host_id'],
    'status': json['status'],
    'current_question_index': json['current_question_index'] ?? 0,
  }).select().single();
  logger.d(response);
  final room = Room.fromJson(response);
  return room;
}
