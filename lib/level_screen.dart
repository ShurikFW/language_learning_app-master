import 'package:flutter/material.dart';
import 'package:language_learning_app/shared_preferences.dart';
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
  int totalLevels = 20;

  int correctAnswersCount = 0;
  String? selectedOption;

  int? _userLevel;

  @override
  void initState() {
    super.initState();
    _loadUserLevel();
  }

  Future<void> _loadUserLevel() async {
    int? level = await getLevel();

    setState(() {
      _userLevel = level;
      debugPrint('On level screen setting level $level');
      currentWordIndex = (_userLevel! - 1) * 5;
      debugPrint('On level screen setting word index $currentWordIndex');
    });
  }

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
    int currentWordLevelIndex = (currentWordIndex % 5) + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Уровень $_userLevel', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$currentWordLevelIndex/5',
            style: TextStyle(fontSize: 42),
          ),
          SizedBox(height: 32),
          Text(
            currentRussianWord,
            style: TextStyle(fontSize: 34),
          ),
          SizedBox(height: 35),
          Column(
            children: options.map((option) {
              return Column(children: [
                ElevatedButton(
                  onPressed: () {
                    _checkAnswer(option);
                  },
                  child: Text(option, style: TextStyle(fontSize: 25)),
                  style: ButtonStyle(
                    backgroundColor: (option == selectedOption)
                        ? (selectedOption == correctTranslation)
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(Colors.red)
                        : null,
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                          fontSize:
                              30), // Измените 20 на нужный вам размер шрифта
                    ),
                  ),
                ),
                SizedBox(height: 30)
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
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          newOptionsRequired = true;
          if (option == correctTranslation) {
            correctAnswersCount++;
          }
          selectedOption = null;
          currentWordIndex++;
          int length = wordDictionary.length;
          debugPrint('current word index became $currentWordIndex');
          debugPrint('dictionary length $length');
          if (currentWordIndex == wordDictionary.length) {
            // Проверяем, достигли ли конца словаря
            debugPrint('showing congrats screen');
            currentWordIndex = 0;
            _showCongratsScreen();
            // Если да, показываем экран поздравления
          } else if (currentWordIndex % 5 == 0) {
            debugPrint('showing between levels screen');
            _showBetweenLevelsScreen(); // Если да, показываем экран прохождения уровня
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
          currentLevel: _userLevel!,
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
