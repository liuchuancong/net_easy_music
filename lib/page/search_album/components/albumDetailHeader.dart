import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumDetailHeader extends StatelessWidget {
  const AlbumDetailHeader(
      {Key key,
      this.onCommentTap,
      this.onShareTap,
      this.onSelectionTap,
      int commentCount = 0,
      int shareCount = 0,
      this.background})
      : this.commentCount = commentCount ?? 0,
        this.shareCount = shareCount ?? 0,
        super(key: key);

  final GestureTapCallback onCommentTap;
  final GestureTapCallback onShareTap;
  final GestureTapCallback onSelectionTap;

  final int commentCount;
  final int shareCount;

  final Widget background;

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _HeaderAction(
                      Icons.comment,
                      commentCount > 0 ? commentCount.toString() : "评论",
                      onCommentTap),
                  _HeaderAction(
                      Icons.share,
                      shareCount > 0 ? shareCount.toString() : "分享",
                      onShareTap),
                  _HeaderAction(Icons.file_download, '下载', null),
                  _HeaderAction(Icons.check_box, "多选", onSelectionTap),
                ],
              ),
            ],
          ),
        );
  }
}


class _HeaderAction extends StatelessWidget {
  _HeaderAction(this.icon, this.action, this.onTap);

  final IconData icon;

  final String action;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;

    return InkResponse(
      onTap: onTap,
      splashColor: textTheme.bodyText2.color,
      child: Opacity(
        opacity: onTap == null ? 0.6 : 1,
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: textTheme.bodyText2.color,
            ),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Text(
              action,
              style: textTheme.caption.copyWith(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}