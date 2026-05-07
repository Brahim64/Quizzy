import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:quizzy/providers/user_provider.dart';
import 'package:quizzy/services/user_service.dart';
import 'package:quizzy/widgets/app_background.dart';

class JoinRoom extends ConsumerStatefulWidget {
  const JoinRoom({super.key});

  @override
  ConsumerState<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends ConsumerState<JoinRoom> {
  
  int roomCode = 0;
  @override
  Widget build(BuildContext context) {
    final player = ref.watch(userProvider);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      body: AppBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 100,
          children: [
            Center(
              child: Pinput(
                length: 4, // 4 individual small boxes
                defaultPinTheme: defaultPinTheme,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(
                      color: Colors.blue,
                    ), // border changes on focus
                  ),
                ),
                onCompleted: (pin) {
                  print('The total code entered is: $pin');
                  roomCode = int.tryParse(pin)!;
                  joinRoom(roomCode,player!.id );
                },
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Join Room')),
          ],
        ),
      ),
    );
  }
}
