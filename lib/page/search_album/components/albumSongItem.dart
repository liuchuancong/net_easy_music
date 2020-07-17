import 'package:flutter/material.dart';

class AlbumSongItem extends StatefulWidget {
  final int index;
  final content;
  final bool canPlay;
  const AlbumSongItem(
      {Key key,
      @required this.index,
      @required this.content,
      this.canPlay = true})
      : super(key: key);
  @override
  _SearchSongItemState createState() => _SearchSongItemState();
}

class _SearchSongItemState extends State<AlbumSongItem> {
  @override
  Widget build(BuildContext context) {
    Color _textColor = widget.canPlay ? Colors.black : Colors.black12;
    Color _indexColor = widget.canPlay ? Colors.black54 : Colors.black12;
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1, color: Colors.white.withOpacity(0.2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 25,
                  child: Text(
                    (widget.index + 1).toString(),
                    style: TextStyle(color: _indexColor, fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.content.name,
                        style: TextStyle(color: _textColor, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.red)),
                            child: Text(
                              'SQ',
                              style: TextStyle(color: Colors.red, fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.content.ar[0].name,
                            style: TextStyle(color: _textColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
