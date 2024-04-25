import 'package:flutter/material.dart';
import 'package:language_learning_app/animated_button.dart';
import 'package:language_learning_app/shared_preferences.dart';

import 'homepage.dart';
import 'level_screen.dart';

class ScreenBetweenLevels extends StatelessWidget {
  final int currentLevel;
  final int totalLevels;
  final int correctAnswers;
  final int totalQuestions;

  ScreenBetweenLevels({
    required this.currentLevel,
    required this.totalLevels,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Между уровнями', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (correctAnswers >= 3)
              Text(
                "Уровень $currentLevel завершен",
                style: TextStyle(fontSize: 32),
              ),
            if (correctAnswers < 3)
              Text(
                "Уровень $currentLevel не пройден",
                style: TextStyle(fontSize: 32),
              ),
            Text(
              'Оценка: $correctAnswers/$totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (correctAnswers < 3)
              Text(
                'Вам нужно больше практики!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 20),
            if (correctAnswers >= 3)
              Text(
                'Вы переходите на следующий уровень',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            SizedBox(height: 20),
            AppAnimatedButton(
                callback: () async {
                  await incrementLevel();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WordQuizScreen(),
                  ));
                },
                text: 'Продолжить'),
            SizedBox(height: 20),
            if (correctAnswers < 3)
              AppAnimatedButton(
                  callback: () {
                    Navigator.of(context).push((MaterialPageRoute(
                      builder: (context) => MainPage(),
                    )));
                  },
                  text: 'Начать сначала'),
          ],
        ),
      ),
    );
  }
}
