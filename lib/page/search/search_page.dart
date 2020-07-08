import 'package:flutter/material.dart';
import 'package:net_easy_music/components/blurBackground.dart';
import 'package:net_easy_music/model/playlist_manage.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final currentPlay = Provider.of<PlaylistManage>(context).currentPlay;
    return Scaffold(
      body: SafeArea(
        child: new Stack(
          children: <Widget>[
            BlurBackground(
              imageUrl: currentPlay.al.picUrl + '?param=1440y1440',
            ),
            Column(
              children: <Widget>[
                _buildTopBar(context),
              ],
            ),
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
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
