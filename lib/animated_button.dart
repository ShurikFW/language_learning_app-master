import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class AppAnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const AppAnimatedButton(
      {super.key, required this.callback, required this.text});

  final TextStyle submitTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPress: callback,
      height: 70,
      width: 200,
      text: text,
      isReverse: true,
      selectedTextColor: Colors.black,
      transitionType: TransitionType.LEFT_TO_RIGHT,
      textStyle: submitTextStyle,
      backgroundColor: Colors.black,
      borderColor: Colors.black,
      borderRadius: 50,
      borderWidth: 2
    );
  }
}
