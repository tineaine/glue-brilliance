import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:highlight/languages/json.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class Codeview extends StatefulWidget {
  const Codeview({super.key});

  @override
  State<Codeview> createState() => CodeviewState();
}

class CodeviewState extends State<Codeview> {
  late CodeController _codeController;

  String path = "";

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'codeview' && mounted) {
        save();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green[200],
              duration: const Duration(seconds: 1),
              content: const Text('代码已存储',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'dingtalk'))),
        );
      }
    });
    eventBus.on<RedoEvent>().listen((event) {
      if (event.types == 'codeview' && mounted) {
        redo();
      }
    });
    eventBus.on<UndoEvent>().listen((event) {
      if (event.types == 'codeview' && mounted) {
        undo();
      }
    });
    eventBus.on<RefreshEvent>().listen((event) {
      if (event.types == 'codeview' && mounted) {
        refresh();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.blue[200],
              duration: const Duration(seconds: 1),
              content: const Text('代码已刷新',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'dingtalk'))),
        );
      }
    });
    eventBus.on<OpenEvent>().listen((event) {
      if (mounted) {
        open(event);
      }
    });
    _codeController = CodeController(
      text: '',
      language: json,
    );
    _readFile();
  }

  open(OpenEvent event) {
    if (!mounted) {
      return;
    }
    // 检查当前是否有未保存的修改
    // 设置当前打开的文件
    path = event.path;
    // 调用刷新方法，刷新视图
    setState(() {
      refresh();
    });
  }

  refresh() {
    if (!mounted) {
      return;
    }
    try {
      _readFile();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[200],
            duration: const Duration(seconds: 1),
            content: Text('代码刷新失败: $e',
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
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _readFile() async {
    if (path == "") {
      return;
    }

    try {
      final file = File(path);
      final content = await file.readAsString();
      setState(() {
        _codeController.text = content;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[200],
            duration: const Duration(seconds: 1),
            content: Text('文件读取失败: $e',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
      setState(() {});
    }
  }

  Future<void> save() async {
    if (!mounted) {
      return;
    }
    try {
      final file = File(path);
      await file.writeAsString(_codeController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red[200],
            duration: const Duration(seconds: 1),
            content: Text('代码存储失败: $e',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'dingtalk'))),
      );
    }
  }

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
                    'Brilliance Code Mode',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontFamily: 'dingtalk',
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('原生代码模式，以源代码形式打开文件，不建议通过此功能修改',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'dingtalk',
                        color: Colors.black54,
                      ))
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: CodeTheme(
                        data: CodeThemeData(styles: xcodeTheme),
                        child: SingleChildScrollView(
                          child: CodeField(
                            controller: _codeController,
                          ),
                        ),
                      ),
                      // child: CodeField(
                      //   controller: _codeController,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
