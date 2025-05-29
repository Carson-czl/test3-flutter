
import 'package:flutter/material.dart';

class DraggableScrollableSheetPage extends StatefulWidget {
  const DraggableScrollableSheetPage({Key? key}) : super(key: key);

  @override
  State<DraggableScrollableSheetPage> createState() =>
      _DraggableScrollableSheetPageState();
}

class _DraggableScrollableSheetPageState
    extends State<DraggableScrollableSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DraggableScrollableSheet")),
      body: Stack(
        children: [
          Column(children: [Container(color: Colors.grey, height: 400)]),
          _buildDraggableScrollableSheet()
        ],
      ),
    );
  }

  Widget _buildDraggableScrollableSheet() {
    return DraggableScrollableSheet(
      ////注意 maxChildSize >= initialChildSize >= minChildSize
      //初始化占用父容器高度
      initialChildSize: 0.5,
      //占用父组件的最小高度
      minChildSize: 0.25,
      //占用父组件的最大高度
      maxChildSize: 1,
      //是否应扩展以填充其父级中的可用空间默认true 父组件是Center时设置为false,才会实现center布局，但滚动效果是向两边展开
      expand: true,
      //true：触发滚动则滚动到maxChildSize或者minChildSize，不在跟随手势滚动距离 false:滚动跟随手势滚动距离
      snap: false,
      // 当snapSizes接收的是一个数组[],数组内的数字必须是升序，而且取值范围必须在 minChildSize,maxChildSize之间
      //作用是可以控制每次滚动部件占父容器的高度，此时expand: true,
      // snapSizes: [ 0.3, 0.4, 0.8],
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.teal[100],
          child: ListView.builder(
            controller: scrollController,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Center(child: Text('$index')));
            },
          ),
        );
      },
    );
  }
}
