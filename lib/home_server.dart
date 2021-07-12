import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HomeServer{
    // 解析HTML数据，拿妹子图举例
  static Future<List> zuixinhtml() async {
    // 发起请求获取首页的html数据
    Response res = await Dio().get("https://www.mzitu.com/");
    // 将数据解析成Document
    Document doc = parse(res.data);
    
   final List anchors = [];

    // 获取到id为pins的对象，从pins中获取li标签，返回数组
    List datas = doc.getElementById("pins")!.getElementsByTagName("li");
      for (var item in datas) {
        String title = item.getElementsByTagName("img")[0].attributes["alt"];
        String linkurl = item.getElementsByTagName("a")[0].attributes["href"];
        String imgUrl = item.getElementsByTagName("img")[0].attributes["data-original"];
        Anchor anchor = Anchor(userName: title,linkUrl: linkurl,headerIcon: imgUrl);
        anchors.add(anchor);
      }
      return anchors;
  }

    static void hothtml() async {
    // 发起请求获取首页的html数据
    Response res = await Dio().get("https://www.mzitu.com/hot/");
    // 将数据解析成Document
    Document doc = parse(res.data);
    // 获取到id为pins的对象，从pins中获取li标签，返回数组
    List datas = doc.getElementById("pins")!.getElementsByTagName("li");
      for (var item in datas) {
        // 输出html标签内容  
        print(item.outerHtml);
        // 根据名字获取 a 标签，返回数组
        print(item.getElementsByTagName("a")[0]);
        // 根据名字获取 img 标签，从img标签中获取具体的描述
        print(item.getElementsByTagName("img")[0].attributes["data-original"]);
      }
  }
  
}



class UserInfo{
   String userName; 
   String headerIcon;
   String thumb; // 缩略图
   String linkUrl;
  UserInfo({this.userName = "",this.headerIcon = "",this.thumb = "",this.linkUrl = ""});
}

class Anchor extends UserInfo{
  String liveAddres;  // 直播地址
  Anchor({this.liveAddres = "",String userName = "", String headerIcon = "",String thumb = "",String linkUrl = ""}) : super(userName:userName, headerIcon:headerIcon,thumb: thumb,linkUrl: linkUrl);
}