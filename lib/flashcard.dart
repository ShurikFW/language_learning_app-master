import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/data.dart';

class FlashcardScreen extends StatefulWidget {
  final String category;
  const FlashcardScreen({required this.category});

  @override
  State<FlashcardScreen> createState() =>
      _FlashcardScreenState(category: category);
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final String category;
  _FlashcardScreenState({required this.category});

  var _currItem = 0;
  late List<Map<String, String>> jsonData;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  TextStyle textStyle = TextStyle(
      color: Colors.green.shade900, fontSize: 20, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    jsonData = (data[this.category] as List).cast<Map<String, String>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffA7D397),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Learning Made Easy"),
          elevation: 5,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                "Guess the Word and Flip! ????",
                style: TextStyle(fontSize: 30, color: Colors.green.shade900),
              ),
              SizedBox(height: 20),
              SizedBox(height: 25),
              SizedBox(
                width: 300,
                height: 300,
                child: FlipCard(
                  key: cardKey,
                  side: CardSide.FRONT,
                  direction: FlipDirection.HORIZONTAL,
                  front: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 7,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(jsonData[_currItem]["word"] ?? "",
                            textAlign: TextAlign.center, style: textStyle),
                      ),
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 7,
                    shadowColor: Colors.grey,
                    color: Colors.yellow.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(jsonData[_currItem]["result"] ?? "",
                            textAlign: TextAlign.center, style: textStyle),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currItem = (_currItem + 1) % jsonData.length;
                      cardKey.currentState?.toggleCardWithoutAnimation();
                    });
                  },
                  child: Text("Next"))
            ])));
  }
}
