import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class LightView extends StatefulWidget {
  const LightView({super.key});

  @override
  State<LightView> createState() => LightViewState();
}

class LightViewState extends State<LightView> {
  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'confview' && mounted) {
        save();
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'confview' && mounted) {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'confview' && mounted) {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'confview' && mounted) {
        refresh();
      }
    });
  }

  Future<void> save() async {
    if (!mounted) {
      return;
    }
    try {
      // TODO：刷新
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green[200],
            duration: const Duration(seconds: 1),
            content: const Text('轻代码已存储',
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
            content: Text('轻代码存储失败: $e',
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
            content: const Text('轻代码结构已刷新',
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
            content: Text('轻代码刷新失败: $e',
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
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Brilliance Light Mode',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: 'dingtalk',
                    decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 20,
              ),
              Text('超清凉的轻代码模式，点击项目中的任意文件打开！',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'dingtalk',
                    color: Colors.black54,
                  ))
            ],
          ),
        ));
  }
}
