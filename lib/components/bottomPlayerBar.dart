import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:net_easy_music/components/controlButton.dart';
import 'package:net_easy_music/model/playModel_manage.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/page/play_record/playRecord.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/flutterToastManage.dart';
import 'package:net_easy_music/type/play_model.dart';
import 'package:net_easy_music/utils/paletteColor.dart';
import 'package:net_easy_music/utils/view.dart';
import 'package:provider/provider.dart';
import '../extension/duration.dart';
import 'package:assets_audio_player/assets_audio_player.dart' as audioPlayer;

class BottomControllerBar extends StatefulWidget {
  final Widget child;
  const BottomControllerBar({Key key, this.child}) : super(key: key);
  @override
  _MyPageWithAudioState createState() => _MyPageWithAudioState();
}

class _MyPageWithAudioState extends State<BottomControllerBar> {
  String _currentPosition = "00:00";
  String _totalDuration = '00:00';
  double _totalSeconds = 238.0;
  double _currentSeconds = 0.0;
  StreamSubscription _onReadyToPlaySubscription;
  StreamSubscription _currentPositionSubscription;
  StreamSubscription _currentPlaySubscription;
  int playIndex = 0;
  Color _seekBarcolor = Colors.white;
  @override
  void initState() {
    readyPlaySubScription();
    currentPositionSubScription();
    currentPlaySubScription();
    _getSeekBarColor();
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
          _getSeekBarColor();
        }
      }
    });
  }

  _getSeekBarColor() async {
    String url = context.read<PlaylistManage>().currentPlay.al.picUrl;
    _seekBarcolor = await PaletteColor().getColor(imageUrl: url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Expanded(child: widget.child),
        Material(
          elevation: 25,
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildImage(),
                _buildSeekBar(context),
                SizedBox(
                  height: 8,
                ),
                _buildPlayControl()
              ],
            ),
          ),
        ),
        SizedBox(height: media.viewInsets.bottom)
      ],
    );
  }

  Widget _buildImage() {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 40,
          height: 40,
          child: currentPlay.al.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: currentPlay.al.picUrl,
                  errorWidget: (context, url, error) =>
                      new Image.asset('assets/music1.jpg', fit: BoxFit.cover),
                  fit: BoxFit.cover)
              : new Image.asset('assets/music1.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildPlayBarAndSongInfo() {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Column(
      children: <Widget>[
        currentPlay.name.length < 16
            ? RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: currentPlay.name,
                    style: songNameStyle,
                  )
                ]),
                textAlign: TextAlign.left,
              )
            : ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200, maxHeight: 20),
                child: Marquee(
                  text: currentPlay.name,
                  pauseAfterRound: Duration(milliseconds: 500),
                  blankSpace: 20.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _buildPlayBarAndSongInfo(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(_currentPosition, style: songTimeStyle),
                Text('/', style: songTimeStyle),
                Text(_totalDuration, style: songTimeStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playSong() async {
    await AudioInstance().play();
  }

  Widget _buildPlayControl() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StreamBuilder(
              stream: AudioInstance().assetsAudioPlayer.isPlaying,
              builder: (context, snapshot) {
                bool isPlaying = snapshot.data;
                if (snapshot == null || snapshot.data == null) {
                  isPlaying = false;
                }
                if (isPlaying) {
                  return ControlButton(
                      color: Colors.black87,
                      codePoint: 0xE696,
                      onControlTaped: () => AudioInstance().pause());
                }
                return ControlButton(
                    color: Colors.black87,
                    codePoint: 0xE600,
                    onControlTaped: () => _playSong());
              }),
          // 播放记录
          ControlButton(
            color: Colors.black87,
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
    fontSize: 12, color: Colors.black, fontWeight: FontWeight.w900);

final TextStyle authorNameStyle = const TextStyle(
    fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900);

final TextStyle songTimeStyle = const TextStyle(
    fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900);
