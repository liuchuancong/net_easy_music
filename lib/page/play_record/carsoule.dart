import 'package:flutter/material.dart';
import 'top_dots_indicator.dart';
import 'card_data.dart';
import 'card_flipper.dart';

class Carsoule extends StatefulWidget {
  final int selectedIndex;

  const Carsoule({Key key, this.selectedIndex}) : super(key: key);
  _CarsouleState createState() => _CarsouleState();
}

class _CarsouleState extends State<Carsoule> {
  var scrollPercent = 0.0;
  @override
  void initState() {
    scrollPercent = widget.selectedIndex / heroCards.length;
    super.initState();
  }

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
                scrollPercent: scrollPercent,
                onScroll: (double scrollPercent) {
                  setState(() {
                    this.scrollPercent = scrollPercent;
                  });
                })),
      ],
    );
  }
}
