import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../common/canvas/canvas.dart';
import '../../../event/design.dart';
import '../../../event/event.dart';

class BlueprintView extends StatefulWidget {
  const BlueprintView({super.key});

  @override
  State<BlueprintView> createState() => BlueprintViewState();
}

class BlueprintViewState extends State<BlueprintView> {
  String path = "";

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'blueprint' && mounted) {
        save();
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'blueprint' && mounted) {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'blueprint' && mounted) {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'blueprint' && mounted) {
        refresh();
      }
    });

    eventBus.on<OpenEvent>().listen((event) {
      if (event.types == 'blueprint' && mounted) {
        open(event);
      }
    });
  }



  open(OpenEvent event) {
    setState(() {
      path = event.path;
    });
  }

  Future<void> save() async {
    if (!mounted) {
      return;
    }
    try {
      // TODO：存储蓝图
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green[200],
            duration: const Duration(seconds: 1),
            content: const Text('蓝图已存储',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[200],
            duration: const Duration(seconds: 1),
            content: Text('蓝图存储失败: $e',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
    }
  }

  refresh() {
    if (!mounted) {
      return;
    }
    try {
      // TODO：刷新
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.blue[200],
            duration: const Duration(seconds: 1),
            content: const Text('蓝图已刷新',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[200],
            duration: const Duration(seconds: 1),
            content: Text('蓝图刷新失败: $e',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
    }
  }

  undo() {}

  redo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: path == ""
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Brilliance Blueprint',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontFamily: 'dingtalk',
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('未打开任何文件，在右侧项目中打开第一个蓝图吧！',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'dingtalk',
                          color: Colors.black54,
                        ))
                  ],
                ),
              )
            : MainCanvas());
  }
}
