import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/xcode.dart';
import 'package:highlight/languages/json.dart';

import '../../../event/design.dart';
import '../../../event/event.dart';

class Codeview extends StatefulWidget {
  final String filePath;

  const Codeview({super.key, required this.filePath});

  @override
  State<Codeview> createState() => CodeviewState();
}

class CodeviewState extends State<Codeview> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    // 订阅存储方法触发事件
    eventBus.on<SaveEvent>().listen((event) {
      if (event.types == 'codeview' && mounted) {
        save();
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
      }
    });

    _codeController = CodeController(
      text: '',
      language: json,
    );
    _readFile();
  }

  refresh() {
    if(!mounted){
      return;
    }
    try {
      _readFile();
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

  undo() {

  }

  redo() {}

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _readFile() async {
    try {
      final file = File(widget.filePath);
      final content = await file.readAsString();
      setState(() {
        _codeController.text = content;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> save() async {
    if(!mounted){
      return;
    }
    try {
      final file = File(widget.filePath);
      await file.writeAsString(_codeController.text);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
