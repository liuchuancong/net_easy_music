import 'package:flutter/material.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CurrentRecord extends StatefulWidget {
  @override
  _CurrentRecordState createState() => _CurrentRecordState();
}

class _CurrentRecordState extends State<CurrentRecord> {
  ScrollController _scrollController;
  double _itemHeight = 40.0;
  @override
  void initState() {
    _scrollController = new ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('ok');
      jumpToCurrentPlay();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String musicCounts =
        Provider.of<PlaylistManage>(context).playlist.length.toString();
    // jumpToCurrentPlay();
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '当前播放',
                style: currentPlayTitleTextStyle,
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.5),
                child: Text(
                  '($musicCounts)',
                  style: currentPlayCountTextStyle,
                ),
              ),
            ],
          ),
          Expanded(
            child: new ListView(
                controller: _scrollController, children: getPlayList()),
          ),
        ],
      ),
    );
  }

  getPlayList() {
    final _playList = Provider.of<PlaylistManage>(context).playlist;
    List<Widget> tempList = _playList.map((music) {
      return playListItem(music);
    }).toList();
    return tempList;
  }

  jumpToCurrentPlay() {
    final _playList =
        Provider.of<PlaylistManage>(context, listen: false).playlist;
    final currentPlay =
        Provider.of<PlaylistManage>(context, listen: false).currentPlay;
    int _idx = _playList.indexOf(currentPlay);
    if (_idx < _playList.length - 10) {
      _scrollController.jumpTo(_idx * _itemHeight);
    } else {
      _scrollController.jumpTo((_playList.length - 10) * _itemHeight);
    }
  }

  Widget playListItem(DataList music) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Container(
      height: _itemHeight,
      child: new ListTile(
        title: Row(
          children: <Widget>[
            Text(
              music.name,
              style: musicTextStyle.copyWith(
                  color:
                      currentPlay.id == music.id ? Colors.red : Colors.black),
            ),
            Text(
              ' - ${music.ar[0].name}',
              style: authorTextStyle.copyWith(
                  color:
                      currentPlay.id == music.id ? Colors.red : Colors.black54),
            )
          ],
        ),
        onTap: () {
          if (currentPlay.id != music.id) {
            Provider.of<PlaylistManage>(context, listen: false)
                .setCurrentPlay(music);
          }
        },
      ),
    );
  }
}

final TextStyle currentPlayTitleTextStyle = const TextStyle(
    fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500);
final TextStyle currentPlayCountTextStyle = const TextStyle(
    fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w700);
final TextStyle musicTextStyle = const TextStyle(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300);
final TextStyle authorTextStyle = const TextStyle(
    fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w200);
