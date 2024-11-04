import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {
  final String? avatarUrl;
  final String fullName;

  UserProfile({required this.avatarUrl, required this.fullName});
}

class InfoProfileService {
  final SupabaseClient supabase;

  InfoProfileService(this.supabase);

  Future<UserProfile> getUserProfile() async {
    final user = supabase.auth.currentUser;
    final avatarUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'] ?? '사용자 이름';

    return UserProfile(
      avatarUrl: avatarUrl,
      fullName: fullName,
    );
  }

  // signOut 기능 추가
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (error) {
      print("Error signing out: $error"); // 로그아웃 실패 시 에러 로그
      throw error; // 필요 시 에러를 다시 throw 가능
    }
  }
}
