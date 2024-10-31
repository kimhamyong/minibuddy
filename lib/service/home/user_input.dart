// lib/service/home/user_input.dart

import 'package:flutter/material.dart';

class UserInputService {
  String userInput = "";

  void updateUserInput(String input) {
    userInput = input;
  }

  Widget displayUserInput() {
    return userInput.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              userInput,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
                color: Colors.black,
              ),
            ),
          )
        : Container();
  }
}
