import 'package:flutter/material.dart';
import 'package:net_easy_music/type/search_type.dart';

class SearchItem extends StatelessWidget {
  final int codePoint;
  final double size;
  final Function onTap;
  final String text;
  final Color color;
  final SearchType searchType;
  final SearchType activeSearchType;
  final double width;
  const SearchItem({
    Key key,
    @required this.codePoint,
    this.size = 15,
    this.onTap,
    this.color,
    @required this.searchType,
    this.activeSearchType,
    this.text = '',
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    icon: Icon(
                      IconData(codePoint, fontFamily: 'iconfont'),
                      color: color,
                      size: size,
                    ),
                    onPressed: null,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: activeSearchType == searchType
                        ? Colors.white60
                        : Colors.white24,
                  ),
                )
              ],
            ),
            activeSearchType == searchType
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    color: color,
                    height: 2,
                    width: 50,
                  )
                : Container(
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.transparent,
                    height: 2,
                    width: 50,
                  )
          ],
        ),
      ),
    );
  }
}
