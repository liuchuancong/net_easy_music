import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchType/search_type_with_playlist.dart'
    as Playlist;
import 'package:net_easy_music/type/platform_type.dart';

class SearchPlaylistItem extends StatefulWidget {
  final int index;
  final Playlist.Content content;
  final PlatformMusic platform;
  const SearchPlaylistItem(
      {Key key, @required this.index, @required this.content, this.platform})
      : super(key: key);
  @override
  _SearchPlaylistItemState createState() => _SearchPlaylistItemState();
}

class _SearchPlaylistItemState extends State<SearchPlaylistItem> {
  Widget _buildImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 65,
          width: 65,
          child: widget.content.cover != null
              ? new CachedNetworkImage(
                  imageUrl: widget.content.cover + '?param=120y120',
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            right: 10,
            top: 10,
            child: Text(
              widget.content.trackCount.toString(),
              style:
                  TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 40),
              overflow: TextOverflow.ellipsis,
            )),
        Container(
          height: 90,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Colors.white.withOpacity(0.2)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildImage(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        child: Text(
                          widget.content.name,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 20),
                        child: Row(
                          children: <Widget>[
                            if(widget.platform != PlatformMusic.MIGU)
                            Expanded(
                              child: Container(
                                child: Text(
                                  'By: ${widget.content.creator.nick}',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if(widget.platform != PlatformMusic.MIGU)
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  IconData(0xE601, fontFamily: 'iconfont'),
                                  color: Colors.white.withAlpha(158),
                                  size: 15,
                                ),
                                Text(
                                  ': ${(widget.content.playCount / 1000).toStringAsFixed(1)}k',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
