import 'package:flutter/material.dart';
import 'package:language_learning_app/shared_preferences.dart';
import 'package:language_learning_app/level_screen.dart';


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
      builder: (context) => WordQuizScreen(),
    ));
  }

   @override
  Widget build(BuildContext context) {
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
            _userLevel != null
                ? Text(
                    'User Level: $_userLevel / 20',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _navigateToLevel,
              child: Text(
                'Start game',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _incrementLevel,
              child: Text(
                'Increment Level',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _clearLevel,
              child: Text(
                'Clear Level',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}