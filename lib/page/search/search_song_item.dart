import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchType/search_type_with_song.dart'
    as Song;
import 'package:net_easy_music/page/search/wave.dart';
import 'package:net_easy_music/page/search/wave_config.dart';

class SearchSongItem extends StatefulWidget {
  final int index;
  final Song.Content content;

  const SearchSongItem({Key key, @required this.index, @required this.content})
      : super(key: key);
  @override
  _SearchSongItemState createState() => _SearchSongItemState();
}

class _SearchSongItemState extends State<SearchSongItem> {
  Widget _buildImage() {
    return Image(
      image: widget.content.al.picUrl != null
          ? CachedNetworkImageProvider(
              widget.content.al.picUrl.toString() + '?param=120y120',
            )
          : new AssetImage('music2.jpg'),
      fit: BoxFit.cover,
      height: 40,
      width: 40,
      gaplessPlayback: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.index == 1)
          RotatedBox(
            quarterTurns: 45,
            child: Container(
              height: double.infinity,
              width: 90,
              child: WaveWidget(
                wavePhase: 50,
                config: CustomConfig(
                  colors: [
                    Color.fromRGBO(64, 158, 255, 0.6),
                    HSLColor.fromAHSL(0.13, 0, 0, 1).toColor()
                  ],
                  durations: [4000, 3000],
                  heightPercentages: [0.20, 0.21],
                ),
                backgroundColor: Colors.transparent,
                size: Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
          ),
        Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Colors.white.withOpacity(0.2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 25,
                      child: Text(
                        (widget.index + 1).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    _buildImage(),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 150,
                      child: Text(
                        widget.content.name,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: null)
            ],
          ),
        ),
      ],
    );
  }
}
