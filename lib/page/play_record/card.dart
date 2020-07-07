import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final double prarllaxPercent;
  final Widget view;
  final int activeIndex;
  final int cardIndex;
  const CardContainer(
      {Key key,
      this.prarllaxPercent = 0.0,
      this.view,
      this.activeIndex,
      this.cardIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.circular(16.0),
            child: new OverflowBox(
                maxWidth: double.infinity,
                child: Container(
                  color: Colors.white,
                )),
          ),
          view
        ],
      ),
    );
  }
}
