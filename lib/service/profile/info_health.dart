import 'dart:math';
import 'package:flutter/material.dart';

class InfoHealthService {
  final Random _random = Random();

  // 우울증 상태별 메시지
  final List<String> blueMessagesDepression = [
    "지금 마음 상태가 좋은 것 같아요! 소소한 행복을 만끽하며 하루를 보내세요.",
    "오늘 기분이 좋은 상태인 것 같아요. 이 긍정적인 에너지를 주변에 나눠보는 건 어때요?",
    "안정된 마음을 유지하고 계시네요. 지금처럼 꾸준히 자신을 돌보며 행복한 하루를 보내세요."
  ];

  final List<String> yellowMessagesDepression = [
    "최근 마음이 조금 무거운 것 같아요. 잠깐 휴식하고 심호흡해보는 건 어때요?",
    "하루에 잠시라도 자신의 감정을 돌보는 시간이 중요해요. 지금 기분은 어떤가요?",
    "작은 변화들이 큰 힘이 될 수 있어요. 가볍게 산책하거나 좋아하는 음악을 들어보세요."
  ];

  final List<String> redMessagesDepression = [
    "지금 많이 힘든 것 같아요. 주변 사람에게 마음을 나누어보세요. 도움이 될 거예요.",
    "혼자서 모든 걸 해결하려고 하지 않아도 돼요. 당신은 소중한 사람입니다.",
    "심리상담사와 이야기를 나누는 것도 큰 도움이 될 수 있어요. 혼자가 아닙니다."
  ];

  // MCI 상태별 메시지
  final List<String> blueMessagesMci = [
    "기억력이 안정적인 상태예요. 두뇌 활동을 유지하면서 일상에서 성취감을 찾아보세요.",
    "오늘 두뇌 상태가 좋아 보이네요. 새로운 도전이나 퍼즐로 두뇌를 자극해보세요.",
    "현재 기억력이 좋은 상태입니다. 일상 속 작은 목표를 세우고 실천해보세요!"
  ];

  final List<String> yellowMessagesMci = [
    "최근 기억력이 조금 저하된 느낌이 들면 간단한 메모 습관을 시작해보세요.",
    "중요한 일정은 기록해두면 도움이 될 거예요. 작은 변화가 큰 차이를 만듭니다.",
    "기억력을 보강하기 위해 꾸준한 두뇌 운동을 해보는 건 어떨까요?"
  ];

  final List<String> redMessagesMci = [
    "기억력이 예전 같지 않다고 느껴지신다면, 전문가와의 상담이나 생활 습관 개선을 고려해보세요.",
    "중요한 일정을 자주 잊는다면 주변에 도움을 요청해보세요.",
    "기억 관리가 필요하다면 전문가의 조언을 들어보는 것도 좋습니다."
  ];

  // 상태에 따른 메시지 반환
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
    } else if (type == 'mci') {
      if (count <= 4) {
        messages = blueMessagesMci;
      } else if (count <= 9) {
        messages = yellowMessagesMci;
      } else {
        messages = redMessagesMci;
      }
    } else {
      messages = ["해당 조건에 대한 메시지가 없습니다."];
    }
    return messages[_random.nextInt(messages.length)];
  }

  // 상태에 따른 색상 반환
  Color getColor(int count) {
    if (count <= 4) {
      return Colors.blue;
    } else if (count <= 9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // 상태에 따른 아이콘 경로 반환
  String getIconPath(int count) {
    if (count <= 4) {
      return 'assets/profile/blue.png';
    } else if (count <= 9) {
      return 'assets/profile/yellow.png';
    } else {
      return 'assets/profile/red.png';
    }
  }
}
