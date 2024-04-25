import 'package:flutter/material.dart';
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
        title: Text('Между уровнями'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (correctAnswers >= 3)
              Text(
                "Уровень $currentLevel завершен",
                style: TextStyle(fontSize: 24),
              ),
            if (correctAnswers < 3)
              Text(
                "Уровень $currentLevel не пройден",
                style: TextStyle(fontSize: 24),
              ),
            Text(
              'Оценка: $correctAnswers/$totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            if (correctAnswers < 3)
              Text(
                'Вам нужно больше практики!',
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 20),
            if (correctAnswers >= 3)
              Text(
                'Вы переходите на следующий уровень',
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await incrementLevel();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WordQuizScreen(),
                ));
              },
              child: Text(
                'Продолжить',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: 20),
            if (correctAnswers < 3)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push((MaterialPageRoute(
                    builder: (context) => MainPage(),
                  )));
                },
                child: Text(
                  'Начать сначала',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
          ],
        ),
      ),
    );
  }
}