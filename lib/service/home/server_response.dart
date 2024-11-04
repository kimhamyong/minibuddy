import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minibuddy/config.dart';

class ServerResponseService {
  String serverResponse = "안녕하세요! 당신을 만나서 즐거워요~ 오늘 하루는 어땠나요?";

  // 서버에 POST 요청하여 응답을 받아오는 메서드
  Future<String> fetchServerResponse(String userInput) async {
    const String chatUrl = Config.chatUrl;
    try {
      final response = await http.post(
        Uri.parse(chatUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'chat': userInput}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['chat'] ?? "서버 응답 없음";
      } else {
        return "서버와의 연결에 실패했습니다.";
      }
    } catch (e) {
      return "서버 요청 중 오류 발생: $e";
    }
  }

  void updateServerResponse(String response) {
    serverResponse = response;
  }

  Widget displayServerResponse() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Text(
        serverResponse,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pretendard',
          color: Colors.black,
        ),
      ),
    );
  }
}
