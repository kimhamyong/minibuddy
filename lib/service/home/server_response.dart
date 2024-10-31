// lib/service/home/server_response.dart

import 'package:flutter/material.dart';

class ServerResponseService {
  String serverResponse = "안녕하세요! 당신을 만나서 즐거워요~ 오늘 하루는 어땠나요?";

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
