import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchType/search_type_with_singer.dart'
    as Singer;

class SearchSingerItem extends StatefulWidget {
  final int index;
  final Singer.Content content;

  const SearchSingerItem(
      {Key key, @required this.index, @required this.content})
      : super(key: key);
  @override
  _SearchSingerItemState createState() => _SearchSingerItemState();
}

class _SearchSingerItemState extends State<SearchSingerItem> {
  Widget _buildImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 60,
          width: 60,
          child: widget.content.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.content.picUrl + '?param=200y200',
                  errorWidget: (context, url, error) =>
                      new Image.asset('assets/avatar.jpg', fit: BoxFit.cover))
              : new Image.asset('assets/avatar.jpg', fit: BoxFit.cover),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildImage(),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Text(
              widget.content.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
