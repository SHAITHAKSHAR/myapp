import 'package:flutter/material.dart';
import 'package:myapp/models/challenge.dart';

class ChallengesProvider with ChangeNotifier {
  final List<Challenge> _challenges = [
    Challenge(id: '1', title: 'Win 500 points', description: 'Win a total of 500 points in one day', goal: 500, reward: 100),
    Challenge(id: '2', title: 'Spin 10 times', description: 'Spin the wheel 10 times in one day', goal: 10, reward: 50),
    Challenge(id: '3', title: 'Land on Jackpot', description: 'Land on the Jackpot segment', goal: 1, reward: 200),
  ];

  List<Challenge> get challenges => _challenges;

  void updateProgress(String challengeId, int progress) {
    final challenge = _challenges.firstWhere((c) => c.id == challengeId);
    challenge.progress = progress;
    if (challenge.progress >= challenge.goal) {
      challenge.isCompleted = true;
    }
    notifyListeners();
  }

  void claimReward(String challengeId) {
    final challenge = _challenges.firstWhere((c) => c.id == challengeId);
    // In a real app, you would add the reward to the user's account.
    challenge.isCompleted = false; // Reset for the next day
    challenge.progress = 0;
    notifyListeners();
  }
}
