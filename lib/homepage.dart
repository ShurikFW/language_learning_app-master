import 'dart:io';

import 'package:flutter/material.dart';
import 'package:language_learning_app/shared_preferences.dart';
import 'package:language_learning_app/level_screen.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? _userLevel;

  @override
  void initState() {
    super.initState();
    _loadUserLevel();
  }

  Future<void> _loadUserLevel() async {
    int? level = await getLevel();
    setState(() {
      _userLevel = level ?? 1;
    });
  }

  Future<void> _incrementLevel() async {
    if (_userLevel != null && _userLevel! < 20) {
      int newLevel = (_userLevel ?? 0) + 1;
      await saveLevel(newLevel);
      await _loadUserLevel();
    }
  }

  Future<void> _decrementLevel() async {
    if (_userLevel != null && _userLevel! > 1) {
      int newLevel = (_userLevel ?? 0) - 1;
      await saveLevel(newLevel);
      await _loadUserLevel();
    }
  }

  Future<void> _clearLevel() async {
    await clearLevel();
    await _loadUserLevel();
  }

  void _navigateToLevel() {
    Future.delayed(Duration(milliseconds: 500), () {
      // Переход к экрану игры
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WordQuizScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle submitTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estonian Learning App ',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: _decrementLevel,
                  child: const Icon(Icons.horizontal_rule),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Text('Уровень:'),
                    _userLevel != null
                        ? Text(
                            ' $_userLevel / 20',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
                const SizedBox(width: 20),
                FilledButton(
                  onPressed: _incrementLevel,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 40),
            AnimatedButton(
              onPress: _navigateToLevel,
              height: 70,
              width: 200,
              text: 'START GAME',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              textStyle: submitTextStyle,
              backgroundColor: Colors.black,
              borderColor: Colors.black,
              borderRadius: 50,
              borderWidth: 2,
            ),
            SizedBox(height: 40),
            AnimatedButton(
              onPress: () => exit(0),
              height: 70,
              width: 200,
              text: 'EXIT GAME',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              textStyle: submitTextStyle,
              backgroundColor: Colors.black,
              borderColor: Colors.black,
              borderRadius: 50,
              borderWidth: 2,
            )
          ],
        ),
      ),
    );
  }
}
