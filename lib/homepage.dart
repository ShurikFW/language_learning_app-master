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
    color: Colors.white,);
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
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 40),
            AnimatedButton(
              onPress: _navigateToLevel,
              height: 70,
              width: 200,
              text: 'SUBMIT',
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
              onPress: _incrementLevel,
              height: 70,
              width: 200,
              text: 'Increment level',
              selectedTextColor: Colors.black,
              textStyle: submitTextStyle,
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              borderRadius: 50,
              borderWidth: 2,
            ),
            SizedBox(height: 40),
            AnimatedButton(
              onPress: _clearLevel,
              height: 70,
              width: 200,
              text: 'Clear Level',
              selectedTextColor: Colors.black,
              textStyle: submitTextStyle,
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              borderRadius: 50,
              borderWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}