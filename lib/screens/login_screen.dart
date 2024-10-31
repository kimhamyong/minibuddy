import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minibuddy/main.dart';
import 'package:minibuddy/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:minibuddy/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    final webClientId = Config.googleWebClientId;
    final iosClientId = Config.googleIosClientId;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/login/background.png', // Path to the background image
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login/bunny.png', // Bunny image
                    width: 270,
                    height: 270,
                  ),
                  const SizedBox(height: 30), // Adjusted height
                  // Text for Title and Description
                  const Text(
                    '내 손 안에 작은 친구',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Pretendard', // Set custom font family
                    ),
                  ),
                  const SizedBox(height: 5), // Reduced height
                  // Replace 'MINI BUDDY' with Image
                  Image.asset(
                    'assets/login/minibuddy_logo.png', // Path to minibuddy logo image
                    width: 300, // Adjust width to fit design
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '혼자 사는 당신을 위해 "미니버디"랑 이야기 나눠봐요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard', // Set custom font family
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Google Sign-In Button
                  GestureDetector(
                    onTap: _googleSignIn,
                    child: SizedBox(
                      width: 250, // Set width for consistency
                      height: 55, // Set height for button-like appearance
                      child: Image.asset(
                        'assets/login/google_signin_button.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Kakao Sign-In Button
                  GestureDetector(
                    onTap: () {
                      // Kakao login logic here
                    },
                    child: SizedBox(
                      width: 250, // Set width for consistency
                      height: 55, // Set height to match Google button
                      child: Image.asset(
                        'assets/login/kakao_signin_button.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
