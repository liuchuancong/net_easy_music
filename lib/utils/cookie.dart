class CookieMange {
  int _cookieInitTime;
  static int expires = 1800000;
  int get cookieInitTime => _cookieInitTime;
  int get expiresTime => _cookieInitTime + expires;
  set cookieInitTime(int time) => this._cookieInitTime = time;
}
  final CookieMange cookieMange = new CookieMange();