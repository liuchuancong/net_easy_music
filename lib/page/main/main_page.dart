import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/json/playlist.dart';
import 'package:net_easy_music/json/recommend_playlist.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:net_easy_music/plugin/audioPlayer_plugin.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:provider/provider.dart';
import 'package:net_easy_music/model/drawer_manage.dart';
import 'audioControl.dart';
import 'my_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription _sessionIdsubscription;
  StreamSubscription _playStatesubscription;
  @override
  void initState() {
    AudioInstance().requestRecordAudioPermission();
    getRecommendPlaylist();
    super.initState();
  }

  @override
  void dispose() {
    _sessionIdsubscription.cancel();
    _playStatesubscription.cancel();
    super.dispose();
  }

  getRecommendPlaylist() async {
    final Response response = await HttpManager()
        .get(apiList['RECOMMEND_PLAYLIST'], data: {'login': 0, '_p': 163});
    final _playlist = RecommendPlaylist.fromJson(response.data);
    if (_playlist.result == 100) {
      getPlaylist(_playlist.data[0].id);
    }
  }

  getPlaylist(id) async {
    final Response response = await HttpManager()
        .get(apiList['PLAYLIST'], data: {'id': id, '_p': 163});
    final _playlist = Playlist.fromJson(response.data);
    if (_playlist.result == 100) {
      context.read<PlaylistManage>().setPlaylist(_playlist.data.list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(callback: _onDrawerOpenOrClose),
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            BlurBackground(),
            Column(
              children: <Widget>[
                _buildTopBar(context),
                Expanded(child: Container()),
                AudioControl()
              ],
            ),
            // AudioControl()
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: const EdgeInsets.all(18.0),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Provider.of<DrawerManage>(context).isOpen
                    ? Colors.transparent
                    : Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  _onDrawerOpenOrClose(state) {
    if (state) {
      Future.delayed(Duration(seconds: 0), () {
        Provider.of<DrawerManage>(context, listen: false).openDrawer();
      });
    } else {
      Future.delayed(Duration(seconds: 0), () {
        Provider.of<DrawerManage>(context, listen: false).closeDrawer();
      });
    }
  }
}
