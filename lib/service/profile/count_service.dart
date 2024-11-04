import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minibuddy/config.dart';

class CountService {
  final String profileUrl = Config.profileUrl;

  Future<Map<String, int>> getCounts() async {
    try {
      final response = await http.get(Uri.parse(profileUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'depression': data['depression'] ?? 0,
          'mci': data['mci'] ?? 0,
        };
      } else {
        print('Failed to load counts, status code: ${response.statusCode}');
        return {'depression': 0, 'mci': 0}; // 기본값 반환
      }
    } catch (e) {
      print('Error fetching counts: $e');
      return {'depression': 0, 'mci': 0}; // 에러 발생 시 기본값 반환
    }
  }

  Future<void> resetCounts() async {
    print('Counts reset to default values');
  }
}
