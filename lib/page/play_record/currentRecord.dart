import 'package:flutter/material.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
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
    if (_idx < _playList.length - 4 && _idx > 4) {
      _scrollController.jumpTo((_idx - 4) * _itemHeight);
    } else if (_idx < _playList.length - 4 && _idx <= 4) {
      _scrollController.jumpTo(0 * _itemHeight);
    } else if (_idx >= _playList.length - 4) {
      _scrollController.jumpTo((_playList.length - 10) * _itemHeight);
    }
  }

  Widget playListItem(DataList music) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Container(
      height: _itemHeight,
      child: new ListTile(
        title: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: music.name,
                  style: musicTextStyle.copyWith(
                      color: currentPlay.id == music.id
                          ? Colors.red
                          : Colors.black)),
              TextSpan(
                  text: ' - ${music.ar[0].name}',
                  style: authorTextStyle.copyWith(
                      color: currentPlay.id == music.id
                          ? Colors.red
                          : Colors.black54)),
            ]),
            textAlign: TextAlign.left),
        onTap: () {
          if (currentPlay.id != music.id) {
            Provider.of<PlaylistManage>(context, listen: false)
                .setCurrentPlay(music);
            int idx =
                Provider.of<PlaylistManage>(context, listen: false).playlist.indexOf(music);
            AudioInstance().playlistPlayAtIndex(idx);
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
