import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/json/searchType/search_type_with_album.dart'
    as Album;

class SearchAlbumItem extends StatefulWidget {
  final int index;
  final Album.Content content;

  const SearchAlbumItem({Key key, @required this.index, @required this.content})
      : super(key: key);
  @override
  _SearchAlbumItemState createState() => _SearchAlbumItemState();
}

class _SearchAlbumItemState extends State<SearchAlbumItem> {
  Widget _buildImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 100,
          height: 100,
          child: widget.content.picUrl != null
              ? new CachedNetworkImage(
                  imageUrl: widget.content.picUrl + '?param=200y200',
                  errorWidget: (context, url, error) => new Image.asset(
                      'assets/menu_cover.jpg',
                      fit: BoxFit.cover))
              : new Image.asset('assets/menu_cover.jpg', fit: BoxFit.cover),
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Text(
              widget.content.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
