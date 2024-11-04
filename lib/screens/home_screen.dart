import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:minibuddy/screens/profile_screen.dart';
import 'package:minibuddy/service/home/user_input.dart';
import 'package:minibuddy/service/home/server_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserInputService userInputService = UserInputService();
  final ServerResponseService serverResponseService = ServerResponseService();
  bool isListening = false;

  // 녹음 버튼 클릭 시 사용자 입력 모드로 전환
  void onRecordButtonPressed() async {
    setState(() {
      isListening = true;
    });

    // STT로 사용자의 음성을 텍스트로 변환
    final String userInput = await userInputService.getUserInputFromSTT();
    setState(() {
      isListening = false;
      userInputService.updateUserInput(userInput);
    });

    // 서버에 POST 요청하여 응답을 받아옴
    final String serverResponse = await serverResponseService.fetchServerResponse(userInput);
    setState(() {
      serverResponseService.updateServerResponse(serverResponse);
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                color: const Color(0xFFFFD99C),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    Image.asset(
                      'assets/home/logo_b.png',
                      width: 300,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    serverResponseService.displayServerResponse(),
                    const Spacer(),
                    userInputService.displayUserInput(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.mic_circle_fill,
                          size: 70,
                          color: isListening ? Colors.orange : Colors.black,
                        ),
                        onPressed: onRecordButtonPressed,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/home/bunny1.png',
              width: 180,
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}