import 'package:demo/home_server.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List _tabs = ["热门", "最新", "街拍"];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            tabs: _tabs.map((e) => Text(e)).toList(),
            controller: _tabController,
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
                controller: _tabController,
                children: _tabs.map((e) {
                  return Text(e);
                }).toList()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Text(""),onPressed: (){
        HomeServer.zuixinhtml();
      },),
    );
  }
}
