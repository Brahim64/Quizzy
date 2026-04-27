import 'dart:math';

String generateUserId() {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final random = (1000 + (DateTime.now().microsecond % 9000));
  return "$timestamp-$random";
}

int generateFourDigitNumber() {
  final random = Random();
  // nextInt(9000) returns 0-8999. Adding 1000 results in 1000-9999.
  return 1000 + random.nextInt(9000);
}