import 'package:flutter/material.dart';

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
            if(correctAnswers >= 3)
              Text("Уровень $currentLevel завершен" ),
            if(correctAnswers < 3)
              Text("Уровень $currentLevel не пройден" ),
            Text('Оценка: $correctAnswers/$totalQuestions'),
            SizedBox(height: 20),
            if (correctAnswers < 3) 
              Text('Вам нужно больше практики!'), 
            SizedBox(height: 20),
            if (correctAnswers >= 3) 
              Text('Вы переходите на следующий уровень'), 
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Продолжить'),
            ),
            if (correctAnswers < 3) // 
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/')); // Вернуться на главный экран
                },
                child: Text('Начать сначала'),
              ),
          ],
        ),
      ),
    );
  }
}