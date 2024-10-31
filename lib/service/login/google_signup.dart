import 'package:google_sign_in/google_sign_in.dart';
import 'package:minibuddy/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final SupabaseClient supabase;

  LoginService(this.supabase);

  Future<AuthResponse> googleSignIn() async {
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
}
