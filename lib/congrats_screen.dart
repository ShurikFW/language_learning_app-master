import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/animated_button.dart';

class CongratsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поздравляем', style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                textAlign: TextAlign.center,
                'Вы прошли все 20 уровней!',
                style: TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            AppAnimatedButton(
                callback: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                text: 'Начать заново'),
          ],
        ),
      ),
    );
  }
}
