import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class UserInputService {
  String userInput = "";
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<String> getUserInputFromSTT() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            userInput = result.recognizedWords;
          },
          localeId: 'ko_KR', // 한국어로 설정
        );

        await Future.delayed(const Duration(seconds: 3)); // Mock delay for listening
        _speech.stop();
      } else {
        return "음성 인식 기능을 사용할 수 없습니다.";
      }
    } catch (e) {
      print('Error in STT: $e');
      return "음성 인식 도중 오류가 발생했습니다.";
    }

    return userInput.isNotEmpty ? userInput : "음성 인식을 실패했습니다.";
  }

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
