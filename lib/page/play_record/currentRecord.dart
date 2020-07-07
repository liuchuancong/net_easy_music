import 'package:flutter/material.dart';

class CurrentRecord extends StatefulWidget {
  @override
  _CurrentRecordState createState() => _CurrentRecordState();
}

class _CurrentRecordState extends State<CurrentRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '当前播放',
                style: currentPlayTitleTextStyle,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                '(',
                style: currentPlayCountTextStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.5),
                child: Text(
                  '897',
                  style: currentPlayCountTextStyle,
                ),
              ),
              Text(
                ')',
                style: currentPlayCountTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}

final TextStyle currentPlayTitleTextStyle =
    const TextStyle(fontSize: 18, color: Colors.black);
final TextStyle currentPlayCountTextStyle =
    const TextStyle(fontSize: 15, color: Colors.black45,fontWeight: FontWeight.w700);
