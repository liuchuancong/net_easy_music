import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:net_easy_music/components/controlButton.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/page/play_record/playRecord.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:provider/provider.dart';
import '../../extension/duration.dart';
import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;

class AudioControl extends StatefulWidget {
  const AudioControl({Key key}) : super(key: key);
  @override
  _AudioControlState createState() => _AudioControlState();
}

class _AudioControlState extends State<AudioControl> {
  String _currentPosition = "00:00";
  String _totalDuration = '00:00';
  double _totalSeconds = 238.0;
  double _currentSeconds = 0.0;
  StreamSubscription _onReadyToPlaySubscription;
  StreamSubscription _currentPositionSubscription;
  StreamSubscription _currentPlaySubscription;
  int playIndex = 0;
  @override
  void initState() {
    readyPlaySubScription();
    currentPositionSubScription();
    currentPlaySubScription();
    super.initState();
  }

  @override
  void dispose() {
    _onReadyToPlaySubscription.cancel();
    _currentPositionSubscription.cancel();
    _currentPlaySubscription.cancel();
    super.dispose();
  }

  readyPlaySubScription() {
    _onReadyToPlaySubscription =
        AudioInstance().assetsAudioPlayer.onReadyToPlay.listen((event) {
      if (event != null && event.duration != null) {
        setState(() {
          _currentPosition = "${Duration().mmSSFormat}";
          _totalDuration = event.duration.mmSSFormat;
          _totalSeconds = event.duration.inSeconds.toDouble();
        });
      }
    });
  }

  currentPositionSubScription() {
    _currentPositionSubscription =
        AudioInstance().assetsAudioPlayer.currentPosition.listen((event) {
      if (event != null) {
        setState(() {
          _currentPosition = "${event.mmSSFormat}";
          _currentSeconds = event.inSeconds.toDouble();
        });
      }
    });
  }

  currentPlaySubScription() {
    _currentPlaySubscription = AudioInstance()
        .assetsAudioPlayer
        .realtimePlayingInfos
        .listen((audioPlayer.RealtimePlayingInfos event) {
      if (event.current != null && event.current.index != null) {
        if (playIndex != event.current.index) {
          playIndex = event.current.index;
          context.read<PlaylistManage>().setCurrentPlay(
              context.read<PlaylistManage>().playlist[playIndex]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 20.0),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            _buildUserControl(),
            SizedBox(
              height: 8,
            ),
            _buildSeekBar(context),
            SizedBox(
              height: 8,
            ),
            _buildPlayControl()
          ],
        ));
  }

  Widget _buildPlayBarAndSongInfo() {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              currentPlay.name,
              style: songNameStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              currentPlay.ar[0].name,
              style: authorNameStyle,
            ),
          ],
        ),
        // _buildSeekBar(context)
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
    var theme = Theme.of(context).primaryTextTheme;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: _buildPlayBarAndSongInfo()),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(_currentPosition, style: songTimeStyle),
                          Text('/', style: songTimeStyle),
                          Text(_totalDuration, style: songTimeStyle),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              NeumorphicSlider(
                height: 5.0,
                min: 0.0,
                max: _totalSeconds,
                value: _currentSeconds,
                style: SliderStyle(
                    disableDepth: true,
                    thumbBorder: NeumorphicBorder(
                      color: theme.bodyText2.color.withOpacity(0.75),
                      width: 4.0
                    ),
                    accent: theme.bodyText2.color.withOpacity(0.75),
                    variant: theme.caption.color.withOpacity(0.3)),
                onChanged: (value) {
                  int flooredValue = value.floor();
                  int hour = (flooredValue / 3600).floor();
                  int min = (flooredValue / 60).floor();
                  int sec = (flooredValue % 60).floor();
                  AudioInstance()
                      .seek(Duration(minutes: min, seconds: sec, hours: hour));
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserControl() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ControlButton(
            codePoint: 0xE6C9,
          ),
          ControlButton(
            codePoint: 0xE638,
          ),
          ControlButton(
            codePoint: 0xE634,
          ),
          ControlButton(
            codePoint: 0xE628,
          ),
          ControlButton(
            codePoint: 0xE6B3,
          ) // icon-2
        ],
      ),
    );
  }

  Future<void> _playSong() async {
    await AudioInstance().play();
  }

  Widget _buildPlayControl() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ControlButton(
            codePoint: 0xE602,
          ),
          ControlButton(
            codePoint: 0xE9D3,
            onControlTaped: () => AudioInstance().prev(),
          ),
          // 播放按键
          StreamBuilder(
              stream: AudioInstance().assetsAudioPlayer.isPlaying,
              builder: (context, snapshot) {
                bool isPlaying = snapshot.data;
                if (snapshot == null || snapshot.data == null) {
                  isPlaying = false;
                }
                if (isPlaying) {
                  return ControlButton(
                      codePoint: 0xE696,
                      onControlTaped: () => AudioInstance().pause());
                }
                return ControlButton(
                    codePoint: 0xE600, onControlTaped: () => _playSong());
              }),
          ControlButton(
            codePoint: 0xE9D4,
            onControlTaped: () => AudioInstance().next(),
          ),
          // 播放记录
          ControlButton(
            codePoint: 0xE625,
            onControlTaped: () =>
                BottomPopupRecord().showCard(context: context),
          ) // icon-2
        ],
      ),
    );
  }
}

final TextStyle songNameStyle = const TextStyle(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900);

final TextStyle authorNameStyle = const TextStyle(
    fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w900);

final TextStyle songTimeStyle = const TextStyle(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900);
