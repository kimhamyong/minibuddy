import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minibuddy/main.dart';
import 'package:minibuddy/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final random = Random();

  // 상태별 메시지 목록 정의
  final List<String> blueMessagesDepression = [
    "잠시 산책을 하면서 기분 전환을 해보세요.",
    "친구나 가족에게 연락해보세요. 짧은 대화가 큰 힘이 될 수 있어요.",
    "가벼운 스트레칭을 하며 몸을 풀어보는 건 어떨까요?",
    "마음에 드는 음악을 들으며 잠시 쉬어가세요.",
    "잠깐 명상을 통해 마음을 정리해보세요."
  ];

  final List<String> yellowMessagesDepression = [
    "최근 마음이 무겁다면 잠시 멈춰서 숨을 고르세요.",
    "일상 속 소소한 즐거움을 찾아보세요.",
    "가볍게 하루를 돌아보며 오늘의 좋은 일들을 떠올려보세요.",
    "작은 휴식 시간을 가지며 마음을 비워보세요.",
    "간단한 일기 작성으로 마음을 표현해보세요."
  ];

  final List<String> redMessagesDepression = [
    "기분이 많이 가라앉는다면 전문가의 도움을 받아보세요.",
    "현재 마음 상태를 신뢰하는 사람에게 나눠보세요.",
    "스트레스가 많은 상황이라면 충분히 휴식을 취하세요.",
    "이제는 진지하게 자신을 돌볼 시간이 필요합니다.",
    "마음을 안정시킬 수 있는 활동을 찾아보세요."
  ];

  final List<String> blueMessagesMci = [
    "간단한 메모로 일정을 기록해보세요.",
    "하루 일과를 정리하는 시간을 가져보세요.",
    "일정을 한눈에 볼 수 있도록 정리해보세요.",
    "습관적으로 체크리스트를 만들어보세요.",
    "하루의 중요한 일정을 기록해보세요."
  ];

  final List<String> yellowMessagesMci = [
    "최근 기억력이 흐려졌다면 메모 습관을 들여보세요.",
    "간단한 기록을 통해 기억력을 도와줄 수 있어요.",
    "중요한 일정은 메모로 남겨두는 것이 좋아요.",
    "자주 잊어버리는 일이 있다면 메모해보세요.",
    "메모하는 습관이 기억력을 향상시켜줄 수 있어요."
  ];

  final List<String> redMessagesMci = [
    "중요한 일정을 자주 잊는다면 도움이 필요할 수 있어요.",
    "주변 사람들과의 대화를 통해 기억력을 점검해보세요.",
    "최근 기억력 저하가 심하다면 전문가의 조언을 들어보세요.",
    "기억력 관리가 필요할 때입니다. 전문가와 상담해보세요.",
    "일정을 자주 잊는다면 필요한 조치를 고려해보세요."
  ];

  // 상태에 따른 메시지 랜덤 선택 함수
  String getRandomMessage(int count, String type) {
    List<String> messages;
    if (type == 'depression') {
      if (count <= 4) {
        messages = blueMessagesDepression;
      } else if (count <= 9) {
        messages = yellowMessagesDepression;
      } else {
        messages = redMessagesDepression;
      }
    } else {
      if (count <= 4) {
        messages = blueMessagesMci;
      } else if (count <= 9) {
        messages = yellowMessagesMci;
      } else {
        messages = redMessagesMci;
      }
    }
    return messages[random.nextInt(messages.length)];
  }

  // 상태에 따른 색상 반환 함수
  Color getColor(int count) {
    if (count <= 4) {
      return Colors.blue;
    } else if (count <= 9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // 상태에 따른 아이콘 경로 반환 함수
  String getIconPath(int count) {
    if (count <= 4) {
      return 'assets/profile/blue.png';
    } else if (count <= 9) {
      return 'assets/profile/yellow.png';
    } else {
      return 'assets/profile/red.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'] ?? '사용자 이름';

    // 예시 count 값 (실제 서버에서 받아온 값으로 대체 가능)
    final int depressionCount = 1;
    final int mciCount = 10;

    final depressionMessage = getRandomMessage(depressionCount, 'depression');
    final mciMessage = getRandomMessage(mciCount, 'mci');
    final depressionIconPath = getIconPath(depressionCount);
    final mciIconPath = getIconPath(mciCount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD99C),
        title: const Text(
          '내 정보',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // 상단 프로필 영역
          Container(
            color: const Color(0xFFFFD99C),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (profileImageUrl != null)
                  ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.blue[700],
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          // 첫 번째 경고 메시지 및 불빛 아이콘
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      depressionIconPath,
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: '당신의 ',
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '우울증',
                            style: TextStyle(color: getColor(depressionCount)),
                          ),
                          const TextSpan(text: ' 증상은'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      depressionMessage,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          // 두 번째 경고 메시지 및 불빛 아이콘
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      mciMessage,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    Image.asset(
                      mciIconPath,
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: '당신의 ',
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'MCI',
                            style: TextStyle(color: getColor(mciCount)),
                          ),
                          const TextSpan(text: ' 증상은'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: TextButton(
              onPressed: () async {
                await supabase.auth.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              },
              child: const Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
