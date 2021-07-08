import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class HomeServer{
    // 解析HTML数据，拿妹子图举例
  static void testhtml() async {
    // 发起请求获取首页的html数据
    Response res = await Dio().get("https://www.mzitu.com/best");
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