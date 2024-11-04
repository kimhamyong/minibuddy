import 'package:flutter/material.dart';
import 'package:minibuddy/service/profile/count_service.dart';
import 'package:minibuddy/service/profile/info_health.dart';
import 'package:minibuddy/service/profile/info_profile.dart';
import 'package:minibuddy/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CountService countService = CountService();
  final InfoHealthService healthService = InfoHealthService();
  final InfoProfileService profileService = InfoProfileService(Supabase.instance.client);

  int depressionCount = 0;
  int mciCount = 0;
  String? profileImageUrl;
  String fullName = '사용자 이름';

  @override
  void initState() {
    super.initState();
    fetchCounts();
    fetchProfile();
  }

  Future<void> fetchCounts() async {
    final counts = await countService.getCounts();
    setState(() {
      depressionCount = counts['depression'] ?? 0;
      mciCount = counts['mci'] ?? 0;
    });
  }

  Future<void> fetchProfile() async {
    final profile = await profileService.getUserProfile();
    setState(() {
      profileImageUrl = profile.avatarUrl;
      fullName = profile.fullName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final depressionMessage = healthService.getRandomMessage(depressionCount, 'depression');
    final mciMessage = healthService.getRandomMessage(mciCount, 'mci');
    final depressionIconPath = healthService.getIconPath(depressionCount);
    final mciIconPath = healthService.getIconPath(mciCount);

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
                      profileImageUrl!,
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
          // 우울증 상태
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
                            style: TextStyle(color: healthService.getColor(depressionCount)),
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
          // MCI 상태
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
                            style: TextStyle(color: healthService.getColor(mciCount)),
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
          Padding(
           padding: const EdgeInsets.only(bottom: 30.0),
           child: TextButton(
            onPressed: () async {
              try {
                await profileService.signOut(); // InfoProfileService의 signOut 호출
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              } catch (error) {
                // 추가 에러 처리 가능
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
