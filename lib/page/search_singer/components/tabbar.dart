import 'package:flutter/material.dart';

class TabSingerBar extends StatelessWidget implements PreferredSizeWidget {
  TabSingerBar({this.tabBarIndex, this.onTap});

  final int tabBarIndex;
  final Function onTap;
  Widget _buildSearchType(BuildContext context) {
    List<Widget> buttonGroup = [];
    List<int> iconList = [0xE6E2, 0xE661, 0xE609];
    List<Color> itemColors = [
      Color(0xfff56c6c),
      Color(0xff409eff),
      Color(0xffe6a23c)
    ];
    List<String> searchTypeName = ['热门歌曲', '歌手专辑', '相似歌手'];
    for (var i = 0; i < searchTypeName.length; i++) {
      buttonGroup.add(Container(
        width: (MediaQuery.of(context).size.width - 50) / 3,
        child: new SingerTabBarItem(
          width: (MediaQuery.of(context).size.width - 50) / 3,
          codePoint: iconList[i],
          index: i,
          selectIndex: tabBarIndex,
          color: itemColors[i],
          text: searchTypeName[i],
          onTap: ()=>this.onTap(i),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttonGroup,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        child: SizedBox.fromSize(
          size: preferredSize,
          child: _buildSearchType(context),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class SingerTabBarItem extends StatelessWidget {
  final int codePoint;
  final double size;
  final Function onTap;
  final String text;
  final Color color;
  final double width;
  final int index;
  final int selectIndex;
  const SingerTabBarItem({
    Key key,
    @required this.codePoint,
    this.size = 15,
    this.onTap,
    this.color,
    this.text = '',
    this.width,
    this.index,
    this.selectIndex,
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
                    color: color,
                  ),
                )
              ],
            ),
            selectIndex == index
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    color: color,
                    height: 2,
                    width: 78,
                  )
                : Container(
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.transparent,
                    height: 2,
                    width: 78,
                  )
          ],
        ),
      ),
    );
  }
}
