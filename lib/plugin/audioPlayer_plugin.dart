import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioInstance {
  // 单例公开访问点
  factory AudioInstance() => _getInstance();
  bool get isPlay => assetsAudioPlayer.isPlaying.value;
  Playlist get playList => assetsAudioPlayer.playlist;
  // 静态私有成员，没有初始化
  static AudioInstance _instance;
  static AudioInstance get instance => _getInstance();
  AssetsAudioPlayer assetsAudioPlayer;
  // 私有构造函数
  AudioInstance._internal() {
    assetsAudioPlayer = AssetsAudioPlayer.withId('flutter_assets_audio_player');
  }

  // 静态、同步、私有访问点
  static AudioInstance _getInstance() {
    if (_instance == null) {
      _instance = AudioInstance._internal();
    }
    return _instance;
  }

  static Audio _audio;
  // 申请存储权限
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request();
    }
  }

  // 申请录音权限
  Future<void> requestRecordAudioPermission() async {
    var status = await Permission.microphone.status;
    if (status.isUndetermined) {
      await Permission.microphone.request();
    }
  }

  //jsut test
  Future<void> playNetWorkSong() async {
    final String songUrl1 =
        'http://m7.music.126.net/20200ss710172914/6c13764b11e6b3c58f14e9788a5fa04d/ymusic/09b4/ed81/9c64/cd14a6c96d11c32f50784e0c9d93fe3e.mp3';
    Playlist _playlist = new Playlist();
    _playlist.add(new Audio.network(songUrl1));
    await assetsAudioPlayer.open(_playlist);
  }

  Future<void> initAudio(song) async {
    if (isPlay) {
      stop();
    }
    try {
      _audio = Audio.network(
        song.url,
        metas: Metas(
          title: song.name,
          artist: song.artists[0].name,
          album: song.album.name,
          image:
              MetasImage.network(song.album.picUrl), //can be MetasImage.network
        ),
      );
      await assetsAudioPlayer.open(_audio, showNotification: true);
      updateMetas(song);
    } catch (t) {
      //mp3 unreachable
    }
  }

  Future<void> initFileAudio(String url, song) async {
    if (isPlay) {
      stop();
    }

    try {
      _audio = Audio.file(
        url,
        metas: Metas(
          title: song.name,
          artist: song.artists[0].name,
          album: song.album.name,
          image:
              MetasImage.network(song.album.picUrl), //can be MetasImage.network
        ),
      );
      await assetsAudioPlayer.open(_audio, showNotification: true);
      updateMetas(song);
    } catch (t) {
      //mp3 unreachable
    }
  }

  Future<void> initPlaylist(Playlist playlist) async {
    if (isPlay) {
      stop();
    }
    try {
      await assetsAudioPlayer.open(playlist,
          showNotification: true, autoStart: false);
    } catch (t) {
      //mp3 unreachable
    }
  }

  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "请先添加歌曲",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  updateMetas(song) {
    if (_audio != null) {
      _audio.updateMetas(
        title: song.name,
        artist: song.artists[0].name,
        album: song.album.name,
        image: MetasImage.network(song.album.picUrl), //c
      );
    }
  }

  Future<void> seekBy(Duration by) async {
    await assetsAudioPlayer.seekBy(by);
  }

  Future<void> add(Audio audio) async {
    assetsAudioPlayer.playlist.add(audio);
  }

  Future<void> addAll(List<Audio> audio) async {
    assetsAudioPlayer.playlist.addAll(audio);
  }

  Future<void> reMoveAtIndex(int index) async {
    assetsAudioPlayer.playlist.removeAtIndex(index);
  }

  Future<void> playlistPlayAtIndex(int index) async {
    await assetsAudioPlayer.playlistPlayAtIndex(index);
  }

  Future<void> seek(Duration by) async {
    await assetsAudioPlayer.seek(by);
  }

  Future<void> playOrPause() async {
    await assetsAudioPlayer.playOrPause();
  }

  Future<void> play() async {
    await assetsAudioPlayer.play();
  }

  Future<void> pause() async {
    await assetsAudioPlayer.pause();
  }

  Future<void> stop() async {
    await assetsAudioPlayer.stop();
  }

  Future<void> next() async {
    await assetsAudioPlayer.next();
  }

  Future<void> prev() async {
    await assetsAudioPlayer.previous();
  }

  Future<void> dispose() async {
    await assetsAudioPlayer.dispose();
  }
}
