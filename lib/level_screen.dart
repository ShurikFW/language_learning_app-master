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
  String get currentRussianWord =>
      wordDictionary.keys.toList()[currentWordIndex];
  String get currentEstonianTranslation => wordDictionary[currentRussianWord]!;
  String get correctTranslation => wordDictionary[currentRussianWord]!;
  List<String> options = [];
  bool newOptionsRequired = true;
  @override
  Widget build(BuildContext context) {
    if (newOptionsRequired) {
      options = _generateOptions(currentEstonianTranslation);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Word Quiz'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentRussianWord,
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20),
          Column(
            children: options.map((option) {
              return Column(children: [
                ElevatedButton(
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
                ),
                SizedBox(height: 25)
              ]);
            }).toList(),
          ),
        ],
      )),
    );
  }

  List<String> _generateOptions(String correctTranslation) {
    List<String> options = [correctTranslation];
    while (options.length < 3) {
      String randomTranslation = wordDictionary.values
          .elementAt(Random().nextInt(wordDictionary.length));
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
      newOptionsRequired = false;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          newOptionsRequired = true;
          if (option == correctTranslation) {
            correctAnswersCount++;
          }
          selectedOption = null;
          currentWordIndex++;
          if (currentWordIndex % 5 == 0) { // Проверяем, прошли ли 5 слов
          _showBetweenLevelsScreen(); // Если да, показываем экран прохождения уровня
        }
          if (currentWordIndex >= wordDictionary.length) { // Проверяем, достигли ли конца словаря
          _showCongratsScreen(); // Если да, показываем экран поздравления
        }
          
        });
      });
    });
  }

  void _showBetweenLevelsScreen() {
    if (currentWordIndex >= wordDictionary.length) {
    currentWordIndex = 0;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenBetweenLevels(
          currentLevel: currentLevel++,
          totalLevels: totalLevels,
          correctAnswers: correctAnswersCount,
          totalQuestions: 5,
        ),
      ),
    ).then((value) {
      setState(() {
        correctAnswersCount = 0;
      });
    });
  }
  List<String> getNextRussianWords() {
      List<String> russianWords = wordDictionary.keys.toList();
      int endIndex = currentWordIndex;
      if (endIndex > russianWords.length) {
        endIndex = russianWords.length;
      }
      List<String> nextWords = russianWords.sublist(currentWordIndex, endIndex);
      currentWordIndex = endIndex; 
      return nextWords;
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
    
