import 'dart:io';

import 'package:demo/home.dart';
import 'package:demo/home_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

void main() {
  // 进制横屏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
    if (Platform.isAndroid) {
      //设置Android头部的导航栏透明
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppbar(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          selectedItemColor: Colors.black,
          items: navBarItems),
    );
  }

  // APPBar
  PreferredSizeWidget createAppbar() {
    return AppBar(
      title: Text('MGlobal Photo'),
      elevation: 0, //隐藏底部阴影分割线
      leading: Builder(builder: (ctx) {
        return IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            });
      }),
      actions: [
        // 分享
        IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('check out my website https://example.com');
              if (Platform.isAndroid) {
              } else {
                Share.share(
                    "分享当前应用 http://itunes.apple.com/cn/app/id1571237171?mt=8");
              }
            })
      ],
    );
  }
}

class MyNavBarItem extends BottomNavigationBarItem {
  MyNavBarItem(String title, IconData icon, IconData activeIcon)
      : super(
            label: title,
            icon: Icon(icon),
            activeIcon: Icon(
              activeIcon,
            ));
}

List<BottomNavigationBarItem> navBarItems = [
  MyNavBarItem("home", Icons.home, Icons.home_outlined),
  MyNavBarItem("video", Icons.play_circle_fill, Icons.play_circle_outline),
  MyNavBarItem("banner", Icons.view_headline, Icons.view_headline),
];

List<Widget> pages = [
  HomePage(),
  HomePage(),
  HomePage(),
];
