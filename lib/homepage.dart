import 'package:flutter/material.dart';
import 'package:language_learning_app/flashcard.dart';
import 'package:language_learning_app/shared_preferences.dart';

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
    int newLevel = (_userLevel ?? 0) + 1;
    await saveLevel(newLevel);
    await _loadUserLevel();
  }

  Future<void> _clearLevel() async {
    await clearLevel();
    await _loadUserLevel();
  }

  void _navigateToLevel() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FlashcardScreen(category: "Basics"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estonian Learning App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userLevel != null
                ? Text('User Level: $_userLevel / 20')
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementLevel,
              child: Text('Increment Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _clearLevel,
              child: Text('Clear Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToLevel,
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
