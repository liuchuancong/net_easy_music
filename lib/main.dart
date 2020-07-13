import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:net_easy_music/utils/cookie.dart';
import 'package:provider/provider.dart';

import 'model/drawer_manage.dart';
import 'model/playModel_manage.dart';
import 'model/playlist_manage.dart';
import 'page/my_home_page/my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.black);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
  cookieMange.cookieInitTime = DateTime.now().millisecondsSinceEpoch;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DrawerManage()),
    ChangeNotifierProvider(create: (_) => PlaylistManage()),
    ChangeNotifierProvider(create: (_) => PlayModelManage()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NetEasyMusic',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
