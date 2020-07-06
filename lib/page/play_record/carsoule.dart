import 'package:flutter/material.dart';
import 'top_dots_indicator.dart';
import 'card_data.dart';
import 'card_flipper.dart';

class Carsoule extends StatefulWidget {
  _CarsouleState createState() => _CarsouleState();
}

class _CarsouleState extends State<Carsoule> {
  var scrollPercent = 0.0;
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TopDotsIndicator(
            scrollPercent: scrollPercent, cardCount: heroCards.length),
        new Expanded(
            child: new CardFlipter(
                cards: heroCards,
                onScroll: (double scrollPercent) {
                  setState(() {
                    this.scrollPercent = scrollPercent;
                  });
                })),
      ],
    );
  }
}
