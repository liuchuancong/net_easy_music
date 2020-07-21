//因为歌曲有过期时间  大概是30分钟  所以  做一个刷新当前歌单的播放地址工具类





class  SongExpired{
  int _songInitTime;
  //1秒等于1000毫秒 1分钟等于60秒 20*60*1000=1200000毫秒
  static int expires = 900000; //15分钟
  int get songInitTime => _songInitTime;
  int get expiresTime => _songInitTime + expires;
  set songInitTime(int time) => this._songInitTime = time;
}

  final SongExpired songExpired = new SongExpired();