import 'package:flutter/material.dart';
import 'package:minibuddy/main.dart';
import 'package:minibuddy/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'] ?? '사용자 이름';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD99C), // 상단바 노란색 배경
        title: const Text(
          '내 정보',
          style: TextStyle(
            fontFamily: 'Pretendard', // "내 정보" 글씨체 설정
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // 상단 프로필 영역
          Container(
            color: const Color(0xFFFFD99C), // 연한 노란색 배경
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 프로필 이미지 (없을 경우 기본 아이콘 표시)
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
                // 사용자 이름
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
          // 경고 메시지 및 불빛 아이콘 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 가운데 정렬
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/profile/yellow.png', // 경고 이미지 경로 (노란색)
                      width: 100, // 아이콘 크기를 100으로 확대
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '당신의 우울증 증상은',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40), 
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '최근 기억력이 흐려진 느낌이 들면 간단한 메모 습관을 시작해보세요.',
                      style: const TextStyle(
                        fontSize: 15,
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
          // 경고 메시지 및 불빛 아이콘 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 가운데 정렬
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '최근 기억력이 흐려진 느낌이 들면 간단한 메모 습관을 시작해보세요.',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 15,
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
                      'assets/profile/red.png', // 경고 이미지 경로 (빨간색)
                      width: 100, // 아이콘 크기를 100으로 확대
                      height: 100,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '당신의 mci 증상은',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(), // 빈 공간을 추가하여 Sign out 버튼을 하단에 위치
          // 하단부에 Sign out 버튼 추가
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
