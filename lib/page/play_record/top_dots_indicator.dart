import 'package:flutter/material.dart';

class TopDotsIndicator extends StatefulWidget {
  final scrollPercent;
  final cardCount;

  const TopDotsIndicator({Key key, this.scrollPercent = 0.0, this.cardCount})
      : super(key: key);
  _TopDotsIndicatorState createState() => _TopDotsIndicatorState();
}

class _TopDotsIndicatorState extends State<TopDotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: new Container(
            width: 60,
            height: 5.0,
            color: Colors.transparent,
            child: new ScrollerIndicator(
                cardCount: widget.cardCount,
                scrollerPercent: widget.scrollPercent),
          ),
        ));
  }
}

class ScrollerIndicator extends StatelessWidget {
  final cardCount;
  final scrollerPercent;
  const ScrollerIndicator({Key key, this.cardCount, this.scrollerPercent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new CardPainter(
        cardCount: cardCount,
        scrollerPercent: scrollerPercent,
      ),
      child: new Container(),
    );
  }
}

class CardPainter extends CustomPainter {
  final int cardCount;
  final double scrollerPercent;
  CardPainter({this.cardCount, this.scrollerPercent});
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < cardCount; i++) {
      Paint paint = new Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
      if ((cardCount * scrollerPercent).toInt() == i) {
        paint.color = Colors.white;
      }

      canvas.drawCircle(Offset(size.width * i / 2, size.height), 4, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
