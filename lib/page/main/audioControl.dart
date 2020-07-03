import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:net_easy_music/components/controlButton.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';

class AudioControl extends StatefulWidget {
  const AudioControl({Key key}) : super(key: key);
  @override
  _AudioControlState createState() => _AudioControlState();
}

class _AudioControlState extends State<AudioControl> {
  String totalDuration = '00:00';
  int playIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '下落不明',
              style: songNameStyle,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '王巨星',
              style: authorNameStyle,
            ),
          ],
        ),
        // _buildSeekBar(context)
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context) {
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
                          Text(totalDuration, style: songTimeStyle),
                          Text('/', style: songTimeStyle),
                          Text(totalDuration, style: songTimeStyle),
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
                max: 100.0,
                value: 80.0,
                style: SliderStyle(
                  disableDepth: true,
                  accent: Color(0xff409eff),
                  variant: Color(0xff409eff),
                ),
                onChanged: (value) {
                  int flooredValue = value.floor();
                  int hour = (flooredValue / 3600).floor();
                  int min = (flooredValue / 60).floor();
                  int sec = (flooredValue % 60).floor();
                  print('$hour$min$sec');
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
    await AudioInstance().requestRecordAudioPermission();
    await AudioInstance().playNetWorkSong();
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
                      codePoint:0xE696,
                      onControlTaped: () => AudioInstance().pause());
                }
                return ControlButton(
                    codePoint: 0xE600, onControlTaped: () => _playSong());
              }),
          ControlButton(
            codePoint: 0xE9D4,
            onControlTaped: () => AudioInstance().next(),
          ),
          ControlButton(
            codePoint: 0xE625,
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
