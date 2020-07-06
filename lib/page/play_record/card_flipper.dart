import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'card.dart';
import 'card_data.dart';

class CardFlipter extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function(double) onScroll;
  const CardFlipter({Key key, this.cards, this.onScroll}) : super(key: key);
  _CardFlipterState createState() => _CardFlipterState();
}

class _CardFlipterState extends State<CardFlipter>
    with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();
    finishScrollController = new AnimationController(
        duration: Duration(milliseconds: 150), vsync: this)
      ..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);
          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    finishScrollController.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;
    setState(() {
      scrollPercent = (startDragPercentScroll +
              (-singleCardDragPercent / widget.cards.length))
          .clamp(0.0, 1.0 - (1 / widget.cards.length));
      // x.clamp(y,z) 返回xyz中 中间的
      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    //  finishScrollStart 为 (1 / numCars)*的倍数
    // 左右方向 false 为右划
    if (startDrag.dx > details.velocity.pixelsPerSecond.dx) {
      finishScrollEnd =
          (scrollPercent * widget.cards.length).ceil() / widget.cards.length;
    } else {
      finishScrollEnd =
          (scrollPercent * widget.cards.length).floor() / widget.cards.length;
    }
    // 如果scrollPercent 移动的距离大于0.5 向上取整，然后除以card、
    ///的总数 计算出 需要位移动画的最终距离
    finishScrollController.forward(from: 0.0);
    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  Matrix4 _buildCardProjection(double scrollPercent) {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    projection *= new Matrix4.translationValues(
            horizontalTranslation + (rotationPointMultiplier * 350.0),
            0.0,
            0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(
            -rotationPointMultiplier * 350.0, 0.0, 0.0);

    return projection;
  }

  Widget _buildCard(CardViewModel viewModel, int cardIndex, int cardCount,
      double scrollPercent) {
    final cardScrollPercent = scrollPercent * cardCount;
    final parallax = scrollPercent - (cardIndex / widget.cards.length);
    return Transform.scale(
      scale: 0.85,
          child: FractionalTranslation(
        translation: Offset(cardIndex - cardScrollPercent, 0.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: CardContainer(viewModel: viewModel, prarllaxPercent: parallax),
        ),
      ),
    );
  }

  List<Widget> _buildCards() {
    final cardsLength = widget.cards.length;
    int index = -1;
    return widget.cards.map((CardViewModel viewModel) {
      ++index;
      return _buildCard(viewModel, index, cardsLength, scrollPercent);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}
