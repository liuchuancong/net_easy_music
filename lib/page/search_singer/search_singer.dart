import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:net_easy_music/api/apiList.dart';
import 'package:net_easy_music/components/bottomPlayerBar.dart';
import 'package:net_easy_music/components/playAllButton.dart';
import 'package:net_easy_music/json/singerInfo/singer_info.dart';
import 'package:net_easy_music/plugin/httpManage.dart';
import 'package:net_easy_music/type/platform_type.dart';
import 'package:net_easy_music/utils/paletteColor.dart';

import 'components/singerList.dart';
import 'components/header.dart';
import 'components/tabbar.dart';

///歌单详情信息 header 高度
const double HEIGHT_HEADER = 280 + kToolbarHeight;

class SearchSinger extends StatefulWidget {
  final String platform;
  final dynamic id;
  final String singer;
  final PlatformMusic platformMusic;
  const SearchSinger(
      {Key key,
      @required this.platform,
      @required this.id,
      @required this.platformMusic,
      this.singer})
      : super(key: key);
  @override
  _SearchSingerState createState() => _SearchSingerState();
}

class _SearchSingerState extends State<SearchSinger> {
  ScrollController _controller = ScrollController();
  final maxExtent = 230.0;
  double currentExtent = 0.0;
  bool hasLoaded = false;
  Color _headerColor = Colors.black;
  SingerInfo singerInfo;
  int tabbarActiveIndex = 0;
  @override
  void initState() {
    _getSingerInfomation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLoading(BuildContext context) {
    return _buildPreview(
        context, Container(height: 200, child: Center(child: Text("加载中..."))));
  }

  Widget _buildPreview(BuildContext context, Widget content) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: HEIGHT_HEADER,
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
            color: _headerColor,
          )),
          bottom: PlayAllButton(0),
        ),
        SliverList(delegate: SliverChildListDelegate([content]))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _headerColor,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: BottomControllerBar(
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Container(
              color: Colors.white,
            )),
            hasLoaded
                ? CustomScrollView(slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: HEIGHT_HEADER,
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      elevation: 0,
                      flexibleSpace: SingerInfoHeader(
                        singerInfo: singerInfo,
                        singer: widget.singer,
                        width: MediaQuery.of(context).size.width,
                        platformMusic: widget.platformMusic,
                        headerColor: _headerColor,
                      ),
                      bottom: TabSingerBar(
                        tabBarIndex: tabbarActiveIndex,
                        onTap: (i) {
                          setState(() {
                            tabbarActiveIndex = i;
                          });
                        },
                      ),
                    ),
                    SingerSongList(
                      id: widget.id.toString(),
                      platformMusic: widget.platformMusic,
                    )
                  ])
                : _buildLoading(context),
          ],
        ),
      )),
    );
  }

  _getSingerInfomation() async {
    // 获取专辑信息
    Map<String, dynamic> searchMap = {
      '_p': widget.platform,
      'id': widget.id,
      '_t': const Duration().inMicroseconds.toString()
    };
    final Response response =
        await HttpManager().get(apiList['SINGER_INFO'], data: searchMap);
    SingerInfo _singerInfo = SingerInfo.fromJson(response.data);
    String imagePath = widget.platformMusic == PlatformMusic.MIGU ? 'http:' + _singerInfo.data.picUrl : _singerInfo.data.picUrl;
    _headerColor = await PaletteColor().getMutiColor(imageUrl: imagePath);
    if (mounted) {
      setState(() {
        singerInfo = _singerInfo;
        hasLoaded = true;
      });
    }
  }
}
