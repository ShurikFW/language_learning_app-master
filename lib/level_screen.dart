import 'package:flutter/material.dart';
import 'dart:math';
import 'dictionary.dart';
import 'screen_between_levels.dart'; 
import 'congrats_screen.dart';

class WordQuizScreen extends StatefulWidget {
  @override
  _WordQuizScreenState createState() => _WordQuizScreenState();
}

class _WordQuizScreenState extends State<WordQuizScreen> {
  int currentWordIndex = 0;
  int currentLevel = 1;
  int totalLevels = 20;
  int correctAnswersCount = 0;
  String? selectedOption;
  String get currentRussianWord => wordDictionary.keys.toList()[currentWordIndex];
  String get currentEstonianTranslation => wordDictionary[currentRussianWord]!;
  String get correctTranslation => wordDictionary[currentRussianWord]!;

  @override
  Widget build(BuildContext context) {
    List<String> options = _generateOptions(currentEstonianTranslation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Word Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentRussianWord,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Column(
            children: options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  _checkAnswer(option);
                },
                child: Text(option),
                style: ButtonStyle(
                  backgroundColor: (option == selectedOption)
                    ? (selectedOption == correctTranslation)
                      ? MaterialStateProperty.all<Color>(Colors.green)
                      : MaterialStateProperty.all<Color>(Colors.red)
                    : null,
                ),
              );
            }).toList(),
          ), 
        ],
      ),
    );
  }

  List<String> _generateOptions(String correctTranslation) {
    List<String> options = [correctTranslation];
    while (options.length < 3) {
      String randomTranslation =
          wordDictionary.values.elementAt(Random().nextInt(wordDictionary.length));
      if (!options.contains(randomTranslation)) {
        options.add(randomTranslation);
      }
    }
    options.shuffle();
    return options;
  }

  void _checkAnswer(String option) {
  setState(() {
    selectedOption = option;
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (option != correctTranslation) {
          currentWordIndex++;
        }
        if (option == correctTranslation){
          currentWordIndex++; 
          correctAnswersCount++;
        }
        selectedOption = null;
        if (currentWordIndex == 5) {
          _showBetweenLevelsScreen();
          
        }
        if (currentWordIndex >= 20) {
          _showCongratsScreen();
        }

      });
    });
  });
}
  void _showBetweenLevelsScreen() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ScreenBetweenLevels(
        currentLevel: currentLevel++,
        totalLevels: totalLevels,
        correctAnswers: correctAnswersCount, 
        totalQuestions: currentWordIndex, 
      ),
    ),
  ).then((value) {
    setState(() {
      currentWordIndex = 0;
      correctAnswersCount = 0;
    });
  });
}

  void _showCongratsScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CongratsScreen(),
      ),
    );
  }
}
