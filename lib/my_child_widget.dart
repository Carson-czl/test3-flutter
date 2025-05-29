import 'package:flutter/material.dart';

class MyChildWidget extends StatefulWidget {
    // 定义一些参数，子组件通过构造函数接收
  final String message;
  final int count;
  const MyChildWidget({super.key, required this.message, required this.count});

  @override
  MyChildWidgetState createState() => MyChildWidgetState();

}

class MyChildWidgetState extends State<MyChildWidget> {
  
  // 子组件方法，供父组件调用
  void myMethod() {
    print("子组件的方法被调用");
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("这是子组件"),
    );
  }
}
