import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:minibuddy/screens/profile_screen.dart'; // ProfileScreen 경로에 맞게 설정

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String serverResponse = "안녕하세요! 당신을 만나서 즐거워요~ 오늘 하루는 어땠나요?"; // 초기 텍스트

  // 서버 응답을 업데이트하는 함수
  void updateServerResponse(String response) {
    setState(() {
      serverResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // 상단 노란색 배경
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4, // 화면의 상단 40% 높이
                color: const Color(0xFFFFD99C), // 연한 노란색
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // 시작 위치로 정렬
                  children: [
                    const SizedBox(height: 110), 
                    // 타이틀 이미지
                    Image.asset(
                      'assets/home/logo_b.png', // 로고 이미지 경로
                      width: 300, // 디자인에 맞게 너비 조정
                    ),
                  ],
                ),
              ),
              // 하단 부분 (흰색 배경)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30), // 토끼 이미지와 텍스트 사이 간격 조정
                    // 서버 응답 텍스트 출력
                    Padding(
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
                    ),
                    const Spacer(),
                    // 음성 녹음 버튼
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0), // 아이콘을 더 위로 조정
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.mic_circle_fill,
                          size: 70,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // 음성 녹음 시작 로직 추가 가능
                        },
                      ),
                    ),
                    // "내 상태를 확인하고 싶다면 여기를 클릭" 텍스트 버튼
                    GestureDetector(
                      onTap: () {
                        // ProfileScreen으로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "내 상태를 확인하고 싶다면 여기를 클릭",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 토끼 이미지를 노란색과 흰색 배경 경계에 배치
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21, // 노란색과 흰색 경계에 맞춰 배치
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/home/bunny1.png', // Bunny 이미지 경로
              width: 180, // 너비 조정
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
