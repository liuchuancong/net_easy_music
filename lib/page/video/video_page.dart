import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/services/getVideoPath.dart';

// import 'custom_ui.dart';
class VideoScreen extends StatefulWidget {
  final VideoModel video;

  VideoScreen({@required this.video});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    if (widget.video.brs480 != null) {
      await player
          .setDataSource(widget.video.brs480, autoPlay: true, showCover: true)
          .catchError((e) {
        print("setDataSource error: $e");
      });
    } else {
      await player
          .setDataSource(widget.video.brs240, autoPlay: true, showCover: true)
          .catchError((e) {
        print("setDataSource error: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FijkAppBar.defaultSetting(title: "播放"),
      body: Container(
        child: Center(
          child: FijkView(
              color: Colors.black,
              player: player,
              cover: NetworkImage(widget.video.cover),
              panelBuilder: fijkPanel2Builder(snapShot: true),
              fsFit: FijkFit.fill),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}

class FijkAppBar extends StatelessWidget implements PreferredSizeWidget {
  FijkAppBar({Key key, @required this.title, this.actions}) : super(key: key);

  final String title;
  final List<Widget> actions;

  FijkAppBar.defaultSetting({Key key, @required this.title}) : actions = null;
  // todo settings page
  //: actions=<Widget>[SettingMenu()];

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        title: Text(this.title),
        actions: this.actions,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      preferredSize: preferredSize,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45.0);
}
